remove_design -all
set search_path {../lib}
set target_library {lsi_10k.db}
set link_library "* lsi_10k.db"

analyze -format verilog ../rtl/ALU/alu.v 

elaborate alu

link 

check_design

current_design  alu

compile_ultra

write_file -f verilog -hier -output alu_netlist.v


 

