require_relative "./lib/io/file_reader.rb"
require_relative "./lib/io/terminal_printer.rb"
require_relative "./lib/game.rb"

filename = File.expand_path(File.join(File.dirname(__FILE__), "./data/grid_complex.txt"))
input_reader = FileReader.new(filename)
output_printer = TerminalPrinter.new

game = Game.new(input_reader, output_printer)
game.play
