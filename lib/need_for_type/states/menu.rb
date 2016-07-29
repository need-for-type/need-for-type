require 'logger'
require 'curses'

module NeedForType::States
  class Menu
    attr_accessor :option

    def initialize(display_window, input_window)
      @display_window = display_window 
      @input_window = input_window 

      @option = 0
    end

    def update
      @display_window.render_menu(@option)

      input = @input_window.get_input

      if input == Curses::Key::UP
        @option = (@option - 1) % 3
      elsif input == Curses::Key::DOWN
        @option = (@option + 1) % 3
      elsif input == Curses::Key::ENTER || input == 10
        return :game
      end

      return :menu
    end
  end
end
