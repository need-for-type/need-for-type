module NeedForType::States
  class Menu < State

    def initialize(display_window)
      super(display_window)
    end

    def input_worker(total_menu_options)
      input = @display_window.get_input

      if input == Curses::Key::UP
        @option = (@option - 1) % total_menu_options
      elsif input == Curses::Key::DOWN
        @option = (@option + 1) % total_menu_options
      elsif input == Curses::Key::ENTER || input == 10
        exit if @option == (total_menu_options - 1)
        yield
      end
    end
  end
end
