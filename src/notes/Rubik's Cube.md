---
title: Rubik's Cube
created: '2021-06-15T18:31:12.224Z'
modified: '2021-06-15T19:16:42.054Z'
---

# Rubik's Cube

Via [Cedric Beust](http://beust.com/rubik/), circa 2003. Aims to be easy to memorize (few small moves).

Cube handling notes:

- The cube has three pairs of opposite faces: Top/Bottom, Front/Back, Left/Right. Reorient as needed.
- Move syntax uses one letter to reference a side, and optional direction marker. For example, `T` rotates the top face clockwise, `T'` rotates anticlockwise.

The solve, first few steps left as an exercise to the reader:

0. Pick a colour to start, this is Top.
1. Solve top edges.
2. Solve 3 top corners.
3. Solve 3 middle edges, using the remaining top corner as a "working" column.
4. Solve 4th top corner.
5. Flip the cube, original colour is now Bottom.
6. Finish middle layer. Align last cube to match front colour and then:
   Move top front to right front `URU'R' U'F'UF`
   Move top front to left front `U'L'UL UFU'F'`
7. Orient top edges.
   Flip front + right: `FUR U'R'F'`
   Flip front + back: `FRU R'U'F'`
8. Position top edges. Rotate top to try and match two, then,
   Swap left + back: `UR'UUR UR'UR`
9. Position top corners. Sequence leaves back left untouched.
   Swap front left -> front right -> back right: `ULU'R' UL'U'R`
10. Orient top corners. Keep the cube positioned with a consistent side as front, repeat sequence until oriented and then rotate top layer only to bring a different corner to front-right. Parity will fix the rest of the cube when you're done.
   Rotate front right: `RF'R'F RF'R'F`


