require 'curses'

class WindowManager

  def initialize
    @display_window = Curses::Window.new(Curses.lines/1.5, Curses.cols, 0, 0)
    @display_window.box("|", "-")

    @display_window.setpos(2, 2)
    @display_window.addstr("Hello")
    @display_window.refresh

    @input_window = Curses::Window.new(Curses.lines, Curses.cols, Curses.lines/1.5, 0)
    @input_window.box("|", "-")

    @input_window.setpos(2, 2)
    @input_window.refresh
  end

  def get_input
    @input_window.getch
  end

end
