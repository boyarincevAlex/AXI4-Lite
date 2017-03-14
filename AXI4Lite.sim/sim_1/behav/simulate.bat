@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xsim testbench_write_behav -key {Behavioral:sim_1:Functional:testbench_write} -tclbatch testbench_write.tcl -view C:/Users/Admin/Desktop/AXI4Lite/AXI4Lite.sim/sim_1/Write.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
