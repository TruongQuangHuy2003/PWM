# PWM Generator Module

This repository contains the Verilog implementation of a simple Pulse Width Modulation (PWM) generator module. The design allows for generating a PWM signal with a configurable duty cycle, controlled by an 8-bit input.

## Overview

The `pwm_generator` module is designed to generate a PWM signal based on the input duty cycle. It includes a counter and logic to compare the counter value with the duty cycle, producing a high or low signal accordingly.

### Features
- **Configurable Duty Cycle**: The duty cycle can be set using the 8-bit `duty` input.
- **Reset Functionality**: Supports both asynchronous reset (`rst_n`) and a counter-specific reset (`rst_counter`).
- **Compact Design**: Utilizes an 8-bit counter to minimize resource usage.

## Module Interface

### Inputs
- **clk**: Clock signal (positive edge triggered).
- **rst_n**: Asynchronous active-low reset signal for the entire module.
- **duty**: 8-bit input to specify the duty cycle of the PWM signal.
- **rst_counter**: Active-low reset for the internal counter.

### Output
- **pwm**: The generated PWM signal.

## Functional Description

1. **Reset Behavior**:
   - When `rst_n` is low, both the counter (`count`) and the PWM output (`pwm`) are reset to zero.
   - When `rst_counter` is low, the counter (`count`) is reset to zero, but the PWM output (`pwm`) continues to operate normally based on the duty cycle.

2. **PWM Signal Generation**:
   - The internal 8-bit counter (`count`) increments on each rising edge of the clock (`clk`).
   - The `pwm` output is set high (`1`) when `count` is less than the value of `duty`, and low (`0`) otherwise.
