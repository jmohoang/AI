import Myro
from Myro import *

init('/dev/tty.IPRE6-197924-DevB')

spd = 1 # move translation
turn = 0.5  # move rotation 
spin = 0.6   # turnRight rotation
thr = 1000  # threshold distance to wall (0-6400)
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