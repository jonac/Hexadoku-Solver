This is a hexadoku solver

To run this program you call the following line: 
ruby main.rb path_to_board

I have tried to structure the files so HexadokuGame contains all files 
needed to create a workable game with its front existing in hexadokuBoard.rb.
Everything is done so it should be possible to switch the solver algorithm for
a GUI and have a playable game.

In example_boards there are some boards I have used to test this application.

The solver is now only in one file so adding it to its own folder feels like adding
unnecassery clutter. If the solver would have grown to be larger it would have 
gotten its own folder as well.