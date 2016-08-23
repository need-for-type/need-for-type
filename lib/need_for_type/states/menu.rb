require 'curses'

require 'need_for_type/states'

module NeedForType::States
  class Menu < State

    def initialize(display_window)
      super(display_window)

      @option = 0
    end

    def update
      @display_window.render_menu(@option)

      input_worker(4) do
        exit if @option == 3
        return NeedForType::States::Game.new(@display_window, @option)
      end

      return self
    end
  end
end
