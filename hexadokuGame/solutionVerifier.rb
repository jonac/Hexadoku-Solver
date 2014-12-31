def checkSudokoSolution(board)
	# Check all rows, columns and quadrants for duplicates
	# If we find no duplicates we have a perfect solution
	if checkRows(board)
		return false
	end
	
	if checkCols(board)
		return false
	end

	if checkQuadrants(board)
		return false
	end

	return true
end

def checkRows(board)
	# Check all rows for duplicates
	board.each_with_index do |row, ri|
		if findDuplicates(row)
			return false
		end
	end
	return true
end

def checkCols(board)
	# Check all columns for duplicates
	(0..15).each do |index|
		if findDuplicates(board.getCol(index))
			return false
		end
	end
	return true
end

def checkQuadrants(board)
	# Check all quadrants for duplicates
	(0..3).each do |x|
		(0..3).each do |y|
			if findDuplicates(board.getQuadrantValues(x,y))
				return false
			end
		end
	end
	return true
end

def findDuplicates(arr)
	# Check an array for duplicates. I have also added a check for 0
	found = Array.new(arr.length+1) { |i| i=false }
	arr.each do |elem|
		if elem == 0
			return true
		elsif !found[elem-1]
			found[elem-1] = true
		else
			return true
		end
	end
	return false
end