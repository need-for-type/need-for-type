require 'curses'
require 'need_for_type/window'

module NeedForType
  class DisplayWindow < Window
    OFFSET = 35
    @@need_for_type_ascii_art =
"    _   __              __   ____              ______
   / | / /__  ___  ____/ /  / __/___  _____   /_  __/_  ______  ___
  /  |/ / _ \\/ _ \\/ __  /  / /_/ __ \\/ ___/    / / / / / / __ \\/ _ \\
 / /|  /  __/  __/ /_/ /  / __/ /_/ / /       / / / /_/ / /_/ /  __/
/_/ |_/\\___/\\___/\\__,_/  /_/  \\____/_/       /_/  \\__, / .___/\\___/
                                                 /____/_/
"

    def initialize
      super(Curses.lines, Curses.cols, 0, 0)
      Curses.curs_set(CURSOR_INVISIBLE)
    end

    def render_init_game
      self.render_box do
        self.render_need_for_type_ascii_art(2, (Curses.cols/2)-OFFSET)

        self.set_render_pos(12, 4)
        self.render_text("Click ENTER to start playing", WHITE, NORMAL)
      end
    end

    def render_game_text(text, chars_completed, stats, failed = false)
      color = failed ? RED : YELLOW
      completed = text[0, chars_completed] || ''
      remaining = text[chars_completed + 1, text.length] || ''

      self.render_box do
        # Stats
        self.render_with_color(GREEN) do
          render_stats(stats, 2, 4, :horizontal)
        end

        # Text
        self.set_render_pos(4, 4)
        self.render_text(completed, GREEN, NORMAL)
        self.render_text(text[chars_completed], color, NORMAL)
        self.render_text(remaining, WHITE, NORMAL)
      end
    end

    def render_score(stats, selected_option)
      self.render_box do
        self.render_with_color(GREEN) do
          self.set_render_pos(3, 4)
          self.addstr("Congratulations you crossed the finish line!")

          render_stats(stats, 5, 4, :vertical)
        end

        self.set_render_pos(9, 4)
        mode = standout_mode(0, selected_option)
        self.render_text("1. Restart", WHITE, mode)

        self.set_render_pos(10, 4)
        mode = standout_mode(1, selected_option)
        self.render_text("2. Main Menu", WHITE, mode)

        self.set_render_pos(11, 4)
        mode = standout_mode(2, selected_option)
        self.render_text("3. Exit", WHITE, mode)
      end
    end

    def render_need_for_type_ascii_art(y = 4, x = 4)
      @@need_for_type_ascii_art.split("\n").each_with_index do |line, i|
        self.set_render_pos(y + i, x)
        self.render_text(line)
      end
    end

    def standout_mode(option, selected_option)
      selected_option == option ? STANDOUT : NORMAL
    end

    def render_stats(stats, y, x, mode)
      stats_text = [
        "Time: #{stats[:total_time].round(2)} sec",
        "WPM: #{stats[:wpm].round}",
        "Accuracy: #{stats[:accuracy].round(2)} %"
      ]

      stats_text.each do |t|
        self.set_render_pos(y, x)
        self.addstr(t)

        case mode
        when :vertical
          y += 1
        when :horizontal
          x += t.size + 4
        end
      end
    end
  end
end
