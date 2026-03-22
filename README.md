# Tug of War – FPGA FSM Game

## Overview
FPGA project for **CSE 369: Intro to Digital Design**, where I designed a two-player electronic version of Tug of War.  
The game uses **multiple interconnected FSMs** to manage player inputs, LED playfield movement, and victory display.  

The project highlights:

- Sequential logic and FSM design  
- Modular SystemVerilog development  
- Simulation and debugging in **ModelSim**  
- FPGA deployment on **DE1-SoC board** with switches and LEDs  

---

## Game Mechanics

- **Playfield:** 9 LEDs (LEDR9 to LEDR1) represent the rope/knot  
- **Controls:**
  - `KEY0` → Player 1 moves knot **right**  
  - `KEY3` → Player 2 moves knot **left**  
  - `SW9` → reset  
- **Victory:** When a knot reaches the edge LED of a player, the 7-segment display (`HEX0`) shows the winner’s number (1 or 2)  
- **Clock:** Uses 50 MHz system clock (`CLOCK_50`)  
- **Metastability Protection:** Each button input passes through a 2-stage D flip-flop synchronizer  
- **Edge Detection:** Button press triggers output high for **1 clock cycle** regardless of press duration  

---

## Design Approach

1. **Modular FSMs:** Each LED and input handled with its own FSM (max 4 states per module)  
2. **Input Handling:** Buttons synchronized and edge-detected to prevent metastability issues  
3. **Playfield FSMs:** Determine LED state based on current position, neighbors, and player input  
4. **Victory Module:** Monitors edges of the playfield to detect a winner  
5. **Top-Level Integration:** Connect all modules with clear interconnections and reset handling  
6. **Simulation First:** Each module independently simulated in **ModelSim** before combining  
7. **FPGA Deployment:** After full simulation, program DE1-SoC board for real-time testing  

---

## How to Play

- Press **KEY0** to tug the ribbon right (Player 1)  
- Press **KEY3** to tug the ribbon left (Player 2)  
- Watch the 9-LED playfield move in response  
- When a player wins, **HEX0** displays 1 or 2  
- Press **SW9** to reset the game  

---

## Testing

- Each FSM individually tested with dedicated testbenches  
- Verified correct LED transitions, edge detection, and playfield movement  
- Full system simulation ensures correct winner detection and 7-segment display output  
- FPGA testing validates real-time interaction  

---

## FPGA Mapping

- **Inputs:**  
  - `KEY0` → Player 1  
  - `KEY3` → Player 2  
  - `SW9` → reset  

- **Outputs:**  
  - `LEDR1–LEDR9` → playfield LEDs  
  - `HEX0` → winner display  

---

## Resource Utilization

- Synthesized design in **Quartus**  
- Checked **Combinational ALUTs** and **Dedicated Logic Registers**  
- Optimized FSMs for minimal FPGA resources (bonus potential)  

---

## Learning Outcomes

- Developed modular FSMs for complex sequential logic  
- Handled real-world hardware issues like **metastability**  
- Practiced **test-driven FPGA development**  
- Gained experience with **input synchronization, edge detection, and inter-FSM communication**  

---
