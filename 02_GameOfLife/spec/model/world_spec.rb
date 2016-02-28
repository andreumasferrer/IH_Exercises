require_relative "../../lib/model/world"
require_relative "../../lib/model/cell"

describe World do

  before :all do
    @input_grid = [[:dead,  :dead,  :dead],
                   [:alive, :alive, :alive],
                   [:dead,  :dead,  :dead]
                  ]
  end

  context "Empty world" do

    describe '#load_cells' do

      it "should populate world with Cell objects and the given state" do
        world = World.new
        world.load_cells(@input_grid)
        expect(world.cells_grid.flatten.map{|cell| cell.state}).to eq(@input_grid.flatten)
      end

    end

  end

  context "Populated world" do

    before :each do
      @world = World.new
      @world.load_cells(@input_grid)
    end

    describe '#get_cell_at' do

      it "returns a cell object" do
        cell = @world.get_cell_at(1,1)
        expect(cell).to be_an_instance_of(Cell)
      end

      it "returns a cell with the right state" do
        cell = @world.get_cell_at(1,1)
        expect(cell.state).to eq(:alive)
      end

    end

    describe '#x_size' do

      it "returns the x size of the world's cells_grid" do
        expect(@world.x_size).to eq(3)
      end

    end

    describe '#y_size' do

      it "returns the y size of the world's cells_grid" do
        expect(@world.y_size).to eq(3)
      end

    end

    describe '#regenerate_all' do

      it "regenerates the world's grid with the expected cell states" do
        @world.regenerate_all
        regererated_grid_states = @world.cells_grid.map{|row| [row[0].state, row[1].state, row[2].state] }
        expected_grid_states = [[:dead, :alive, :dead],
                                [:dead, :alive, :dead],
                                [:dead, :alive, :dead]
                               ]
        expect(regererated_grid_states).to eq(expected_grid_states)
      end

    end

  end

end
