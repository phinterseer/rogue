class CWMovieService

  attr_accessor :cinema, :movie, :cw_movie, :cw_screenings_list, :cw_screenings

  def initialize cinema, cw_movie
    @cinema = cinema
    @cw_movie = cw_movie
    @cw_screenings_list = @cw_movie.fetch('BD').first
    @cw_screenings = cw_screenings_list.fetch('P')
  end

  def find_or_create_movie
    @movie = Movie.where(movie_params).first_or_create
  end

  def create_screens
    screen_names.map{|name|cinema.screens.where(name: name).first_or_create}
  end

  def create_screenings
    cw_screenings.map{|cw_screening|movie.screenings.where(screening_params(cw_screening)).first_or_create}
  end

  private

  def movie_params
    {
      title: cw_movie.fetch('n'),
      runtime: cw_movie.fetch('dur')
    }
  end

  def screen_names
    cw_screenings.map{|x|x.fetch('vn')}
  end

  def screening_params cw_screening
    {
      time: Time.at(cw_screening['dt']/1000),
      screen: cinema.screens.where(name: cw_screening['vn']).first
    }
  end
end