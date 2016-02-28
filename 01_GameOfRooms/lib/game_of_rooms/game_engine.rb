
class GameEngine

  #Mapping between game actions and room exits / directions
  ACTION_TO_DIRECTION = {
    :go_north => :north,
    :go_south => :south,
		:go_east => :east,
		:go_west => :west
		}

  #Methods
  attr_reader :game_name, :current_room, :carrying_items, :response_message,
              :winning_room, :winning_message

  def initialize(data_reader)
    @data_reader = data_reader
    @game_name = @data_reader.get_game_name
    @rooms = @data_reader.get_rooms
    @current_room = @rooms.first[1]
    @winning_room = @data_reader.get_winning_room
    @winning_message = @data_reader.get_winning_message
    @carrying_items = []
    @response_message = nil
  end

  def do_action(action, parameter=nil)
    @response_message = nil
    case action
    when :go_north,:go_east,:go_south, :go_west
      move_character(ACTION_TO_DIRECTION[action])
    when :pick_item
      pick_item(parameter)
    when :fight_enemy
      fight_enemy
    else
      @response_message = "Invalid action"
    end
  end

  private

  def move_character(direction)
    if @current_room.has_exit?(direction)
      exit_room = @current_room.get_exit_room(direction)
      @current_room = @rooms[exit_room]
    else
      @response_message = "I can't go #{direction} from here"
    end
  end

  def pick_item(item)
    if @current_room.has_item?(item)
      if @current_room.enemy
        @response_message = "The enemy doesn't let me pick any item"
      else
        @current_room.delete_item(item)
        @carrying_items << item
        @response_message = "Cool! You have #{item.downcase} now"
      end
    elsif !item.nil?
      @response_message = "Hey! I can't see any \"#{item.downcase}\" here."
    else
      @response_message = "Command usage: PICK <item_name>"
    end
  end


  def fight_enemy
    if @current_room.enemy
      if @carrying_items.include?(@current_room.enemy["killed_by"].upcase)
        @current_room.delete_enemy
        @response_message = "You win! No more enemies in this room ;-)"
      else
        @response_message = "You loose. You'll need the #{@current_room.enemy["killed_by"]} to beat this enemy"
      end
    else
      @response_message = "I can't see any enemy around"
    end
  end

end
