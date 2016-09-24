require 'curses'

require 'need_for_type/states'

module NeedForType::States
  class Start < Menu

    def initialize(display_window)
      super(display_window)
    end

    def update
      @display_window.render_init_game

      input = @display_window.get_input

      if input == Curses::Key::ENTER || input == 10
        return NeedForType::States::Game.new(@display_window, @option)
      end

      return self
    end
  end
end
