require 'json'
require 'httparty'

module NeedForType::API
  @@api_url = 'localhost:3000'

  def get_scores(text_id)
    url = "http://#{@@api_url}/v1/scores?text_id=#{text_id}"
    response = HTTParty.get(url)
    JSON.parse(response.body)
  end

  def post_score(username, text_id, stats)
    url = "http://#{@@api_url}/v1/scores"
    headers = { 'Content-Type' => 'application/json' }
    body = { score: { username: username,
                      text_id: text_id,
                      wpm: stats[:wpm],
                      time: stats[:total_time], 
                      accuracy: stats[:accuracy] } }
    HTTParty.post(url, headers: headers, body: body.to_json)
  end
end
