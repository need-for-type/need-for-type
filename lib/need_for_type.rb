require 'curses'

require './need_for_type/version'
require './need_for_type/typer'

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
