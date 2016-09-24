require 'curses'

require 'need_for_type/states'
require 'need_for_type/file_manager'

module NeedForType::States
  class Game < State

    def initialize(display_window, difficulty)
      super(display_window)

      @difficulty = difficulty
      @state = :init_game
      @text = ''
      @word = ''

      @chars_completed = 0
      @total_taps = 0
      @correct_taps = 0

      # Stats
      @stats = { total_time: 0,
                 wpm: 0,
                 accuracy: 100 }
    end

    # Takes action according to the current @state
    def update
      case @state
      when :init_game
        handle_init_game
      when :start_game
        handle_start_game
      when :in_game_get_input
        handle_in_game_get_input
      when :in_game_valid_input
        handle_in_game_valid_input
      when :in_game_invalid_input
        handle_in_game_invalid_input
      when :end_game
        handle_end_game
      end
    end

    private

    def handle_init_game
      file_manager = NeedForType::FileManager.new
      @text = file_manager.get_random_text

      @state = :start_game

      return self
    end

    def handle_start_game
      @display_window.render_game_text(@text, @chars_completed, @stats)
      @start_time = Time.now
      @state = :in_game_get_input

      return self
    end

    # Gets input from user and compares it
    def handle_in_game_get_input
      input = @display_window.get_input
      @total_taps += 1

      if input == @text[@chars_completed]
        @state = :in_game_valid_input
      else
        @state = :in_game_invalid_input
      end

      calculate_stats

      return self
    end

    # User input is correct
    def handle_in_game_valid_input
      @chars_completed += 1
      @correct_taps += 1

      if @chars_completed == @text.size
        @state = :end_game
        return self
      end

      if @text[@chars_completed] == ' '
        @word = ''
      else
        @word += @text[@chars_completed]
      end

      @display_window.render_game_text(@text, @chars_completed, @stats)

      @state = :in_game_get_input

      return self
    end

    # User input is wrong
    def handle_in_game_invalid_input
      Curses.beep

      @display_window.render_game_text(@text, @chars_completed, @stats, true)

      @state = :in_game_get_input

      return self
    end

    def handle_end_game
      calculate_stats

      return NeedForType::States::End.new(@display_window, @stats, @difficulty)
    end

    def calculate_stats
      current_time = Time.now

      @stats[:total_time] = current_time - @start_time
      @stats[:wpm] = (@text.split.size * 60) / @stats[:total_time]
      @stats[:accuracy] = (@correct_taps.to_f / @total_taps.to_f) * 100
    end
  end
end
