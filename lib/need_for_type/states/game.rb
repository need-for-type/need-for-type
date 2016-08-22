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
    end

    # Takes action according to the current @state 
    #
    # @state can take the following values
    #
    # - :init_game Game initialization
    # - :in_game_1 Get input 
    # - :in_game_2 Right input state
    # - :in_game_3 Wrong input state
    def update
      case @state
      when :init_game
        handle_init_game
      when :in_game_1
        handle_in_game_1
      when :in_game_2
        handle_in_game_2
      when :in_game_3
        handle_in_game_3
      when :end_game
        handle_end_game
      end
    end

    private

    def handle_init_game
      @chars_completed = 0
      @word = ''

      @total_taps = 0
      @correct_taps = 0

      file_manager = NeedForType::FileManager.new(@difficulty)
      @text = file_manager.get_random_text
      @split_text = @text.split('')
      @display_window.render_game_text(@split_text, @chars_completed)

      @start_time = Time.now

      @state = :in_game_1

      return self
    end

    # Gets input from user and compares it
    def handle_in_game_1
      input = @display_window.get_input
      @total_taps += 1

      if input == @text[@chars_completed]
        @state = :in_game_2
      else
        @state = :in_game_3
      end

      return self
    end

    # User input is correct
    def handle_in_game_2
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

      # Render
      @display_window.render_game_text(@split_text, @chars_completed)

      @state = :in_game_1

      return self
    end

    # User input is wrong 
    def handle_in_game_3
      @display_window.render_game_text(@split_text, @chars_completed, true)

      @state = :in_game_1

      return self
    end

    def handle_end_game
      @end_time = Time.now

      total_time = @end_time - @start_time
      wpm = (@text.split.size * 60) / total_time
      accuracy = (@correct_taps.to_f / @total_taps.to_f) * 100
      
      return NeedForType::States::Score.new(@display_window, total_time, wpm, accuracy)
    end
  end
end
