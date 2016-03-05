

# Game of Rooms 
> Week 01: Object-Oriented Programming in Ruby

It is a game that is played in the terminal and prompts the user for input based on rooms available to navigate around with different actions available to perform in different rooms. The goal of this project was to practice object-oriented coding in Ruby. I tried to write clean code by aplying SOLID principles and by using some design patterns.


<p align="center">
		<img src="http://i67.tinypic.com/bhmxp2.png">
		<img src="http://i66.tinypic.com/w7d5dx.png">
</p>


## Code details
------------------

The code is structured in three main components: 

* THE ENGINE _(game_engine.rb)_: The game engine is the responsible of handling the logic and behaviour during the round.
* THE DATA READER _(file_game_data_reader.rb)_: Reads game data and prepares it to be loaded by the game engine. Here I used the **strategy pattern** in order to be able to use different kinds of sources for the input data. For now, game data is sored in a JSON file _(game_data.json)_... **Yes! You can create your own map of rooms, enemies and items writtng your version of that file!!!**
* THE USER INTEFACE _(terminal_game_interface.rb)_: I implemented a terminal mode for the user interface using "ruby-terminfo" and "artii" gems. The interface isn't cuupled to the engine so other kinds of user interfaces could be used without having to make changes in the game.


## Instructions to make it run:
------------------
install the ruby dependencies: _(some gems needed for the terminal interface)_

```
bundle install
```


go to lib forlder and run the game:

```
ruby  game_of_rooms_app.rb
```

Have fun!





