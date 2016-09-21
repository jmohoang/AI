import Myro
from Myro import *
from Graphics import *

sim = Simulation("My World", 500, 400, Color("lightgrey"))

# Add walls and other objects:
sim.addWall((0, 0), (5, 400))
sim.addWall((0, 0), (500, 5))
sim.addWall((0, 395), (500, 400))

#sim.addWall( (5, 80), (80, 85) )
#sim.addWall( (80, 160), (160, 165) )
sim.addWall( (5, 160), (60, 165) )


sim.addWall( (140, 5), (145, 310) )
#sim.addWall( (240, 5), (245, 80) )
#sim.addWall( (320, 5), (325, 80) )
sim.addWall( (380, 85), (385, 160) )
sim.addWall( (480, 5), (485, 395) )
sim.addWall( (80, 310),  (145, 315) )
sim.addWall( (240, 310), (385, 315) )
sim.addWall( (240, 160), (385, 165) )
sim.addWall( (240, 165), (245, 315) )



# Start simulation loop:
sim.setup()

# Make a robot (save return, or use Myro.robot)
simRobot = makeRobot("SimScribbler", sim)

