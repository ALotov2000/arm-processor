alias clc ".main clear"

clc
exec vlib work
vmap work work

# Define paths for your testbench (TB) and HDL files
set TB                   "ARMModuleTest"
set TB_file              "src/test/integration.test.v"
set inc_path "inc"
set hdl_path             "src/hdl"

# Set simulation run time
set run_time             "10 us"
# set run_time           "-all"

#============================ Add verilog files  ===============================
# Please add other module here
set hdl_files [exec find $hdl_path -type f -name "*.v"]

foreach file $hdl_files {
    vlog +acc -incr -source +define+SIM $file
}

vlog    +acc -incr -source  +incdir+$inc_path +define+SIM    $TB_file
onerror {break}

#================================ Simulation ====================================
vsim    -voptargs=+acc -debugDB $TB

#======================= Adding signals to the wave window =====================
add wave -hex -group        {TB}               sim:/$TB/*
add wave -decimal -group {Val2Gen} sim:/$TB/u_ARMModule/u_ExecutionStage/u_Val2Generator/*
add wave -decimal -group        {Instruction Decode}               sim:/$TB/u_ARMModule/u_InstructionDecodeStage/registerFile/REGISTERS
add wave -hex -group        {Memory}               sim:/$TB/u_ARMModule/u_MemoryStage/u_Memory/memoryRead sim:/$TB/u_ARMModule/u_MemoryStage/u_Memory/memoryWrite
add wave -decimal -group        {Memory}               sim:/$TB/u_ARMModule/u_MemoryStage/u_Memory/registers
add wave -binary -group        {Status}               sim:/$TB/u_ARMModule/u_StatusRegister/out
add wave -hex -group -r     {all}              sim:/$TB/*
add wave -binary -position 0 sim:/$TB/u_ARMModule/SRAMFreeze
add wave -decimal -position 0 -group -r {SRAMController} sim:/$TB/u_ARMModule/u_MemoryStage/u_SRAMController/*
add wave -binary -position 0 sim:/$TB/u_ARMModule/hazardFreeze
add wave -binary -position 0 sim:/$TB/u_ARMModule/bothFreeze
add wave -hex -position 0 sim:/$TB/u_ARMModule/writeBackValue_wb
add wave -hex -position 0 sim:/$TB/u_ARMModule/writeBackEnabled_wb
add wave -hex -position 0 sim:/$TB/u_SRAM/mem[1024]
add wave -hex -position 0 sim:/$TB/u_SRAM/mem[1028]
add wave -decimal -position 0 sim:/$TB/u_SRAM/mem

#=========================== Configure wave signals =============================
# configure wave -signalnamewidth 2

#================================= Run Simulation ===============================
run $run_time