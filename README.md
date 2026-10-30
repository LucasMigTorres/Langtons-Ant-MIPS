# Langtons-Ant-in-MIPS
An implementation of Langton's Ant in MIPS assembly language.

<img width="968" height="683" alt="ant_finished" src="https://github.com/user-attachments/assets/8b0f91f7-2422-4e66-88ae-03151e76d5df" />

# About Langton's Ant
Langton's Ant is a two-dimensional turning machine and cellular automaton created by Chris Langton in 1986, 
where each square has two states (black or white) and one is identified as the "ant".

<img width="507" height="507" alt="ant_running2" src="https://github.com/user-attachments/assets/79aa8293-bfdf-40c4-9334-f4976c6c8664" />

After around 10,000 steps, the ant will begin to make a "highway" that repeats indefinitely.

The ant behaves according to the following set of rules:
- On a white pixel/square, turn 90° clockwise, flip the color of the current square, and move forward one unit
- On a black pixel/square, turn 90° counter-clockwise, flip the color of the current square, and move forward one unit

# How to run it
To run this implementation of Langton's Ant for yourself, download the MARS 4.5 Simulator, 
which can be found here in the tools folder.
You must also have Java installed on your machine to run MARS.

<br>

Download any of the three .asm files:
- langtons_ant(1x1) - Each unit in the display is 1 pixel
- langtons_ant(2x2) - Each unit in the display is 2x2 pixels
- langtons_ant(4x4) - Each unit in the display is 4x4 pixels

<br>

In MARS, the Bitmap Display can be found under the "Tools" tab.

For each .asm file, configure the Bitmap Display as follows:
- langtons_ant(1x1)
  - Unit Width in Pixels: 1
  - Unit Height in Pixels: 1
- langtons_ant(2x2)
  - Unit Width in Pixels: 2
  - Unit Height in Pixels: 2
- langtons_ant(4x4)
  - Unit Width in Pixels: 4
  - Unit Height in Pixels: 4
 
For all three:
- Display Width in Pixels: 512
- Display Height in Pixels: 512
- Base address for display: 0x100100000 (static data)
