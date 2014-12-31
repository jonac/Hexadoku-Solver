class FileInput
	# Simple class to handle files
	@decode_table
	def initialize(path, board)
		@decode_table = HexadokuBoard.getDecodeTable()
		i, j = 0,0
		begin
			File.open(path, "r") do |file|
				if readFile(file, board) != 0
					raise TypeError
				end
			end
		rescue Exception => e
			throw e
		end
	end


	def readFile(file, board)
		# Read an hexadoku board from file and fill a board returns 0 if successfull otherwise something else
		i, j = 0, 0
		file.each do |line|
			if line[0] == "-"
				next
			end
			line.each_char do |chr|
				if chr.eql? "\n"
					i+=1
				elsif chr.eql? "|"

				else
					int_val = @decode_table.find_index(chr)
				
					if int_val == nil
						puts "This char is not allowed " + chr.ord.to_s + " at " + i.to_s + " " +j.to_s+"\n"
						return 1
					end
					board.setPos(i, j, int_val)
					j+=1
				end	
							
			end
			j=0
		end
		return 0
	end
end
