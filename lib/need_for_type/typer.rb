require 'logger'
require 'curses'

require './need_for_type/display_window'
require './need_for_type/input_window'

require './need_for_type/states/menu'
require './need_for_type/states/game'

module NeedForType
  class Typer

    def initialize
      @logger = Logger.new('need_for_type.log')

      @display_window = DisplayWindow.new
      @input_window = InputWindow.new

      @menu = States::Menu.new(@display_window, @input_window)
      @game = States::Game.new(@display_window, @input_window)

      @state = :menu
    end

    def play
      while true
        self.update
      end
    end

    # Acts accrodingly to the current @state
    def update
      case @state
      when :menu
        @state = @menu.update
      when :game
        @state = @game.update
      end
    end

  end
end
