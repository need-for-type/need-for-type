require 'curses'

module NeedForType
  class Window < Curses::Window
    # Cursor visibility
    CURSOR_VISIBLE = 1
    CURSOR_INVISIBLE = 0

    # Colors
    WHITE = 1
    GREEN = 2
    YELLOW = 3
    RED = 4

    # Modes
    NORMAL = Curses::A_NORMAL
    STANDOUT = Curses::A_STANDOUT

    # Padding
    LINE_PADDING = 2
    COL_PADDING = 4

    def initialize(lines, cols, top, left)
      super(lines, cols, top, left)

      @current_line = LINE_PADDING
      @current_col = COL_PADDING

      self.box('|', '-')
      self.keypad = true 
      self.refresh
    end

    # Overrides
    def addstr(str)
      str.split('').each do |c|
        if @current_col == (Curses.cols - COL_PADDING)
          @current_line += 1
          @current_col = COL_PADDING
        end
        self.setpos(@current_line, @current_col)
        @current_col += 1
        super(c)
      end
    end

    # Class methods
    def self.init_colors
      Curses.start_color
      Curses.init_pair(WHITE,  Curses::COLOR_WHITE,  Curses::COLOR_BLACK)
      Curses.init_pair(GREEN,  Curses::COLOR_GREEN,  Curses::COLOR_BLACK)
      Curses.init_pair(YELLOW, Curses::COLOR_YELLOW, Curses::COLOR_BLACK)
      Curses.init_pair(RED,    Curses::COLOR_RED,    Curses::COLOR_BLACK)
    end

    # Instance methods
    def get_input
      self.getch
    end

    def set_render_pos(y, x)
      @current_line = y
      @current_col = x
    end

    def render(color = WHITE, mode = NORMAL)
      self.attrset(Curses.color_pair(color) | mode)

      self.clear
      self.box('|', '-')

      yield if block_given?

      self.refresh
    end

    def render_text(text, color = WHITE, mode = NORMAL)
      self.attron(Curses.color_pair(color) | mode)
      self.addstr(text)
      self.attroff(Curses.color_pair(color) | mode)
    end

    def render_multiple_text(color = WHITE, mode = NORMAL)
      self.attron(Curses.color_pair(color) | mode)
      yield
      self.attroff(Curses.color_pair(color) | mode)
    end
  end
end
