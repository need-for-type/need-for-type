require 'curses'
require 'need_for_type/window'

module NeedForType
  class DisplayWindow < Window

    def initialize
      super((Curses.lines / 3) * 2, Curses.cols, 0, 0, false)
      Curses.curs_set(CURSOR_INVISIBLE)
    end

    def render_menu(selected_option)
      self.render do
        self.setpos(1, 2)
        self.render_text("Need For Type", GREEN, NORMAL)

        self.setpos(3,2)
        self.standout_selector(0, selected_option, "1. Easy")

        self.setpos(4,2)
        self.standout_selector(1, selected_option, "2. Medium")

        self.setpos(5,2)
        self.standout_selector(2, selected_option, "3. Hard")
      end
    end

    def standout_selector(option, input, option_name)
      mode = input == option ? STANDOUT : NORMAL
      self.render_text(option_name, WHITE, mode)
    end

    def render_game_text(text, chars_completed, failed = false)
      self.render do
        text.each_with_index do |w, i|
          if i < chars_completed 
            self.render_text(w, GREEN, NORMAL)
          elsif i == chars_completed 
            color = failed ? RED : YELLOW
            self.render_text(w, color, NORMAL)
          else
            self.render_text(w, WHITE, NORMAL)
          end
        end
      end
    end
  end
end
