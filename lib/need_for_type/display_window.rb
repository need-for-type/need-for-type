require 'curses'

module NeedForType
  class DisplayWindow 

    def initialize
      third_lines = Curses.lines / 3

      @window = Curses::Window.new(third_lines * 2, Curses.cols, 0, 0)
      @window.box("|", "-")
      @window.refresh
    end

    def render_menu(selected_option)
      @window.clear
      @window.box("|", "-")

      @window.setpos(1,2)
      @window.attrset(Curses.color_pair(1) | Curses::A_NORMAL)
      @window.addstr("Need For Type")

      standout?(0, selected_option)
      @window.setpos(3,2)
      @window.addstr("1. Easy")

      standout?(1, selected_option)
      @window.setpos(4,2)
      @window.addstr("2. Medium")

      standout?(2, selected_option)
      @window.setpos(5,2)
      @window.addstr("3. Hard")

      @window.refresh
    end

    def render_game_text(text)
      @window.clear
      @window.box('|', '-')
      @window.setpos(1, 2)
      @window.addstr(text)
      @window.refresh
    end

    def standout?(option, option_input)
      if option_input == option
        @window.attrset(Curses.color_pair(1) | Curses::A_STANDOUT)
      else
        @window.attrset(Curses.color_pair(1) | Curses::A_NORMAL)
      end
    end

    #def render_close_message
    ## TODO: make this pretty
    #@window.clear
    #@window.setpos(2,2)
    #@window.addstr("Thank you goodbye!")
    #@window.refresh
    #sleep 3
    #end

  end
end
