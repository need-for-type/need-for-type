require 'curses'

require 'need_for_type/display_window'

require 'need_for_type/states'

module NeedForType
  class Typer

    def initialize
      display_window = NeedForType::DisplayWindow.new

      @state = NeedForType::States::Menu.new(display_window)
    end

    def play
      while true
        @state = @state.update
      end
    end

  end
end
