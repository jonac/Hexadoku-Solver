require "forwardable"
require "./HexadokuGame/solutionVerifier"
require "./HexadokuGame/quadrants"

class HexadokuBoard
	include Enumerable # Here to implement each 
	# Class to contain a hexadoku board. The board only contain numbers and 
	# whenever we are working inside the algorithm we are working on ints
	# The data is converted to ints on read and when we are printing the board

	SIZE_OF_BOARD = 16
	DECODE_TABLE = [" ","0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]
	@board # Where the gameboard is saved
	@@origin_board # Saves the starting board for checking validity of solutions
	@@quad #reference to a class for finding information about quadrants

	def initialize(board = nil)
		# Create the starting board
		@@quad = Quadrants.new
		if board == nil
			@board = Array.new(SIZE_OF_BOARD) do |line| 
				line = Array.new(SIZE_OF_BOARD) do |col|
					col = 0
				end
			end
		else
			@board = board
		end
	end

	def setOriginBoard(origin)
		# Sets the original board, this is used to check if a solution is invalid so must be 
		# set. This is also a class variable so setting it again will overwrite it for all classes
		@@origin_board = Array.new(16) { |i| i =Array.new(16) { |j| j=0 } }
		origin.each_with_index do |row, ri|
			row.each_with_index do |col, ci|
				@@origin_board[ri][ci] = col
			end
		end
	end

	def isOrigin(row,col)
		# Find if the given grid was set by the original or by the algorithm
		if @@origin_board[row][col] == 0
			return false
		end
		return true
	end

	def self.getDecodeTable()
		# Get the table to decode the numbers in the matrix
		return DECODE_TABLE
	end

	def setPos(line, col, newVal)
		@board[line][col] = newVal
	end

	def isFull?
		return getNrEmptySquares == 0
	end

	def getRow(lineNr)
		return @board[lineNr]
	end

	def getCol(colNr)
		col = Array.new
		@board.each do |line|
			col << line[colNr]
		end
		return col
	end

	def isSet?(rowNr, colNr)
		# Check if the grid has been given a value
		if @board[rowNr][colNr] == 0
			return false
		end
		return true
	end

	def getNrEmptySquares
		# Get how many empty squares still exist in the board
		emptySquares=0
		@board.each_with_index do |row,ri|
			row.each_with_index do |col, ci|
				if not isSet?(ri,ci)
					emptySquares += 1
				end
			end
			
		end
		return emptySquares	
	end

	def each(&block)
		@board.each(&block)
	end

	def [](ind)
		@board[ind]
	end

	def getQuadrantValues(row_quadrant, col_quadrant)
		# Generate an array with all elements in the given quadrant
		# Top left quadrant is 0,0 bottom right is 3,3
		return @@quad.getValues(@board,row_quadrant,col_quadrant)

	end

	def getQuadrantBounds(rowNr, colNr)
		# Get the bounds of the quadrant which contains element on rowNr,colNr
		return @@quad.getBounds(rowNr,colNr)
	end

	def getQuadrant(rowNr, colNr)
		# Get a list of all elements in the quadrant which contains rowNr and colNr
		row_quadrant, col_quadrant = getQuadrantBounds(rowNr, colNr)
		return getQuadrantValues(row_quadrant, col_quadrant)			
	end

	def getValidGuesses(rowNr, colNr)
		# Returns an array of valid guesses
		# if there are no valid guesses it returns the empty array
		if isSet?(rowNr, colNr)
			return Array.new
		end
		retArr = (1..16).to_a

		row = getRow(rowNr)
		retArr-=row
		if retArr.length == 0
			return retArr
		end

		col = getCol(colNr)
		retArr-=col
		if retArr.length == 0
			return retArr
		end

		quadrant = getQuadrant(rowNr, colNr)
		retArr-=quadrant

		return retArr
	end

	def finished?
		return checkSudokoSolution(self)
	end

	def clone
		new_board = Array.new
		@board.each do |row|
			new_board << row.clone
		end
		HexadokuBoard.new(new_board)
	end

	def checkIfBoardsAreEqual(otherBoard)
		# See if 2 boards are equal
		# could be called equal but then we need to check for 
		otherBoard.each_with_index do |row, ri|
			row.each_with_index do |col, ci|
				if @board[ri][ci] != col
					print "somethings wrong at ", ri," ",ci
				end
			end
		end
		print "They are equal"
	end

	def printGameBoard
		# Prints the game board with all values converted according to DECODE_TABLE
		if @board.length<16 or @board[0].length<16
			nil.getasd
		end
		@board.each_with_index do |line, i|
			if i%4 == 0
				(0..20).each { |e| print '-' }
				print "\n"
			end
			line.each_with_index do |elem, i2| 
				
				if i2%4 == 0
					print "|"
				end
				print DECODE_TABLE[elem]
			end
			print "|\n"
		end
		(0..20).each { |e| print '-' }
		print "\n"
	end

	def to_s()
		printGameBoard
	end
end