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

    def render_start
      self.render_box do
        y_ascii = (Curses.lines / 2) - 8
        x_ascii = (Curses.cols / 2) - OFFSET
        self.render_need_for_type_ascii_art(y_ascii, x_ascii)

        text = "Click ENTER to start playing"
        y_text = y_ascii + 8
        x_text = (Curses.cols / 2) - (text.size / 2)
        self.set_render_pos(y_text, x_text)
        self.render_text(text, WHITE, NORMAL)
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

    def render_end(stats, scores_request, selected_option)
      self.render_box do
        self.render_with_color(GREEN) do
          self.set_render_pos(3, 4)
          self.addstr("Congratulations you crossed the finish line!")

          self.set_render_pos(5, 4)
          self.addstr("Your score:")
        end
        render_stats(stats, 6, 4, :vertical)

        self.set_render_pos(10, 4)
        self.render_text("Top scores:", GREEN, NORMAL)
        render_scores(scores_request, 11, 4)

        self.set_render_pos(17, 4)
        mode = standout_mode(0, selected_option)
        self.render_text("1. Submit Score", WHITE, mode)

        self.set_render_pos(18, 4)
        mode = standout_mode(1, selected_option)
        self.render_text("2. Restart", WHITE, mode)

        self.set_render_pos(19, 4)
        mode = standout_mode(2, selected_option)
        self.render_text("3. Main Menu", WHITE, mode)

        self.set_render_pos(20, 4)
        mode = standout_mode(3, selected_option)
        self.render_text("4. Exit", WHITE, mode)
      end
    end

    def render_submit_score(username)
      self.render_box do
        self.set_render_pos(3, 4)
        self.render_text("Submit your score !", GREEN, NORMAL)

        self.set_render_pos(5, 4)
        self.addstr("Type your username...")

        self.set_render_pos(6, 4)
        self.addstr(username)

        self.set_render_pos(8, 4)
        self.addstr("Click ENTER to submit")
      end
    end

    def render_need_for_type_ascii_art(y = 4, x = 4)
      @@need_for_type_ascii_art.split("\n").each_with_index do |line, i|
        self.set_render_pos(y + i, x)
        self.render_text(line, GREEN, GREEN)
      end
    end

    def standout_mode(option, selected_option)
      selected_option == option ? STANDOUT : NORMAL
    end

    def render_stats(stats, y, x, mode)
      stats_text = [
        "WPM: #{stats[:wpm].round}",
        "Time: #{stats[:total_time].round(2)} sec",
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

    def render_scores(scores_request, y, x)
      if scores_request.nil?
        self.set_render_pos(y, x)
        self.addstr("Fetching scores...")
      elsif scores_request[:scores]&.empty?
        self.set_render_pos(y, x)
        self.addstr("There are no scores yet for this text.")
      elsif scores_request[:error]
        self.set_render_pos(y + 1, x)
        self.addstr(scores_request[:error])
      else
        scores_request[:scores].each do |s|
          self.set_render_pos(y, x)
          self.addstr("#{s['wpm']} wpm #{s['username']}")
          y += 1
        end
      end
    end
  end
end
