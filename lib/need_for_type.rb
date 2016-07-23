require 'curses'
require 'require_all'

require_all 'need_for_type/'

module NeedForType
  Curses.init_screen
  Curses.noecho

  begin
    typer = Typer.new
    typer.play
  ensure
    Curses.close_screen
  end
end
