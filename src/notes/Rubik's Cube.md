---
title: Rubik's Cube
created: 2021-06-15T18:31:12.224Z
modified: 2022-05-02T17:15:49.044Z
---

# Rubik's Cube

Via [Cedric Beust](http://beust.com/rubik/), circa 2003. Aims to be easy to memorize (few small moves).

Cube handling notes:

- The cube has three pairs of opposite faces: Up/Down, Front/Back, Left/Right. Reorient as needed.
- Move syntax uses one letter to reference a side, and optional direction marker. For example, `T` rotates the Up face clockwise, `T'` rotates anticlockwise.

The solve, first few steps left as an exercise to the reader:

1. Pick a colour to start, this is Up.
2. Solve Up edges.
3. Solve 3 Up corners.
4. Solve 3 middle edges, using the remaining Up corner as a "working" column.
5. Solve last Up corner.
6. Flip the cube, original Up colour is now Down.
7. Finish middle layer. Align last cube to match front colour and then:
   Move Up front to right front `URU'R' U'F'UF`
   Move Up front to left front `U'L'UL UFU'F'`
8. Orient Up edges.
   Flip front + right: `FUR U'R'F'`
   Flip front + back: `FRU R'U'F'`
9. Position Up edges. Rotate Up to try and match two, then,
   Swap left + back: `UR'UUR UR'UR`
10. Position Up corners. Sequence leaves back left untouched.
   Swap front left -> front right -> back right: `ULU'R' UL'U'R`
11. Orient Up corners. Keep the cube positioned with a consistent side as front, repeat sequence until oriented and then rotate Up layer only to bring a different corner to front-right. Parity will fix the rest of the cube when you're done.
   Rotate front right: `RF'R'F RF'R'F`

### Chinese Cube Instructions

```
- Solve Down edges, corners
- Middle layer edges: align edge to match Front or Right
  - Up Front to Front Right: FUFUFU'F'U'F'
  - Up Right to Front Right: R'U'R'U'R'URUR
  - Flip Front Right: RU2R' U RU2R' U F'U'F
- Up Cross
  - Flip Up Front & Up Back: FRUR'U'F'
  - Flip Up Front & Up Right: FURU'R'F'
- Up Face
  - Rotate 3 CCW, lock Up Back Left: R'U'RU'R'U2R
  - Rotate 3 CW, lock Up Front Left: RUR'URU2R' 
- Swap Up Corners
  - "Headlights" right face to front face: R2F2R'B'RF2R'BR'
  - "Headlights" front face to right face: RB'RF2R'BRF2R2
- Swap Up Edges
  - Lock Up Back, swap CCW: RU'RURURU'R'U'R2
  - Lock Up Back, swap CW: L'UL'U'L'U'L'ULUL2
```

TBD: Use [this](https://ruwix.com/online-rubiks-cube-solver-program/) to generate some diagrams, and format this a bit more robustly.

### [Heise Method](https://www.ryanheise.com/cube/heise_method.html)

No "algorithms" per se, focuses on building an intuitive feeling on how the cube works.

- Make four 2x2 squares
- Match squares and orient edges
- Solve remaining edges and any 2 corners
- Solve last 3 corners

### [8355 Method](https://www.speedsolving.com/wiki/index.php/8355_Method)

Beginner method with few algorithms. Referenced several times is "Sexy move" `RUR'U'`.

- Cross on Down
- 3 Down corners
  - Position target corner in U above its desired location in D, and repeat sexy move until placed and oriented.
- 3 E-slice edges, using [Keyhole method](https://www.speedsolving.com/wiki/index.php/Keyhole_F2L)
  - Position a target edge piece such that its Up color matches the Front face
	- Position keyhole under the desired location
	- Keyhole up/away from target, rotate Up to place target on the keyhole, return keyhole down.
	- This is either `RU'R'` if keyhole is to the right, or `L'UL` if keyhole is to the left.
- Remaining edges
  - Keep keyhole in front-right
	- Rotate Up to aim keyhole edge correctly relative to other correct Up edges
	- Rotate `F'` or `R` into place, rotate U to position another incorrect edge in that position, and restore keyhole with `F` or `R'`
	- To swap the last two edges, position the gap for the final Up edge as expected based on its orientation in the keyhole, and then either FR/UF: `UF'UFU'FUF`, or FR/UR: `U'RU'R'U'RU'R'`. (Intuitively, you're moving the gap to last spot, and then bubbling the edges back and forth to fit them all in place.)
- Final 5 corners
  - **Flip cube Up/Down**
  - If the keyhole corner UFR belongs in Down, rotate D until it is above its correct position, and repeat sexy move until placed and oriented. This will break the top of the cube, but only temporarily - just keep the orientation correct.
	- Rotate D to place next corner, and repeat.
	- When only 2 corners remain unplaced, repeat sexy move until the rest of the cube fixes itself, then **rotate cube so unsolved corners are on Down layer**.
	- Using a solved corner as the keyhole, repeat above to solve the cube:
	  - if corners need to swap, sexy once to move corner up, rotate Down to the other corner, and sexy until placed, then rotate Down back and sexy until complete.
		- if corners just need to rotate, sexy to rotate the first, then rotate Down and sexy the other one til correct, and rotate Down back to complete.



