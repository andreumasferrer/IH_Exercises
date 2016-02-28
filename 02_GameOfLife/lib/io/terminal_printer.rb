class TerminalPrinter

  def print(grid)
    system "clear" or system "cls"
    result_grid =""
    (0..grid.length-1).each do |x|
      (0..grid[x].length-1).each do |y|
        result_grid += (grid[x][y]==:alive)? "# " : "· "
      end
      result_grid += "\n"
    end
    puts result_grid
    sleep(0.1)
  end
  
end
