require 'logger'
require 'curses'

module NeedForType::States
  class Game 
    def initialize(display_window, input_window)
      @display_window = display_window 
      @input_window = input_window 

      @state = :init_game
      @text = ''
    end

    def update
      case @state
      when :init_game
        handle_init_game
      when :in_game
        handle_in_game
      end
    end

    def handle_init_game
      @file_manager = FileManager.new(@menu.option)

      @text = @file_manager.get_random_text
      @display_window.render_game_text(@text)

      @state = :in_game

      return :game
    end

    def handle_in_game
      input = @input_window.get_input
      @logger.info("Input: #{input}")

      @input_window.add_input_content(input) 

      # TODO terminate

      return :game
    end

  end
end
