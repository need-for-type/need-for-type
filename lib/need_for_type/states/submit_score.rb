require 'curses'

require 'need_for_type/states'
require 'need_for_type/api'

module NeedForType::States
  class SubmitScore < State 
    include NeedForType::API

    def initialize(display_window, end_state, text_id, stats)
      super(display_window)
      @end_state = end_state
      @text_id = text_id
      @stats = stats

      @username = ''
    end

    def update
      @display_window.render_submit_score(@username)

      input = @display_window.get_input

      if input == Curses::Key::ENTER || input == 10
        post_score(@username, @text_id, @stats)
        @end_state.scores = get_scores(@text_id)
        return @end_state
      elsif input == Curses::Key::BACKSPACE  || input == 127
        @username = @username.chop
      elsif input.is_a? String
        @username += input
      end

      return self
    end
  end
end
