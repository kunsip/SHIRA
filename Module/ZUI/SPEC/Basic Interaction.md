# Purpose
	Providing a consistent set of actions that are simple and easy to use but than can be built on top to provide very complicated commands just like Linux can with pipe operators
# Normal Case
	The ZUI can be viewed as a two dimensional cartisian plane. The origin is located at ((2^128)/2, (2^128)/2) or more specifically  (170141183460469231731687303715884105728, 170141183460469231731687303715884105728).

	In the event that the user approaches one of the edges of the cartisian plane we simply wrap around. Therefor the user should be made to feel like they are on an immensly large sphere.  

	If we were to flatten the sphere the dimensions of the "top left" would be (0,0), the dimensions of the bottom left would be (0,340282366920938463463374607431768211456), the dimensions of the top right would be (340282366920938463463374607431768211456, 0) and the dimensions of the "bottom right" would be(340282366920938463463374607431768211456, 340282366920938463463374607431768211456) 
# Actions
	Everything, this is sites, applications, documents, movies, pictures exist somewhere in this two dimensional cartisian plane.

	There are five universal actions:

	Duplicate - This means there exists another copy to move around and modify WITHOUT affecting the original.
	Move - Move the current item do a different place. 
	Zoom - Increase amount of screen that filled with a subset of the cartesian plane or increase the amount of cartesian plane that fills the screen.
	Resize - The operator can resize the item.
	Search - Look for something, will search the closest items, then further away and such. This should be done instantaneously to the user
# Dependencies
	SANE - Touch Abstraction Library 
