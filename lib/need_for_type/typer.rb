require 'logger'
require 'curses'
require './need_for_type/window_manager'

module NeedForType
  class Typer

    def initialize
      @logger = Logger.new('need_for_type.log')

      @window_manager = WindowManager.new

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
      @window_manager.render_menu(@menu_option)

      input = @window_manager.get_input
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
      @window_manager.render_game_text(@text)

      @state = :in_game
    end

    def handle_in_game
      input = @window_manager.get_input
      @logger.info("Input: #{input}")

      @window_manager.add_input_content(input) 

      # TODO terminate
    end

  end
end
