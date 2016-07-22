require 'logger'
require 'curses'
require './need_for_type/window_manager'

module NeedForType
  class Typer

    def initialize
      @window_manager = WindowManager.new
      @menu_option = 0
      @state = :menu
      @window_manager.setup_input_window
      @logger = Logger.new("typer.txt")
    end

    def play_state
      if @state == :menu
        @window_manager.render_menu(@menu_option)
        input = get_input
        check_menu_input(input)
      elsif @state == :init_game
        difficulty = get_difficulty
        @file_manager = FileManager.new(difficulty)
        @file_manager.load_file
        @state = :game
      elsif @state == :game
        update
      end
    end

    def update
      while input_char = get_input
        if input_char == 27
          @window_manager.render_close_message
          break
        end
        @window_manager.render_input(input_char)
        @logger.info(@file_manager.content)
        @window_manager.render_display(@file_manager.content)
      end
    end


    private

    def get_difficulty
      case @menu_option
      when 0
        'easy'
      when 1
        'medium'
      when 2
        'hard'
      end
    end

    def get_input
      @window_manager.input_window.getch
    end

    def check_menu_input(input)
      if input == Curses::Key::DOWN
        @menu_option = (@menu_option+1)%3
      elsif input == Curses::Key::UP
        @menu_option = (@menu_option-1)%3
      elsif input == Curses::Key::ENTER || input == 10
        @state = :init_game
      else
        @menu_option
      end
    end

  end
end
