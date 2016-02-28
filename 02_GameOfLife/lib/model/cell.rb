class Cell
  attr_accessor :state

  def initialize(state=:alive)
    @state = state # either :alive or :dead
  end

  def regenerate(neighbours)
    alive_neighbours = neighbours.select{|cell| cell.state==:alive}
    number_of_neighbours = alive_neighbours.size
    @state = :dead if @state == :alive && (number_of_neighbours < 2 || number_of_neighbours > 3) #kill cell
    @state = :alive if @state == :dead && (number_of_neighbours == 3) #bring cell to life
  end

end
