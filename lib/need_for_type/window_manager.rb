require 'curses'

class WindowManager

  def initialize
    @display_window = Curses::Window.new(Curses.lines/1.5, Curses.cols, 0, 0)
    @display_window.box("|", "-")

    @display_window.setpos(2, 2)
    @display_window.refresh

    @input_window = Curses::Window.new(Curses.lines, Curses.cols, Curses.lines/1.5, 0)
    @input_window.box("|", "-")

    @input_window.setpos(2, 2)
    @input_window.refresh
  end

  def render_menu
    @display_window.clear
    @display_window.setpos(2,2)
    @display_window.addstr("Need For Type")
    @display_window.setpos(3,2)
    @display_window.attrset(1, Curses::A_STANDOUT)
    @display_window.addstr("1. ")
  end

  def get_input
    @input_window.getch
  end

  def refresh_display
    @display_window.refresh
  end

  def refresh_input
    @input_window.refresh
  end

  # TODO: make this pretty
  def add_close_message
    @display_window.clear
    @display_window.setpos(2,2)
    @display_window.addstr("Thank you goodbye!")
    @display_window.refresh
    sleep 3
  end

end
