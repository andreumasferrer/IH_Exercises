
class Room

  attr_reader :name,:description, :exits, :items, :enemy

  def initialize(name, description, exits, items, enemy)
    @name = name
    @description = description
    @exits = exits #hash of exits: (i.e.: {:south => "room3", :west => "room4"})
    @items = items.map(&:upcase) #array of items in the room
    @enemy = enemy
  end

  def has_exit?(direction)
    @exits.key?(direction)
  end

  def get_exit_room(direction)
		@exits[direction]
  end

  def has_item?(item)
    @items.include?(item)
  end

  def delete_item(item)
    @items.delete(item)
  end

  def delete_enemy
    @enemy = nil
  end

end
