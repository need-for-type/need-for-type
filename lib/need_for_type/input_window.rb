require 'curses'

#TODO: extend Curses::Window para OOP and change
# @window creation
module NeedForType
  class InputWindow

    def initialize
      third_lines = Curses.lines / 3

      @window = Curses::Window.new(third_lines, Curses.cols, Curses.lines / 1.5, 0)
      @window.box("|", "-")
      @window.keypad = true
      @window.refresh

      @content = ''
    end

    def get_input
      @window.getch
    end

    def add_input_content(content)
      @window.clear
      @window.box('|', '-')
      @window.setpos(1, 2)
      @window.addstr(content)
      @window.refresh
    end

    def beep
      Curses.beep
    end

    def clear
      @window.clear
    end

    def refresh
      @window.box('|', '-')
      @window.setpos(1, 2)
      @window.refresh
    end
  end
end
