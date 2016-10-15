require 'curses'
require 'json'
require 'httparty'

require 'need_for_type/states'

module NeedForType::States
  class End < Menu
    @@api_url = 'localhost:3000'

    def initialize(display_window, stats, difficulty, text_id)
      super(display_window)
      @stats = stats
      @difficulty = difficulty
      @text_id = text_id

      @option = 0
      @scores = get_scores
    end

    def update
      @display_window.render_end(@stats, @scores, @option)

      input_worker(3) do
        case @option
        when 0
          return NeedForType::States::Game.new(@display_window, @difficulty)
        when 1
          return NeedForType::States::Start.new(@display_window)
        end
      end

      return self
    end

    private

    def get_scores
      url = "http://#{@@api_url}/v1/scores?text_id=#{@text_id}"
      response = HTTParty.get(url)
      JSON.parse(response.body)
    end
  end
end
