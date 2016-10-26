class CWCinemaService

  attr_accessor :cw_cinema_gateway, :changed_cinemas

  def initialize
    @cw_cinema_gateway = CWCinemaGateway.new
  end


  def update_cinemas_in_db
    @cw_cinema_gateway.query_cinema_list
    @changed_cinemas = []
    update_cinemas_on_list
  end

  private

  def cw_cinema_list
    cw_cinema_gateway.cw_cinema_list
  end

  def update_cinemas_on_list
    cw_cinema_list.map do |cw_cinema|
      cinema = lookup_and_populate(cw_cinema)
      next unless cinema.changed?
      cinema.save
      self.changed_cinemas << cinema
    end.compact
  end

  def lookup_and_populate cw_cinema
    cinema = Cinema.where(website_id: cw_cinema.fetch('websiteId')).first_or_initialize
    cinema.name = cw_cinema.fetch('name')
    cinema.url = cw_cinema.fetch('url')
    cinema.site_id = cw_cinema.fetch('siteId')
    cinema
  end

end
