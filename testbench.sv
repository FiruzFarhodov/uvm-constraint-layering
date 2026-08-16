`include "uvm_macros.svh"
import uvm_pkg::*;

class reg_transaction extends uvm_sequence_item;
  rand bit [1:0]  operation;
  rand bit [1:0] data;
  rand bit [1:0] addr;

  `uvm_object_utils(reg_transaction)
  
  function new(string name = "reg_transaction");
    super.new(name);
  endfunction
  
  constraint op_data_n_addr1{
    if(operation == 2'b01) {
      data != 1;
      addr != 1;
    }
  }
  
  constraint op_data_n_addr2{
    if(operation == 2'b00) {
    data != 0;
    addr != 0;
    }
  }
  
  constraint op_data_n_addr3{
    if(operation == 2'b10) {
      data != 2;
      addr != 2;
    }
  }
endclass


class reg_env extends uvm_env;
  reg_transaction tr;
  `uvm_component_utils(reg_env)
  
  function new(string name = "reg_env", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tr = reg_transaction::type_id::create("trans", this);   
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    repeat (4) begin
    tr.randomize();
    
    `uvm_info("ENV", $sformatf("Operation : %d | Data: %d | Addr: %d", tr.operation, tr.data, tr.addr), UVM_LOW);
    end
    tr.op_data_n_addr1.constraint_mode(0);
    tr.op_data_n_addr2.constraint_mode(0);
    tr.op_data_n_addr3.constraint_mode(0);
    repeat (4) begin
      tr.randomize();
      
      `uvm_info("ENV", $sformatf("Operation : %d | Data: %d | Addr: %d", tr.operation, tr.data, tr.addr), UVM_LOW);
    end
    
    phase.drop_objection(this);
  endtask
endclass
          
module tb;
  initial begin
    run_test("reg_env");
  end
endmodule
                  
/*
UVM_INFO @ 0: reporter [RNTST] Running test reg_env...
UVM_INFO testbench.sv(58) @ 0: uvm_test_top [ENV] Operation : 3 | Data: 3 | Addr: 0
UVM_INFO testbench.sv(58) @ 0: uvm_test_top [ENV] Operation : 0 | Data: 3 | Addr: 1
UVM_INFO testbench.sv(58) @ 0: uvm_test_top [ENV] Operation : 1 | Data: 2 | Addr: 0
UVM_INFO testbench.sv(58) @ 0: uvm_test_top [ENV] Operation : 0 | Data: 3 | Addr: 3
UVM_INFO testbench.sv(66) @ 0: uvm_test_top [ENV] Operation : 3 | Data: 0 | Addr: 1
UVM_INFO testbench.sv(66) @ 0: uvm_test_top [ENV] Operation : 0 | Data: 3 | Addr: 2
UVM_INFO testbench.sv(66) @ 0: uvm_test_top [ENV] Operation : 3 | Data: 0 | Addr: 1
UVM_INFO testbench.sv(66) @ 0: uvm_test_top [ENV] Operation : 2 | Data: 2 | Addr: 3
UVM_INFO /apps/vcsmx/vcs/X-2025.06-SP1//etc/uvm-ieee/src/base/uvm_report_server.svh(902) @ 0: reporter [UVM/REPORT/SERVER] 
--- UVM Report Summary ---

** Report counts by severity
UVM_INFO :   10
UVM_WARNING :    0
UVM_ERROR :    0
UVM_FATAL :    0
** Report counts by id
[ENV]     8
[RNTST]     1
[UVM/RELNOTES]     1

*/
          
