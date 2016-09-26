globals[numOfEach]
patches-own [kind]  ;; kind distinguishes bright and dark patches from in-between patches
turtles-own [leftSpeed rightSpeed]


;;; This first creates num-turtles turtles, asks them to turn themselves red and move to a
;;; random (x, y) coordinate in the world.  It then calls the function setup-patches
;;; which sets the colors of the patches (you do *NOT* need to understand how
;;; setup-patches works)
to setup
  clear-all
  create-turtles num-turtles
  ask turtles [
    set color red
    setxy random-xcor random-ycor
    ]
  ;; Add here steps to create num-turtles turtles, make them red, and move them to a random
  ;; location


  setup-patches
  reset-ticks
end

;; -------------------------------------------------------------------------------------------------
;; Add go-B1, go-B2A, and go-B2B functions here
to go-B1
  ask turtles [
    ask patches in-radius 3 []
    forward (pcolor - 49)
  ]
end

;;Braitenburg 2A Vehicles
to go-B2A
  ask turtles[
    get-color-patches
    print rightSpeed
    set-motor-speeds leftSpeed rightSpeed
   ]
end
;;Unline the go-B2A, the rightSpeed and the leftSpeed are swapped.
;;That is the only difference between teh 2 functions
to go-B2B
  ask turtles[
    get-color-patches
    set-motor-speeds rightSpeed leftSpeed
   ]
end

;;I used this to get the color ranges on either side of the turtle
to get-color-patches
  left 90
  ask patches in-cone 3 60 []
  set leftSpeed (pcolor - 49)
  right 180
  ask patches in-cone 3 60 []
  set rightSpeed (pcolor - 49)
  left 90
end

to set-motor-speeds [leftval rightval]
  ;; This is a function that converts left speed and right speed into what the turtle can do.
  ;; It moves the turtle forward in its old directly an amount that is the average of left and right
  ;; speeds. It then turns the turtle based on the difference between left and right values
    fd (rightval + leftval) / 2
    rt (leftval - rightval) * turn-angle
end



;;; ------------------------------------------------------------------------------------------------------------
;;; Below this point you can ignore the code.  It just picks a number of random locations,
;;; equally divided into bright and dark, and then shades
;;; all other patches in between.


to setup-patches
  ;; find patches to be centers of greenness
  set numOfEach round( (2 * max-pxcor) / 50)
  repeat numOfEach
  [ ask patch random-pxcor random-pycor
    [ set pcolor 59
      set kind "bright" ]
    ask patch random-pxcor random-pycor
    [ set pcolor 50
      set kind "dark" ]
  ]
  let brights patches with [kind = "bright"]
  let darks patches with [kind = "dark"]
  ask patches
  [ if not ( kind = "bright" or kind = "dark")
    [ let mybrights sort-by [ distance ?1 < distance ?2 ] brights
      let mydarks sort-by [ distance ?1 < distance ?2 ] darks
      let closest-bright first mybrights
      let br-dist distance closest-bright
      let closest-dark first mydarks
      let dk-dist distance closest-dark
      let dk-perc (dk-dist / (br-dist + dk-dist))
      set pcolor 50 + dk-perc * 10
    ]
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
219
10
964
686
24
21
15.0
1
10
1
1
1
0
1
1
1
-24
24
-21
21
0
0
1
ticks
30.0

SLIDER
21
29
194
62
turn-angle
turn-angle
0
100
38
1
1
degrees
HORIZONTAL

SLIDER
22
62
194
95
num-turtles
num-turtles
0
100
18
1
1
turtles
HORIZONTAL

BUTTON
73
140
139
173
setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
55
94
161
139
numBrightDark
numOfEach
0
1
11

BUTTON
12
189
81
222
run-B1
go-B1
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
138
188
212
221
step-B1
go-B1
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
8
251
85
284
run-B2A
go-B2A
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
131
252
213
285
step-B2A
go-B2A
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
8
314
83
347
run-B2B
go-B2B
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
132
314
213
347
step-B2B
go-B2B
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

@#$#@#$#@
## WHAT IS IT?

This model is a simulation of Braitenberg's first three vehicles: Vehicle 1, Vehicle 2a, and Vehicle 2b.

## HOW IT WORKS

Vehicle 1 turtles always move straight ahead.  They change their speed based on the color of the patch they are on.  The brighter the patch, the faster the turtle moves.  The darkest patches cause the turtle to stop, altogether.

Vehicle 2a turtles sense the patches to their left and to their right (how far they turn to left and right is controlled by the turn-angle slider).  The average brightness to the turtle's left corresponds to a "left motor" speed, and similarly for the right. The left and right speeds are then converted into a distance moved and a new heading.

Vehicle 2b turtles are similar to 2a, except that the average brightness to the left of the turtle controls the RIGHT motor speed, and vice versa.

## HOW TO USE IT

The first slider controls the turn angle for Vehicle 2a and 2b turtles.  To collect sensor values from its left, the turtle turns left the turn-angle amount, then collects a set of colors from patches in a cone in that direction, then it does the same to the right.

The second slider controls how many turtles are displayed.  Just a few turtles are easier to follow than many turtles, but some patterns emerge more clearly when there are many turtles.

The setup button initializes the world to have two bright spots, two dark spots, and graduated shading in between.  It also intitializes the correct number of turtles, at random locations and headings.

The next pair of buttons either run one step or continual steps of the turtles acting like Vehicle 1 turtles.

The second pair of buttons either run one step or continual steps of the turtles acting like Vehicle 2a turtles.

The third pair of buttons either run one step or continual steps of the turtles acting like Vehicle 2b turtles. NOTE:  you have to implement this one!!

## THINGS TO NOTICE

Notice when the turtles speed up and when they slow down and stop.

Look at the difference between Vehicle 2a and Vehicle 2b: because speed differs, they do not show completely mirrored behavior.  What do you see instead?

## THINGS TO TRY

Try changing the turn angle to see what effect, if any, that has on the turtles' behavior.

What changes if you go into the procedures and change the slowest speed from zero to 1, so that the turtles never quite stop moving?

## EXTENDING THE MODEL

You are going to implement the turtles and their behaviors.

You could add other Vehicles from Braitenberg's book, or change how each turtle senses its environment.

## CREDITS AND REFERENCES

This model is based on ideas from Braitenberg's "Vehicles" book.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
0
Rectangle -7500403 true true 151 225 180 285
Rectangle -7500403 true true 47 225 75 285
Rectangle -7500403 true true 15 75 210 225
Circle -7500403 true true 135 75 150
Circle -16777216 true false 165 76 116

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

@#$#@#$#@
NetLogo 5.3.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
0
@#$#@#$#@
