require_relative "./cell.rb"

class World

  attr_reader :cells_grid
  
  def initialize
    @cells_grid = []
  end

  def load_cells(input_grid) #the input_grid is a two dimensional array of :dead or :alive symbols
    (0..input_grid.length-1).each do |x|
      cells_row = []
			(0..input_grid[x].length-1).each do |y|
				cells_row << Cell.new(input_grid[x][y])
			end
      @cells_grid << cells_row
		end
  end

  def x_size
    @cells_grid.size
  end

  def y_size
    @cells_grid[0].size
  end

  def get_cell_at(x, y)
    @cells_grid[x][y]
  end

  def regenerate_all
    @new_cells_grid = []
    (0..x_size-1).each do |x|
      new_cells_grid_row = []
			(0..y_size-1).each do |y|
        neighbours = get_neighbours_at(x,y)
        cell_clone = get_cell_at(x,y).clone
				cell_clone.regenerate(neighbours)
        new_cells_grid_row << cell_clone
			end
      @new_cells_grid << new_cells_grid_row
		end
    @cells_grid = @new_cells_grid
  end

  private

  def get_neighbours_at(x, y)
    neighbour_positions = [[x-1, y-1],
                           [x, y-1],
                           [x+1, y-1],
                           [x-1, y],
                           [x+1, y],
                           [x-1, y+1],
                           [x  , y+1],
                           [x+1, y+1]
                          ]
		neighbour_positions.delete_if do |pos|
			(not (pos[0].between?(0,x_size-1))) ||
			(not (pos[1].between?(0,y_size-1)))
		end
    neighbours = neighbour_positions.map do |pos|
			get_cell_at(pos[0],pos[1])
		end
    return neighbours
  end

end
