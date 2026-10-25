# SystemVerilog RAM Verification

## Overview

This project implements a 256 × 8-bit RAM and a SystemVerilog testbench to verify its basic read and write operations.

The testbench uses an object-oriented structure with separate components for transaction generation, signal driving, monitoring, and result checking.

## Design Specifications

| Parameter | Value |
|---|---|
| Memory depth | 256 locations |
| Data width | 8 bits |
| Address width | 8 bits |
| Clock period | 10 ns |
| Clock frequency | 100 MHz |

## Testbench Architecture

- **MemoryTransaction:** Represents read and write transactions.
- **Generator:** Generates randomized write transactions followed by reads from the same addresses.
- **Driver:** Applies transactions to the DUT through a virtual interface.
- **Monitor:** Observes and records the DUT signals.
- **Scoreboard:** Compares the observed read data against an expected memory model.
- **Interface:** Connects the testbench components to the DUT.
- **Testbench:** Instantiates the DUT and coordinates the verification components.

## Project Structure

```text
systemverilog-ram-verification/
├── rtl/
│   └── memory.sv
└── tb/
    ├── memory_if.sv
    ├── memory_tb_pkg.sv
    ├── memory_transaction.sv
    ├── generator.sv
    ├── driver.sv
    ├── monitor.sv
    ├── scoreboard.sv
    └── tb.sv
```

## Test Scenario

The Generator creates five write transactions. Each write is followed by a read from the same address, resulting in ten transactions.

The Scoreboard maintains an expected memory model and checks the read data returned by the DUT.

## Simulation

The testbench is intended to be compiled using Synopsys VCS.

From the repository root, run:

```bash
vcs -sverilog +incdir+tb \
    tb/memory_if.sv \
    tb/memory_tb_pkg.sv \
    rtl/memory.sv \
    tb/tb.sv \
    -o simv
```

Run the simulation:

```bash
./simv
```

## Tools and Languages

- SystemVerilog
- Synopsys VCS
- Object-oriented testbench development
- Mailboxes and virtual interfaces
- Reference-model-based checking

## Future Improvements

- Add directed tests for boundary addresses.
- Verify consecutive writes and memory overwrites.
- Add functional coverage.
- Expand the range of read and write scenarios.
