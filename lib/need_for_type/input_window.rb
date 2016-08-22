require 'curses'
require 'need_for_type/window'

module NeedForType
  class InputWindow < Window

    def initialize
      super(Curses.lines / 3, Curses.cols, Curses.lines / 1.5, 0)
    end

    def get_input
      self.getch
    end

    def render_text(text)
      self.render do
        self.setpos(1, 2)
        self.addstr(text)
      end
    end

    def beep
      Curses.beep
    end
  end
end
