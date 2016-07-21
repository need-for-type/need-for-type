require 'curses'
require 'require_all'

require_all 'need_for_type/'

module NeedForType

  Curses.init_screen

  begin

    Typer.new
    sleep 10

  rescue => ex
    puts 'ERROR'
    puts "######"
    puts ex
    puts "######"
    Curses.close_screen
  end

end
