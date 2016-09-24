require 'curses'

require 'need_for_type/states'

module NeedForType::States
  class End < Menu

    def initialize(display_window, stats, difficulty)
      super(display_window)
      @difficulty = difficulty
      @stats = stats
      @option = 0
    end

    def update
      @display_window.render_end(@stats, @option)

      input_worker(3) do
        case @option
        when 0
          return NeedForType::States::Game.new(@display_window, @difficulty)
        when 1
          return NeedForType::States::Start.new(@display_window)
        end
      end

      return self
    end
  end
end
