class FileReader

  def initialize(filename)
    @file = File.read(filename)
  end

  def get_grid
    grid = []
    @file.each_line do |line|
      grid_row = line.chomp.chars.map do |cell|
                (cell!="-")? :alive : :dead
             end
      grid << grid_row
    end
    return grid
  end

end
