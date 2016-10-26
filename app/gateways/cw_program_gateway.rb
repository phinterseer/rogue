class CWProgramGateway < CWGateway
  attr_accessor :movies, :cinema, :date, :screening_types, :response, :response_json

  def query_cinema_for_date cinema, date
    @cinema = cinema
    @date = date
    @response = connection.get '/pgm-site', {si: cinema.website_id, max: 365, bd: date_for_query, attrs: screening_types}
    @response_json = JSON.parse(response.body)
  end

  def cw_movies
    response_json
  end

  private

  def date_for_query
    date.to_i*1000
  end

  def set_defaults
    @screening_types = "2D,3D,IMAX,ViP,DBOX,4DX,M4J"
  end

end