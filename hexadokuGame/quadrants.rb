class Quadrants
	# Class to contain methods to find different information about quadrants
	def getValues(board,row_quadrant, col_quadrant)
		# Generate an array with all elements in the given quadrant
		# Top left quadrant is (0,0) bottom right is (3,3)
		ret = Array.new	
		# -1 so we remove the last element (without it it would be [0,1,2,3,4])
		(row_quadrant*4..(row_quadrant+1)*4-1).each do |row|
			(col_quadrant*4..(col_quadrant+1)*4-1).each do |col|
				ret << board[row][col]
			end
		end
		return ret	
	end

	def getBounds(rowNr, colNr)
		# Get which index the grid in question resides in.
		# The topleft quadrant is (0,0), the top right is (0,3), bottom right is (3,3)
		(0..3).each do |row_quadrant|
			if rowNr.between?( row_quadrant*4, ( row_quadrant+1 )*4-1 )
				(0..3).each do |col_quadrant|
					if colNr.between?( col_quadrant*4, ( col_quadrant+1 )*4-1 )
						return row_quadrant, col_quadrant
					end
				end
			end
		end
	end
end