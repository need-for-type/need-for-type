require 'curses'

require 'need_for_type/states'

module NeedForType::States
  class Menu < State

    def initialize(display_window, input_window)
      super(display_window, input_window)

      @option = 0
    end

    def update
      @display_window.render_menu(@option)

      input = @input_window.get_input

      if input == Curses::Key::UP
        @option = (@option - 1) % 4
      elsif input == Curses::Key::DOWN
        @option = (@option + 1) % 4
      elsif input == Curses::Key::ENTER || input == 10
        exit if @option == 3
        return NeedForType::States::Game.new(@display_window, @input_window, @option) 
      end

      return self
    end
  end
end
