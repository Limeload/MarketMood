# services/api_service.rb
class ApiService
  def self.get(url, params = {}, headers = {})
    response = RestClient.get(url, { params: params, headers: headers })
    JSON.parse(response.body)
  rescue RestClient::ExceptionWithResponse => e
    e.response
  end
end
