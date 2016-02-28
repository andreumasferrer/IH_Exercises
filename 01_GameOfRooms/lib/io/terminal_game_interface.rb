require 'io/console'
require 'artii'
require_relative 'terminal_screen_tools.rb'

class TerminalGameInterface

  # Mapping between console commands and game actions
  COMMAND_TO_ACTION  = {
      "N" => :go_north,
      "S" => :go_south,
  		"E" => :go_east,
  		"W" => :go_west,
      "PICK" => :pick_item,
      "FIGHT" => :fight_enemy
  		}

  # Methods
  def initialize(game_engine)
    @game = game_engine
    @message = nil
  end

  def start
    show_intro
    play_game
  end

  private

  def show_intro
    title = Artii::Base.new.asciify("Game of Rooms")
    title += "\n"+@game.game_name
    TerminalScreenTools::Screen.print_centered(title)
    print "Press any key to continue..."
    STDIN.getch
  end

  def play_game
    command = nil
    until command=="QUIT" || win_game? do
      show_room_info
      if @message
        show_message
      else
        command = prompt_user_input
        execute_command(command)
      end
    end
  end

  def show_room_info
    TerminalScreenTools::Screen.clear_screen
    puts "\n"
    puts " " + "*" * (@game.current_room.name.size + 8)
    puts " " + "*   " + @game.current_room.name.upcase + "   *"
    puts " " + "*" * (@game.current_room.name.size + 8)
    puts "\n #{@game.current_room.description}"
    puts "\n #{@game.current_room.enemy["description"]}" if @game.current_room.enemy
    puts "\n\n"
    puts " EXITs: #{@game.current_room.exits.keys.join(",")}"
    puts "-" * 40
  end

  def show_message
    print " " + @message
    STDIN.getch
    @message = nil
  end

  def prompt_user_input
    puts " Enter command."
    print " > "
    return gets.chomp.upcase
  end

  def execute_command(command)
    command_name = command.split[0]
    command_arg1 = command.split[1]
    if COMMAND_TO_ACTION.key?(command_name)
      @game.do_action(COMMAND_TO_ACTION[command_name], command_arg1)
      @message = @game.response_message
    else
      case command_name
      when "LOOK"
        show_room_objects
      when "INVENTORY"
        show_carrying_items
      when "HELP"
        show_instructions
      when "QUIT"
        puts "Good bye!"
      else
        @message = "Invalid command. (Type \"help\" for instructions)"
      end
    end
  end

  def show_room_objects
    if @game.current_room.items.any?
      @message = "I can see the following objects: "+ (@game.current_room.items.join(", ")).downcase
    else
      @message = "Sorry, no objects in this place."
    end
  end

  def show_carrying_items
    if @game.carrying_items.any?
      @message = "You have the following items: " + (@game.carrying_items.join(", ")).downcase
    else
      @message = "Your pockets are empty"
    end
  end

  def show_instructions
    help  = "\n"
    help  += " AVAILABLE COMMANDS:                            \n"
    help  += " -------------------                            \n\n"
    help  += " N -> Go north                                  \n"
    help  += " E -> Go east                                   \n"
    help  += " S -> Go south                                  \n"
    help  += " W -> Go west                                   \n"
    help  += " LOOK -> Look for objects in the room           \n"
    help  += " PICK <item> -> Pick an item of the room        \n"
    help  += " FIGHT -> Try to kill the enemy in the room     \n"
    help  += " INVENTORY -> List all the items you'r carrying \n"
    help  += " HELP -> Show available commands                \n"
    help  += " QUIT -> Quit game                              \n"
    TerminalScreenTools::Screen.print_centered(help)
    print "Press any key to continue..."
    STDIN.getch
  end


  def win_game?
    if (@game.current_room == @game.winning_room) && @game.current_room.enemy.nil?
      title = Artii::Base.new.asciify("The End")
      title += "\n"+@game.winning_message
      TerminalScreenTools::Screen.print_centered(title)
      print "Press any key to quit..."
      STDIN.getch
      return true
    else
      return false
    end
  end

end
