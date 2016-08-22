require 'curses'

require 'need_for_type/states'
require 'need_for_type/file_manager'

module NeedForType::States
  class Game < State

    def initialize(display_window, input_window, difficulty)
      super(display_window, input_window)

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

      @type_entries = 0
      @misses = 0

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
      input = @input_window.get_input
      @type_entries += 1

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

      if @text[@chars_completed] == ' '
        @word = ''
      else
        @word += @text[@chars_completed]
      end

      # Render
      @input_window.render_text(@word)
      @display_window.render_game_text(@split_text, @chars_completed)

      if @chars_completed == @text.size
        @state = :end_game
      else
        @state = :in_game_1
      end

      return self
    end

    # User input is wrong 
    def handle_in_game_3
      @misses += 1

      @display_window.render_game_text(@split_text, @chars_completed, true)

      @state = :in_game_1

      return self
    end

    def handle_end_game
      @end_time = Time.now
      total_time = @end_time - @start_time

      mean_word_size = (@text.split.inject(0) { |acc, w| acc + w.size }) / @text.split.size

      gross_wpm = (@type_entries / mean_word_size) / (total_time / 60)
      net_wpm = gross_wpm - (@misses / (total_time / 60))
      accuracy = (net_wpm / gross_wpm) * 100
      
      return NeedForType::States::Score.new(@display_window, @input_window,
                                            time, net_wpm, accuracy)
    end
  end
end
