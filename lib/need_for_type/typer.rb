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
      @logger.info("Input: #{input}")

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
      @display_window.render_game_text(@text)

      @state = :in_game
    end

    def handle_in_game
      input = @input_window.get_input
      @logger.info("Input: #{input}")

      @input_window.add_input_content(input) 

      # TODO terminate
    end

  end
end
