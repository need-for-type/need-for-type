module NeedForType::States
  class State

    def initialize(display_window)
      @display_window = display_window
    end

    def input_worker(number_option)
      input = @display_window.get_input

      if input == Curses::Key::UP
        @option = (@option - 1) % number_option
      elsif input == Curses::Key::DOWN
        @option = (@option + 1) % number_option
      elsif input == Curses::Key::ENTER || input == 10
        yield
      end
    end
  end
end
