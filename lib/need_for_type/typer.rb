require 'logger'
require './need_for_type/window_manager'

module NeedForType
  class Typer

    def initialize
      @logger = Logger.new('typer.txt')
      @window_manager = WindowManager.new
    end

    def update
      while input_char = @window_manager.get_input
        @logger.info(input_char)

        if input_char == 27
          @window_manager.add_close_message
          break
        end
        @window_manager.display_window.setpos(2,2)
        @window_manager.display_window.addstr(input_char)
        @window_manager.refresh_display
      end
    end

  end
end
