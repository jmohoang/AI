import Myro
from Myro import *
#from Graphics import *

init('/dev/tty.IPRE6-197924-DevB')

"""
sim = Simulation("My World", 1000, 800, Color("lightgrey"))

# Add walls and other objects:
sim.addWall((0, 0), (10, 800))
sim.addWall((0, 0), (1000, 10))
sim.addWall((0, 790), (1000, 800))
sim.addWall( (10, 320), (120, 330) )


sim.addWall( (280, 10), (290, 620) )

sim.addWall( (760, 170), (770, 320) )
sim.addWall( (960, 10), (970, 790) )
sim.addWall( (160, 620),  (290, 630) )
sim.addWall( (480, 620), (770, 630) )
sim.addWall( (480, 320), (770, 330) )
sim.addWall( (480, 330), (490, 630) )



# Start simulation loop:
sim.setup()

# Make a robot (save return, or use Myro.robot)
simRobot = makeRobot("SimScribbler", sim)

"""

spd = 1
turn = 0.5
spin = .5
thr = 1000
nearWall = False

def findWall(left,center,right):
    global nearWall
    if (left < thr and center < thr and right < thr):      
        forward(spd)
    else:
        nearWall = True
        stop()

def followWall(left,center,right):
    if (left < thr and center < thr and right < thr):
        move(spd,spin)
    else:
        turnRight(turn)
        
def main():
    
    while True:
        left = getObstacle(0)
        center = getObstacle(1)
        right = getObstacle(2)
        
        print(getObstacle())
        
        if nearWall == False:
            findWall(left,center,right)
        else:
            followWall(left,center,right)

main()