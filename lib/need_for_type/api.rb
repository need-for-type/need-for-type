require 'json'
require 'httparty'

module NeedForType::API
  @@api_url = 'need-for-type.herokuapp.com'

  def get_scores(text_id)
    url = "https://#{@@api_url}/v1/scores?text_id=#{text_id}"

    begin
      response = HTTParty.get(url)
      JSON.parse(response.body)
    rescue HTTParty::Error, StandardError
      { error: "Ups! Something went wrong." }
    end
  end

  def post_score(username, text_id, stats)
    url = "https://#{@@api_url}/v1/scores"
    headers = { 'Content-Type' => 'application/json' }
    body = { score: { username: username,
                      text_id: text_id,
                      wpm: stats[:wpm],
                      time: stats[:total_time], 
                      accuracy: stats[:accuracy] } }
    begin
      HTTParty.post(url, headers: headers, body: body.to_json)
    rescue HTTParty::Error, StandardError
    end
  end
end
