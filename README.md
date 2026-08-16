# UVM Constraint Layering & Randomization

A SystemVerilog UVM example demonstrating how to structure conditional constraints, layer transaction rules, and dynamically toggle constraint blocks using `constraint_mode()` to generate diverse testbench traffic patterns.

## 📌 Key Highlights
- **Conditional Constraints:** Prevents constraint solver conflicts by structuring mutually exclusive rules using `if-else` blocks.
- **Dynamic Control:** Demonstrates enabling (`1`) and disabling (`0`) specific constraint blocks dynamically in the environment phase via `constraint_mode()`.
- **Pattern Generation:** Generates controlled read/write transaction streams and unconstrained random sequences within a single test execution.

## 🛠 Project Components
- `reg_transaction`: Sequence item defining randomized fields (`operation`, `addr`, `data`) and distinct constraint blocks.
- `reg_env`: Environment component managing objection handling, constraint mode execution, and log reporting.
- `tb`: Top-level module executing `run_test()`.

## 🚀 How to Run
1. Open the project on [EDA Playground](https://www.edaplayground.com/x/nwW3).
2. Ensure **UVM / OVM** is set to `UVM IEEE 1800.2-2017` in the left sidebar.
3. Select **Synopsys VCS** or **Cadence Xcelium** under **Tools & Simulators**.
4. Click **Run** to execute the simulation and review transaction patterns in the log output.
