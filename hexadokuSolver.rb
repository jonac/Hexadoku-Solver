class HexadokuSolver
	def initialize
		@@solutions = Array.new
	end

	def getSolutions
		return @@solutions
	end

	def findSquare(board)
		# This functions main purpose is to find the square with the lowest amount of valid guesses
		# to try to minimize the amount of recursions steps we do.
		# We also deal with all hidden singles to further remove recursion steps
		leastGuesses = 18
		leastX, leastY=0,0
		guesses = Array.new
		changedOne = true
		
		while changedOne and not board.isFull?
			# Continue until we find no more singles or the board gets full
			changedOne = false
			board.each_with_index do |row, ri|
				row.each_with_index do |col, ci|
					if board.isSet?(ri,ci)
						next
					end
					guesses2 = board.getValidGuesses(ri,ci)
					if guesses2.length <= 0
						# If this is not a original position... we know it is empty as we tested it earlier
						if not board.isOrigin(ri,ci)
							return [],0,0
						end
					elsif guesses2.length == 1 # This is oftenly referred to as singles
					 	# stupid to create more recursion instances than needed
					 	# If there is only one guess we know for this board that is the only possibility
					 	changedOne = true
					 	board.setPos(ri,ci, guesses2[0])
					elsif guesses2.length < leastGuesses and guesses2.length > 1
						guesses = guesses2
						leastGuesses = guesses.length
						leastX, leastY = ri, ci
					end
				end
			end
		end
		return guesses,leastX,leastY
	end

	def backtrack(board)
		# Main recursive function using the backtrack method for solving hexadoku
		guesses,x,y = findSquare(board)

		if board.finished?
			@@solutions << board
			print "New Solution found\n"
			return nil
		end
		guesses.each do |i|
			board.setPos(x,y,i)
			backtrack(board.clone)

		end
		return nil
	end
end