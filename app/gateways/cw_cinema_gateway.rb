class CWCinemaGateway < CWGateway
  attr_accessor :date, :response, :response_json

  def set_defaults
    @date = Date.today
  end

  def query_cinema_list
    @response = connection.get '/api-backend-events/cinemas', {date: date.strftime('%Y/%m/%d')}
    @response_json = JSON.parse(response.body)
  end

  def cw_cinema_list
    response_json.fetch('data')
  end

end
