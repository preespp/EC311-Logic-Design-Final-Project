# EC311-Logic-Design-Final-Project

This repository dedicated to Final Project for EC311 Introduction to Logic Design Fall 2023 Boston University taught by professor Douglas Densmore.

This project is inspired by this user's project. We will improve by using graphic and modify some game logic behind the original code from nyLiao

Group Members:

1.Pree Simphliphan

2.Rawisara Chairat

3.Arnav Pratap Chaudhry

4.Vansh Bhatia

The folder Whac-A-Mole-FPGA is created by nyLiao (https://github.com/nyLiao/Whac-A-Mole-FPGA). There are some modification on the original code for this project as following:

For FPGA Test modules
1. We cut wam_lst file because we want to test on fpga board if the modification of main logic works or not; therefore we don't need dim light functionility of 7-segment display.
2. We display time on 7-segment display; we have to change number of bits of an.
3. We use pause signal along with timer countdown; we don't need pause button anymore

For Top Module
