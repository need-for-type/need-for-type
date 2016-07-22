require 'logger'
require 'curses'
require './need_for_type/window_manager'

module NeedForType
  class Typer

    def initialize
      @window_manager = WindowManager.new
      @menu_option = 0
      @state = :menu
      @window_manager.input_window.keypad = true
    end

    def play_state
      if @state == :menu
        @window_manager.render_menu(@menu_option)
        input = get_input
        check_menu_input(input)
      end
    end

    def update
      while input_char = get_input
        if input_char == 27
          @window_manager.render_close_message
          break
        end
        @window_manager.display_window.setpos(2,2)
        @window_manager.display_window.addstr(input_char)
        @window_manager.refresh_display
      end
    end


    private

    def get_input
      @window_manager.input_window.getch
    end

    def check_menu_input(input)
      if input == Curses::Key::DOWN
        @menu_option = (@menu_option+1)%3
        #@menu_option = 3 if @menu_option = 0
      elsif input == Curses::Key::UP
        @menu_option = (@menu_option-1)%3
        #@menu_option = 3 if @menu_option = 0
      else
        @menu_option
      end
    end

  end
end
