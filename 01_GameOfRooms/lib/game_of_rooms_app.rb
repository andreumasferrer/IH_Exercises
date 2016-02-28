require_relative './io/file_game_data_reader.rb'
require_relative './game_of_rooms/game_engine.rb'
require_relative './io/terminal_game_interface.rb'

gor_data_reader = FileGameDataReader.new("game_data.json")

gor_game_engine = GameEngine.new(gor_data_reader)

gor_interface = TerminalGameInterface.new(gor_game_engine)
gor_interface.start
