require 'curses'

class WindowManager

  def initialize()
    @window = Curses::Window.new(Curses.lines, Curses.cols, 0, 0)
    @window.box("|", "-")

    @window.setpos(2, 2)
    @window.addstr("Hello")

    @window.refresh
  end

end
