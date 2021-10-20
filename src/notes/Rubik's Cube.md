---
title: Rubik's Cube
created: '2021-06-15T18:31:12.224Z'
modified: '2021-09-08T20:43:44.812Z'
---

# Rubik's Cube

Via [Cedric Beust](http://beust.com/rubik/), circa 2003. Aims to be easy to memorize (few small moves).

Cube handling notes:

- The cube has three pairs of opposite faces: Top/Bottom, Front/Back, Left/Right. Reorient as needed.
- Move syntax uses one letter to reference a side, and optional direction marker. For example, `T` rotates the top face clockwise, `T'` rotates anticlockwise.

The solve, first few steps left as an exercise to the reader:

1. Pick a colour to start, this is Top.
2. Solve top edges.
3. Solve 3 top corners.
4. Solve 3 middle edges, using the remaining top corner as a "working" column.
5. Solve 4th top corner.
6. Flip the cube, original colour is now Bottom.
7. Finish middle layer. Align last cube to match front colour and then:
   Move top front to right front `URU'R' U'F'UF`
   Move top front to left front `U'L'UL UFU'F'`
8. Orient top edges.
   Flip front + right: `FUR U'R'F'`
   Flip front + back: `FRU R'U'F'`
9. Position top edges. Rotate top to try and match two, then,
   Swap left + back: `UR'UUR UR'UR`
10. Position top corners. Sequence leaves back left untouched.
   Swap front left -> front right -> back right: `ULU'R' UL'U'R`
11. Orient top corners. Keep the cube positioned with a consistent side as front, repeat sequence until oriented and then rotate top layer only to bring a different corner to front-right. Parity will fix the rest of the cube when you're done.
   Rotate front right: `RF'R'F RF'R'F`

### Chinese Cube Instructions

```
- Solve Down edges, corners
- Middle layer edges: align edge to match Front or Right
  - Top Front to Front Right: FUFUFU'F'U'F'
  - Top Right to Front Right: R'U'R'U'R'URUR
  - Flip Front Right: RU2R' U RU2R' U F'U'F
- Top Cross
  - Flip Top Front & Top Back: FRUR'U'F'
  - Flip Top Front & Top Right: FURU'R'F'
- Top Face
  - Rotate 3 CCW, lock Top Back Left: R'U'RU'R'U2R
  - Rotate 3 CW, lock Top Front Left: RUR'URU2R' 
- Swap Top Corners
  - "Headlights" right face to front face: R2F2R'B'RF2R'BR'
  - "Headlights" front face to right face: RB'RF2R'BRF2R2
- Swap Top Edges
  - Lock Top Back, swap CCW: RU'RURURU'R'U'R2
  - Lock Top Back, swap CW: L'UL'U'L'U'L'ULUL2
```

TBD: Use [this](https://ruwix.com/online-rubiks-cube-solver-program/) to generate some diagrams, and format this a bit more robustly.


