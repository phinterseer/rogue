class CWProgramService

  attr_accessor :cw_program_gateway, :cinema, :date

  def initialize
    @cw_program_gateway = CWProgramGateway.new
    @cinema = Cinema.where(site_id: 8052, website_id: 1010842).first_or_create
    @date = Date.today.to_time
  end

  def update_screenings
    @cw_program_gateway.query_cinema_for_date cinema, date
    update_screenings_for_cw_movies
  end

  private

  def cw_movies
    cw_program_gateway.cw_movies
  end

  def update_screenings_for_cw_movies
    cw_movies.map do |cw_movie|
      process_cw_movie cw_movie
    end
  end

  def process_cw_movie cw_movie
    cw_movie_service = CWMovieService.new(cinema, cw_movie)
    cw_movie_service.find_or_create_movie
    cw_movie_service.create_screens
    cw_movie_service.create_screenings
  end

end