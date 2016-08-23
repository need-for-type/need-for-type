require 'curses'

require 'need_for_type/states'

module NeedForType::States
  class Score < State

    def initialize(display_window, time, wpm, accuracy, difficulty)
      super(display_window)
      @difficulty = difficulty
      @time = time
      @wpm = wpm
      @accuracy = accuracy
      @option = 0
    end

    def update
      @display_window.render_score(@time, @wpm, @accuracy, @option)

      input_worker(3) do
        exit if @option == 2
        return NeedForType::States::Game.new(@display_window, @difficulty) if @option == 0
        return NeedForType::States::Menu.new(@display_window) if @option == 1
      end

      return self
    end
  end
end
