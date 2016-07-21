require 'curses'

class WindowManager

  def initialize()
    @file_manager = FileManager.new('easy') # TODO  
    @file_manager.load_file

    @window = Curses::Window.new(Curses.lines, Curses.cols, 0, 0)
    @window.box("|", "-")

    @window.setpos(1, 2)
    @window.addstr(@file_manager.content)

    @window.refresh
  end

end
