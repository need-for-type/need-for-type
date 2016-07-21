require 'curses'
require 'require_all'

require_all 'need_for_type/'

module NeedForType
  Curses.init_screen
  begin
    typer = Typer.new
    typer.update
  ensure
    Curses.close_screen
  end
end
