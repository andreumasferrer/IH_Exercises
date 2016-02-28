require_relative "../../lib/model/cell"

describe Cell do

  describe '#regenerate' do

    it "regenerates a dead cell from a dead cell if it has 0 neighbours" do
      cell = Cell.new(:dead)
      neighbours = [Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:dead)]
      cell.regenerate(neighbours)
      expect(cell.state).to eq(:dead)
    end

    it "regenerates a dead cell from a dead cell if it has 1 neighbour" do
      cell = Cell.new(:dead)
      neighbours = [Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:alive)]
      cell.regenerate(neighbours)
      expect(cell.state).to eq(:dead)
    end

    it "regenerates a live cell from a live cell if it has 2 neighbours" do
      cell = Cell.new(:alive)
      neighbours = [Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:alive),
                    Cell.new(:alive)]
      cell.regenerate(neighbours)
      expect(cell.state).to eq(:alive)
    end

    it "regenerates a live cell from a live cell if it has 3 neighbours" do
      cell = Cell.new(:alive)
      neighbours = [Cell.new(:alive),
                    Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:alive),
                    Cell.new(:alive)]
      cell.regenerate(neighbours)
      expect(cell.state).to eq(:alive)
    end

    it "regenerates a live cell from a dead cell if it has 3 neighbours" do
      cell = Cell.new(:dead)
      neighbours = [Cell.new(:alive),
                    Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:alive),
                    Cell.new(:alive)]
      cell.regenerate(neighbours)
      expect(cell.state).to eq(:alive)
    end

    it "regenerates a dead cell from a live cell if it has 4 neighbours" do
      cell = Cell.new(:alive)
      neighbours = [Cell.new(:alive),
                    Cell.new(:dead),
                    Cell.new(:alive),
                    Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:dead),
                    Cell.new(:alive),
                    Cell.new(:alive)]
      cell.regenerate(neighbours)
      expect(cell.state).to eq(:dead)
    end

  end

end
