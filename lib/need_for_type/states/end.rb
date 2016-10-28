require 'need_for_type/states'
require 'need_for_type/api'

module NeedForType::States
  class End < Menu
    include NeedForType::API

    attr_accessor :scores

    def initialize(display_window, stats, difficulty, text_id)
      super(display_window)
      @stats = stats
      @difficulty = difficulty
      @text_id = text_id

      @option = 0
      @scores = nil
      fetch_and_render_scores_async 
    end

    def update
      @display_window.render_end(@stats, @scores, @option)

      @fetch_and_render_scores_thread.join

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

    def fetch_and_render_scores_async
      @fetch_and_render_scores_thread = Thread.new do
        @scores = get_scores(@text_id)
        @display_window.render_end(@stats, @scores, @option)
      end
    end
  end
end
