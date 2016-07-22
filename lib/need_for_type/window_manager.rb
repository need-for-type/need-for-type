require 'curses'

class WindowManager

  attr_accessor :input_window
  attr_accessor :display_window

  def initialize
    @file_manager = FileManager.new('easy') # TODO: ask user for difficulty
    @file_manager.load_file

    third_lines = Curses.lines / 3

    @display_window = Curses::Window.new(third_lines * 2, Curses.cols, 0, 0)
    @display_window.box("|", "-")

    @input_window = Curses::Window.new(third_lines, Curses.cols, Curses.lines/1.5, 0)
    @input_window.box("|", "-")

    @input_window.setpos(2, 2)
    @input_window.refresh
  end

  def render_menu(input)
    @display_window.clear

    @display_window.setpos(2,2)
    @display_window.attrset(Curses.color_pair(1) | Curses::A_NORMAL)
    @display_window.addstr("Need For Type")

    standout?(0, input)
    @display_window.setpos(3,2)
    @display_window.addstr("1. Easy")

    standout?(1, input)
    @display_window.setpos(4,2)
    @display_window.addstr("2. Medium")

    standout?(2, input)
    @display_window.setpos(5,2)
    @display_window.addstr("3. Hard")

    @display_window.refresh
  end

  def standout?(option, option_input)
    if option_input == option
      @display_window.attrset(Curses.color_pair(1) | Curses::A_STANDOUT)
    else
      @display_window.attrset(Curses.color_pair(1) | Curses::A_NORMAL)
    end
  end

  def refresh_display
    @display_window.refresh
  end

  def refresh_input
    @input_window.refresh
  end

  # TODO: make this pretty
  def render_close_message
    @display_window.clear
    @display_window.setpos(2,2)
    @display_window.addstr("Thank you goodbye!")
    @display_window.refresh
    sleep 3
  end

end
