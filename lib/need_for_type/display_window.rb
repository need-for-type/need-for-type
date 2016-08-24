require 'curses'
require 'need_for_type/window'

module NeedForType
  class DisplayWindow < Window

    def initialize
      super(Curses.lines, Curses.cols, 0, 0)
      Curses.curs_set(CURSOR_INVISIBLE)
    end

    def render_menu(selected_option)
      self.render do
        self.set_render_pos(2, 4)
        self.render_text("Need For Type", GREEN, NORMAL)

        self.set_render_pos(4, 4)
        mode = standout_mode(0, selected_option)
        self.render_text("1. Easy", WHITE, mode)

        self.set_render_pos(5, 4)
        mode = standout_mode(1, selected_option)
        self.render_text("2. Medium", WHITE, mode)

        self.set_render_pos(6, 4)
        mode = standout_mode(2, selected_option)
        self.render_text("3. Hard", WHITE, mode)

        self.set_render_pos(8, 4)
        mode = standout_mode(3, selected_option)
        self.render_text("Exit", WHITE, mode)
      end
    end

    def standout_mode(option, selected_option)
      selected_option == option ? STANDOUT : NORMAL
    end

    def render_start_game
      self.render do
        self.set_render_pos(2, 4)
        self.render_text("To start playing click ENTER", GREEN, NORMAL)
      end
    end

    def render_game_text(text, chars_completed, failed = false)
      color = failed ? RED : YELLOW
      head = text[0, chars_completed] || ''
      tail = text[chars_completed + 1, text.length] || ''

      @current_line = 2
      @current_col = 4

      self.render do
        self.render_text(head, GREEN, NORMAL)
        self.render_text(text[chars_completed], color, NORMAL)
        self.render_text(tail, WHITE, NORMAL)
      end
    end

    def render_score(time, wpm, accuracy)
      self.render do
        self.set_render_pos(2, 4)
        self.render_text("Time: #{time.round(2)} sec", GREEN, NORMAL)

        self.set_render_pos(3, 4)
        self.render_text("WPM: #{wpm.round}", GREEN, NORMAL)

        self.set_render_pos(4, 4)
        self.render_text("Accuracy: #{accuracy.round(2)} %", GREEN, NORMAL)
      end
    end
  end
end
