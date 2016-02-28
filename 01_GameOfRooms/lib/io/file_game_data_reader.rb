require 'json'
require_relative '../game_of_rooms/room.rb'

class FileGameDataReader

  def initialize(filename)
    filename_path = File.expand_path(File.join(File.dirname(__FILE__), "../../data/"+filename))
    file = File.read(filename_path)
    @game_data = JSON.parse(file)
    @rooms = {}
  end

  def get_game_name
    @game_data["game_name"]
  end

  def get_rooms
    @game_data["rooms"].each do |room_key, room_value|
      exits = room_value["exits"].inject({}) {|h, (k,v)| h[k.to_sym] = v.to_sym; h }
      enemy = get_enemy(room_value["enemy"])
      @rooms[room_key.to_sym] = Room.new(room_value["name"],
                                         room_value["description"],
                                         exits, room_value["items"], enemy)
    end
    return @rooms
  end

  def get_winning_room
    @rooms[@game_data["winning_room"].to_sym]
  end

  def get_winning_message
    @game_data["winning_message"]
  end

  private

  def get_enemy(name)
    enemy = @game_data["enemies"][name]
    return enemy
  end

end
