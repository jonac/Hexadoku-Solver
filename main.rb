require './hexadokuGame/hexadokuBoard'
require './hexadokuGame/file_input'
require './hexadokuSolver'

def main()
	# Simple file to call the necessary functions.
	path = ""
	if ARGV.length >= 1
		path = ARGV[0]
	end
	b = HexadokuBoard.new
	f = FileInput.new(path, b)

	# I use this to know which grids were set at start.
	# This is saved in a class variable (static variable)
	b.setOriginBoard(b)

	solver = HexadokuSolver.new

	b = solver.backtrack(b)

	solutions = solver.getSolutions
	if solutions == nil
		puts "No solution found"
	else
		#b.checkIfBoardsAreEqual(sol)
		print "Solutions\n"
		solutions.each do |board|
			board.printGameBoard
		end
	end

	print "Found ", solutions.length, " solutions\n"
# print b.finished?
end

main()