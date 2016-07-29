require 'curses'

module NeedForType
  class InputWindow < Curses::Window

    def initialize
      super(Curses.lines / 3, Curses.cols, Curses.lines / 1.5, 0)

      self.box("|", "-")
      self.keypad = true
      self.refresh

      @content = ''
    end

    def get_input
      self.getch
    end

    def add_input_content(content)
      self.clear
      self.box('|', '-')
      self.setpos(1, 2)
      self.addstr(content)
      self.refresh
    end

    def beep
      Curses.beep
    end

    def render
      self.clear
      self.box('|', '-')
      self.setpos(1, 2)
      self.refresh
    end
  end
end
