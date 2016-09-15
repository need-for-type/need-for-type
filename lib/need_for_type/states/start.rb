require 'curses'

require 'need_for_type/states'

module NeedForType::States
  class Start < Menu

    def initialize(display_window)
      super(display_window)
    end

    def update
      @display_window.render_menu(@option)

      input_worker(4) do
        return NeedForType::States::Game.new(@display_window, @option)
      end

      return self
    end
  end
end
