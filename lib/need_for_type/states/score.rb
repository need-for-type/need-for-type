require 'curses'

require 'need_for_type/states'

module NeedForType::States
  class Score < State

    def initialize(display_window, time, wpm, accuracy)
      super(display_window)
      @time = time
      @wpm = wpm
      @accuracy = accuracy 
    end

    def update
      @display_window.render_score(@time, @wpm, @accuracy)

      input = @display_window.get_input

      if input == Curses::Key::ENTER || input == 10
        return NeedForType::States::Menu.new(@display_window)
      end

      return self
    end
  end
end
