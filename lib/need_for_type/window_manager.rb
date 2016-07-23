require 'curses'

class WindowManager

  def initialize
    third_lines = Curses.lines / 3

    # Display Window
    @display_window = Curses::Window.new(third_lines * 2, Curses.cols, 0, 0)
    @display_window.box("|", "-")
    @display_window.refresh

    # Input Window
    @input_window = Curses::Window.new(third_lines, Curses.cols, Curses.lines/1.5, 0)
    @input_window.box("|", "-")
    @input_window.keypad = true
    @input_window.refresh

    @input_window_content = ''
  end


  # Display Window Methods

  def render_menu(selected_option)
    @display_window.clear
    @display_window.box("|", "-")

    @display_window.setpos(1,2)
    @display_window.attrset(Curses.color_pair(1) | Curses::A_NORMAL)
    @display_window.addstr("Need For Type")

    standout?(0, selected_option)
    @display_window.setpos(3,2)
    @display_window.addstr("1. Easy")

    standout?(1, selected_option)
    @display_window.setpos(4,2)
    @display_window.addstr("2. Medium")

    standout?(2, selected_option)
    @display_window.setpos(5,2)
    @display_window.addstr("3. Hard")

    @display_window.refresh
  end

  def render_game_text(text)
    @display_window.clear
    @display_window.box('|', '-')
    @display_window.setpos(1, 2)
    @display_window.addstr(text)
    @display_window.refresh
  end

  def standout?(option, option_input)
    if option_input == option
      @display_window.attrset(Curses.color_pair(1) | Curses::A_STANDOUT)
    else
      @display_window.attrset(Curses.color_pair(1) | Curses::A_NORMAL)
    end
  end

  #def render_close_message
    ## TODO: make this pretty
    #@display_window.clear
    #@display_window.setpos(2,2)
    #@display_window.addstr("Thank you goodbye!")
    #@display_window.refresh
    #sleep 3
  #end


  # Input Window Methods
  
  def get_input
    @input_window.getch
  end

  def add_input_content(char) 
    @input_window_content = @input_window_content + char

    @input_window.clear
    @input_window.box('|', '-')
    @input_window.setpos(1, 2)
    @input_window.addstr(@input_window_content)
    @input_window.refresh
  end

end
