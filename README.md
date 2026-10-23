# Mini 8-bit Accumulator CPU (VLSI Lab Final Project)

**Course:** CSE 450 (VLSI Lab)  
**Student Name:** Israt Jahan Mou  
**Student ID:** 22201129  
**Assigned Set:** Set 9  
**Target Instructions:** `LDI`, `ADD`, `NOT`, `SHL`, `JZ`

## 📌 Project Overview
This project implements a small, single-cycle 8-bit accumulator-based CPU in VHDL. The design follows a strict **bottom-up structural methodology**, starting from primitive logic gates to build a full ALU and datapath, and finally integrating everything into a single top-level CPU. 

The CPU fetches 12-bit instructions from a Program ROM, decodes the opcode using a Control Unit, executes the operation in an 8-bit ALU, and updates the Accumulator (ACC), Zero Flag (Z), and Program Counter (PC) accordingly on every rising edge of the clock.

## 📂 Directory Structure
* `src/` - Contains all VHDL source files (entities and architectures).
* `tb/` - Contains the VHDL testbench for automated verification.
* `docs/` - Contains the final report and simulation waveform screenshots.

## 🏗️ System Architecture (Bottom-Up Hierarchy)

### 1. Foundation (Gates & Adders)
* `nand_g.vhd`: Base NAND gate (Dataflow).
* `and_g.vhd`, `or_g.vhd`, `xor_g.vhd`: Primitive logic gates built structurally from NAND.
* `half_adder.vhd`, `full_adder_g.vhd`: 1-bit addition logic.
* `full_adder_8bit_g.vhd`: 8-bit Ripple Carry Adder (RCA) built using a `for...generate` loop.

### 2. Datapath & Memory (Registers & ALU)
* `acc_reg.vhd`: 8-bit Accumulator with synchronous reset and load-enable (also serves as the CPU output `Q`).
* `z_flag.vhd`: 1-bit Zero flag (updates when ACC is written).
* `pc_reg.vhd`: 4-bit Program Counter (supports `PC+1` and Jump load).
* `alu.vhd`: Combinational 8-bit ALU that reuses the gate-level RCA for `ADD`, and supports `LDI`, `NOT`, and `SHL`.

### 3. Control & Memory
* `program_rom.vhd`: 16x12-bit Read-Only Memory hardcoded with the **Appendix B (Set 9)** program.
* `control_unit.vhd`: Decodes `INSTR[11:8]` to generate `ALU_OP`, `ACC_EN`, `Z_EN`, and `PC_LOAD`. All unspecified opcodes act as NOP.

### 4. Top Level
* `cpu_top.vhd`: Structurally wires all the above modules together. Exposes `CLK`, `RESET`, `Q[7:0]`, `Z`, and `PC_OUT[3:0]`.

## 🧪 Verification & Simulation
The testbench `tb/cpu_tb.vhd` is a **self-checking testbench** designed to verify the CPU against the exact cycle-by-cycle expected values from Appendix B (Set 9).

**Expected Simulation Output:**
Upon running the testbench, all 8 cycles are checked for ACC, Z, and PC values. If successful, the console will print:
```text
ALL 8 CYCLES MATCH APPENDIX B (SET 9)