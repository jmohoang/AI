import Myro
from Myro import *
from Graphics import *

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

# Declare and initialize global variables
spd = 1.2   # move translation
turn = 1  # move rotation 
spin = 1.5  # turnRight rotation
thr = 4500  # threshold distance to wall (0-6400)
nearWall = False    # becomes True once the robot detects a wall 
ir = 135 # sensor power (0-255)

# Move forward until it detects a wall, then stop
def findWall(left,center,right):
    global nearWall
    if (left < thr and center < thr and right < thr):      
        print("Searching for the wall...")
        forward(spd)
    else:
        print("Wall detected!")
        nearWall = True
        stop()

# Move in a circle until it detects a wall, then spin 
def followWall(left,center,right):
    if (left < thr and center < thr and right < thr):
        print("Following the wall")
        move(spd,turn)
    else:
        print("Turning right")
        turnRight(spin)

# Main function
def main():

    setIRPower(ir)

    while True:
        #Gets the 3 object sensor values
        left = getObstacle(0)
        center = getObstacle(1)
        right = getObstacle(2)
        
        #print(getObstacle())
        
        if nearWall == False:
            findWall(left,center,right)
        else:
            followWall(left,center,right)

main()