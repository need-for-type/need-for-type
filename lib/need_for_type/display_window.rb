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
        self.setpos(2, 4)
        self.render_text("Need For Type", GREEN, NORMAL)

        self.setpos(4, 4)
        mode = standout_mode(0, selected_option)
        self.render_text("1. Easy", WHITE, mode)

        self.setpos(5, 4)
        mode = standout_mode(1, selected_option)
        self.render_text("2. Medium", WHITE, mode)

        self.setpos(6, 4)
        mode = standout_mode(2, selected_option)
        self.render_text("3. Hard", WHITE, mode)

        self.setpos(8, 4)
        mode = standout_mode(3, selected_option)
        self.render_text("Exit", WHITE, mode)
      end
    end

    def standout_mode(option, selected_option)
      selected_option == option ? STANDOUT : NORMAL
    end

    def render_game_text(text, chars_completed, failed = false)
      self.render do
        self.setpos(2, 4)
        text.each_with_index do |c, i|
          if i < chars_completed 
            self.render_text(c, GREEN, NORMAL)
          elsif i == chars_completed 
            color = failed ? RED : YELLOW
            self.render_text(c, color, NORMAL)
          else
            self.render_text(c, WHITE, NORMAL)
          end
        end
      end
    end

    def render_score(time, wpm, accuracy)
      self.render do
        self.setpos(2, 4)
        self.render_text("Time: #{time.round(2)} sec", GREEN, NORMAL)

        self.setpos(3, 4)
        self.render_text("WPM: #{wpm.round}", GREEN, NORMAL)

        self.setpos(4, 4)
        self.render_text("Accuracy: #{accuracy.round(2)} %", GREEN, NORMAL)
      end
    end
  end
end
