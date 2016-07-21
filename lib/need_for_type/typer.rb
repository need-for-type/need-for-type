require './need_for_type/window_manager'

module NeedForType
  class Typer

    def initialize
      @window_manager = WindowManager.new
    end

    def update
      while input_char = @window_manager.get_input
        @window_manager.display_window.setpos(2,2)
        @window_manager.display_window.addstr(input_char)
        @window_manager.display_window.refresh
      end
    end

  end
end
