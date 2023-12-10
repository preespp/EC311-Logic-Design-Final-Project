# EC311-Logic-Design-Final-Project

Project Name: Whack-a-mole game with VGA display, Mouse Input and Time limit

This repository dedicated to Final Project for EC311 Introduction to Logic Design Fall 2023 Boston University taught by professor Douglas Densmore.

This project is inspired by this user's project. We will improve by using graphic and modify some game logic such as adding time limit option, slowing down the clock, etc. behind the original code from nyLiao

Group Members:

1.Pree Simphliphan Computer Engineering class of 2026

2.Rawisara Chairat Computer Engineering class of 2026

3.Arnav Pratap Chaudhry Computer Engineering class of 2026

4.Vansh Bhatia Electrical Engineering class of 2025

Demo Video:

How to run our code:
1. Import all the verilog code modules into Vivado 2019.1
2. Download constraint file for final version of top modules (Contrantfileforfinalversion.xdc) and import into your vivado project.
3. Having FPGA board (NEXYS-A7) ready to connected with monitor and mouse
4. Set Top_module file as the top one; then synthesize, implement, and generate bitstream for fpga board.
5. Push the bitstream to the board and have Fun!

How to play the game!
1. Click on the level you want to play
2. Click on play button and it will bring you to the play page
3. You will have 30 seconds to hit the moles that pop up in one of each 8 moles.
4. Keep in mind that they're randomly generated and they can be generated at the same holes.
5. You will get 3 points each time you hit the mole but you will not be penalized for each mistake.

Overview of the code structure:
The folder Whac-A-Mole-FPGA is created by nyLiao (https://github.com/nyLiao/Whac-A-Mole-FPGA). There are some modification on the original code for this project as following:
1. We cut wam_lst file because we want to test on fpga board if the modification of main logic works or not; therefore we don't need dim light functionility of 7-segment display.
2. We don't use wam.ucf (the constraint file for their version and fpga board)
3. We don't use wam_main but we use it as a prototype for our own module.
4. We don't use wam_m.bit (their bitstream file from wam_main)
5. We use the same algorithm and logic from wam_scr.v (containing wam_scr and wam_cnt modules for detecting the player's score)
6. We keep wam_hrd.v (containing wam_tch, wam_hrd and wam_par for sending the value of parameter for each difficulty)
7. We use the same wam_hit.v (containing wam_tap.v and wam_hit.v to check if the player hits the mole or not)
8. We use the same generator (wam_gen.v) but we will change the clock frequency input to slow down the mole speed in our top module.
9. Lastly, we keep the wam_dis.v file for fpga testing with led and 7-segment display purpose; however, we need to display 8 digits to display both time display and score with difficulty; which means we need to add the case condition in wam_dis.v.

Game_logic.v: this module is modeled from wam_main.v. The main purpose is for connecting generator module(wam_gen.v), hit checker module (wam_hit), and score module (wam_scr).
This module will receive input pause signal from time_counter module to check if the generator is stopped or not, start signal from time_counter to check if the game is restarted, the difficulty variable, and tap variable to check which holes are clicked. Then, it will output the holes variables for vga to display which holes are mole generated at a certain time and output score for vga to display.

fpga_test.v: this module contained difficulty module(since we control this by button when we test the game logic with time_counter on fpga board), tap module(we input this from switch on fpga), led and display modules (to output led and 7-segment on fpga board).

Time_counter.v: this module is created for 30-sec timer. It will receive start signal to indicate the start. It will have count to slow down the clock frequency to exact 1 second in real life, but we also need pause signal to connect with the old code from myliao to indicate the generator to stop. However, our modules will be only able to play on 1st, 3rd, 5th time we click start because of latches happened on the posedge of pause signal in the original module; hence, to fix this, we add activate signal to get rid of this latch.
It will output the time_display as an output along with pause signal for the generator module.

music.v: we played music background via buzzer by adding pac-man note we found on musescore. We adjust the clock and write FSM to generate each note in each state with the counter in each state to determine the different range of each note. Lastly, we add the condition to play sound at each state of FSM.


For FPGA Test modules
1. We display time on 7-segment display; we have to change number of bits of an.
2. We use pause signal along with timer countdown; we don't need pause button anymore
3. We connect music background to output music, we connect game_logic with fpga_test to hook the input switch and button to check if the game logic works with the time_counter on FPGA or not.

For Top Module
We connect time_counter, vga_display, mouse, music, and game_logic to display our final product.

Testbench files
For the simulation test, to correct the mistakes of logic.

Schematic (Updated Block Diagram from presentation)

