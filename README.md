# wanderVille
Simple ambient villager script for Arma 3 (S.O.G. DLC)

Hello, 

This may be useful to some. It is a very quick and dirty ambience script that generates civilians in an area, and gets them to 'wander around'. 

It requires a position, e.g. [123,456], a radius in which they'll wander (so providing a value of 100 will generate an ellipse area 100 by 100), and lastly you provide the number of wandering villagers you want (e.g. 25). 

The script will check every 40 seconds for players within 350m of the given location - if it registers any the civvies will be generated. It then checks for players, but waits for there to be none before despawning them. 

If you want a number of different areas, you'll need to run the script multiple times.

Installation should be reasonably straight forward. I have inlcuded a bare-bones mission as a demo, and if you have issues installing this into your mission, just drop me a line.

Cheers
rm
