# require "pry-byebug"
require_relative "./model/world.rb"

class Game

  def initialize(input_reader, output_printer)
    @input_reader = input_reader
    @output_printer = output_printer
    @world = World.new
  end

  def play
    input_grid = @input_reader.get_grid  #the input_grid is a two dimensional array of :dead or :alive symbols
    @world.load_cells(input_grid)
    250.times do
      @world.regenerate_all
      output_grid = prepare_output #the output_grid is a two dimensional array of :dead or :alive symbols
      @output_printer.print(output_grid)
    end
  end

  private

  def prepare_output
    output_grid = [] #the output is a two dimensional array of :dead or :alive symbols
    (0..@world.x_size-1).each do |x|
      output_row = []
      (0..@world.y_size-1).each do |y|
        output_row << @world.get_cell_at(x, y).state
      end
      output_grid << output_row
    end
    return output_grid
  end

end
