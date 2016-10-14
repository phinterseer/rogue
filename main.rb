#! /usr/bin/env ruby

require 'faraday'
require 'json'
require 'time'

class CWQuery

  attr_accessor :connection, :movies, :cinema, :date, :screening_types, :response, :response_json

  def initialize
    self.connection = Faraday.new(:url => 'https://www.cineworld.co.uk') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    set_defaults
  end

  def set_defaults
    @cinema = 1010808
    @date = Date.today.to_time
    @screening_types = "2D,3D,IMAX,ViP,DBOX,4DX,M4J"
  end

  def date= datestring
    @date = Time.parse(datestring)
  end

  def date_for_query
    date.to_i*1000
  end

  def get_movies_for_date datestring
    self.date = datestring

    @response = connection.get '/pgm-site', {si: cinema, max: 365, bd: date_for_query, attrs: screening_types}

    @response_json = JSON.parse(response.body)

    @movies = response_json.map{|cw_movie|Movie.new_from_cw_movie(cw_movie)}
  end

end

class Movie

  attr_accessor :title, :runtime, :screenings

  def initialize title, runtime, screenings
    @title = title
    @runtime = runtime
    @screenings = screenings
  end

  def self.new_from_cw_movie cw_movie
    new(
      cw_movie.fetch('n'),
      cw_movie.fetch('dur'),
      cw_movie.fetch('BD').first.fetch('P').map{|cw_screening|Screening.new_from_cw_screening(cw_screening)}
    )
  end

end

class Screening

  attr_accessor :time, :screen

  def initialize time, screen
    @time = time
    @screen = screen
  end

  def self.new_from_cw_screening cw_screening
    new(
      Time.at(cw_screening['dt']/1000),
      cw_screening['vn']
    )
  end

end