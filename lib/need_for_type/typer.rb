require 'logger'
require 'curses'
require './need_for_type/display_window'
require './need_for_type/input_window'

module NeedForType
  class Typer

    def initialize
      @logger = Logger.new('need_for_type.log')

      @display_window = DisplayWindow.new
      @input_window = InputWindow.new

      @state = :menu
      @menu_option = 0
      @text = ''
    end

    def play
      while true
        self.update
      end
    end

    def update
      case @state
      when :menu
        handle_menu
      when :init_game
        handle_init_game
      when :in_game
        handle_in_game
      end
    end

    def handle_menu
      @display_window.render_menu(@menu_option)
      input = @input_window.get_input

      if input == Curses::Key::UP
        @menu_option = (@menu_option - 1) % 3
      elsif input == Curses::Key::DOWN
        @menu_option = (@menu_option + 1) % 3
      elsif input == Curses::Key::ENTER || input == 10
        @state = :init_game
      end
    end

    def handle_init_game
      @file_manager = FileManager.new(@menu_option)

      @text = @file_manager.get_random_text
      prepare_words
      @display_window.render_game_text(@text)

      @word = ""
      @input_words = []
      @words_completed = 0

      @state = :in_game
    end

    def handle_in_game
      input = @input_window.get_input
      temp = @word + input

      if compare(temp) && !ended?(temp)
        @word = temp
        @input_window.add_input_content(temp)
      elsif ended?(temp)
        @word = temp
        @words_completed+=1

        if @input_words.size == @file_words.size
          @state = :menu
        else
          reset_input
        end
      else
        @input_window.add_input_content(temp)
        @input_window.beep
      end
    end

    private

    def reset_input
      @input_window.render
      @input_words << @word
      @word = ""
    end

    def ended?(word)
      @file_words[@words_completed] == word
    end

    def compare(word)
      @file_words[@words_completed].start_with?(word)
    end

    def prepare_words
      @file_words = @text.split(' ').map { |word| word << ' ' }
    end
  end
end
