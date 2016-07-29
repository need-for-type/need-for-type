require 'curses'

module NeedForType
  class DisplayWindow < Curses::Window

    def initialize
      super((Curses.lines / 3) * 2, Curses.cols, 0, 0)

      self.box("|", "-")
      self.refresh
    end

    def render_menu(selected_option)
      self.clear
      self.box("|", "-")

      self.setpos(1,2)
      self.attrset(Curses.color_pair(1) | Curses::A_NORMAL)
      self.addstr("Need For Type")

      standout?(0, selected_option)
      self.setpos(3,2)
      self.addstr("1. Easy")

      standout?(1, selected_option)
      self.setpos(4,2)
      self.addstr("2. Medium")

      standout?(2, selected_option)
      self.setpos(5,2)
      self.addstr("3. Hard")

      self.refresh
    end

    def render_game_text(text)
      self.clear
      self.box('|', '-')
      self.setpos(1, 2)
      self.addstr(text)
      self.refresh
    end

    def standout?(option, option_input)
      if option_input == option
        self.attrset(Curses.color_pair(1) | Curses::A_STANDOUT)
      else
        self.attrset(Curses.color_pair(1) | Curses::A_NORMAL)
      end
    end

    #def render_close_message
    ## TODO: make this pretty
    #self.clear
    #self.setpos(2,2)
    #self.addstr("Thank you goodbye!")
    #self.refresh
    #sleep 3
    #end

  end
end
