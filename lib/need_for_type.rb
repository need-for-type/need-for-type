require 'curses'
require 'require_all'

require_all 'need_for_type/'

module NeedForType
  Curses.init_screen
  if File.exist?('typer.txt')
    File.delete('typer.txt')
  end

  begin
    typer = Typer.new
    while true
      typer.play_state
    end
  ensure
    Curses.close_screen
  end
end
