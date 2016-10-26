class CWGateway

  attr_accessor :connection
  def initialize
    self.connection = Faraday.new(:url => 'https://www.cineworld.co.uk') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    set_defaults
  end

end