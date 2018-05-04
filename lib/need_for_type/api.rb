require 'json'
require 'httparty'

module NeedForType::API
  API_URL = 'need-for-type.herokuapp.com'.freeze

  def get_scores(text_id)
    url = "https://#{API_URL}/v1/scores?text_id=#{text_id}"

    begin
      response = HTTParty.get(url)
      { scores: JSON.parse(response.body) }
    rescue SocketError
      { error: 'You are not connected to the internet.' }
    rescue HTTParty::Error, StandardError
      { error: "Ups! Something went wrong." }
    end
  end

  def post_score(username, text_id, stats)
    url = "https://#{API_URL}/v1/scores"
    headers = { 'Content-Type' => 'application/json' }
    body = { score: { username: username,
                      text_id: text_id,
                      wpm: stats[:wpm],
                      time: stats[:total_time],
                      accuracy: stats[:accuracy] } }
    begin
      HTTParty.post(url, headers: headers, body: body.to_json)
    rescue HTTParty::Error, StandardError
      # Nothing is done
    end
  end
end
