require 'need_for_type/states'
require 'need_for_type/api'

module NeedForType::States
  class End < Menu
    include NeedForType::API

    def initialize(display_window, stats, difficulty, text_id)
      super(display_window)
      @stats = stats
      @difficulty = difficulty
      @text_id = text_id

      @option = 0
      @scores = get_scores(@text_id)
    end

    def update
      @display_window.render_end(@stats, @scores, @option)

      input_worker(4) do
        case @option
        when 0
          return NeedForType::States::SubmitScore.new(@display_window, self, @text_id, @stats)
        when 1
          return NeedForType::States::Game.new(@display_window, @difficulty)
        when 2
          return NeedForType::States::Start.new(@display_window)
        end
      end

      return self
    end
  end
end
