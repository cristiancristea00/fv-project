# Functional Verification Project - Verification Plan

- When a data packet is sent to the module, the module should add it to the buffer only if the write enable signal is asserted and the buffer is not full.
- The internal buffer should fill up only up to the maximum size set by the threshold parameter and should assert the full signal when the buffer is full.
- The threshold parameter should be able to take values from 0 (no packets can be stored) to 32 (the maximum number of packets that can be stored in the buffer). If the threshold is set to 0, the buffer should not store any packets. Furthermore, if the threshold is set to a value greater than 32, the buffer should store only 32 packets at most and should assert the full signal when the buffer is full.
- The module should output the UART frames until the buffer is empty. Therefore, there should be no output when the buffer is empty.
- The module should be able to switch between the four available baud rates (`CLK/16`, `CLK/32`, `CLK/64` and `CLK/128`) by asserting the baudrate select signal.
- When the reset signal is asserted, the module should clear the buffer and stop the current UART frame transmission.

## Testbench Architecture

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="img/tb-dark.svg">
  <source media="(prefers-color-scheme: light)" srcset="img/tb-light.svg">
  <img alt="Shows a diagram of the UVM testbench architecture." src="img/tb-light.svg">
</picture>
