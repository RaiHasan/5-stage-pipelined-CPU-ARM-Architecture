# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have their own
#     "vlog" line below.
#vlog "./DE1_SoC.sv"
#     Alternatively, you can include all SystemVerilog files in the current
#     folder using ONLY the following line:
#vlog "./*.sv"
vlog "./D_FF.sv"
vlog  "./D_FF_enable.sv"
vlog    "./register_64Bit.sv"
vlog    "./register_1Bit.sv"
vlog    "./register_32Bit.sv"
vlog    "./register_3Bit.sv"
vlog    "./register_5Bit.sv"
vlog    "./decoder2_4.sv"
vlog    "./decoder3_8.sv"
vlog    "./decoder5_32.sv"
vlog    "./mux_2_1.sv"
vlog    "./mux_2_5.sv"
vlog    "./mux_2_64_1.sv"
vlog    "./mux_8_1.sv"
vlog    "./mux_32_1.sv"
vlog    "./mux64_32.sv"
vlog    "./mux_2_64_1.sv"
vlog    "./mux_4_64_1.sv"
vlog    "./mux_2_32_1.sv"
vlog    "./mux_2_11_1.sv"
vlog    "./full_adder.sv"
vlog    "./adder_64Bit.sv"
vlog    "./ALU_bit_slice.sv"
vlog    "./alu.sv"
vlog    "./sign_extender.sv"
vlog    "./logical_shift_left2.sv"
vlog    "./flagRegisters.sv"
vlog    "./control_unit.sv"
vlog    "./regfile.sv"
vlog    "./instructmem.sv"
vlog    "./datamem.sv"
vlog    "./CPU_single.sv"
vlog    "./CPU_single_tb.sv"
vlog    "./IF_ID.sv"
vlog    "./ID_EX.sv"
vlog    "./EX_MEM.sv"
vlog    "./MEM_WB.sv"
vlog    "./hazard_detection.sv"
vlog    "./forwarding_unit.sv"
vlog    "./equalToZero.sv"
vlog    "./BR_forwarding.sv"
#     This uses the asterisk (*) to match all files ending in ".sv" at once.
#     NOTE: If you have incomplete files in the current folder, they will be
#     picked up, and will probably fail to compile. Delete any old/unused
#     files, or include only the specific files you need.

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the testbench module
#     you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work CPU_single_tb


# Source the wave setup file
#     This should be the file that sets up the signal window for the module you
#     are testing.
do CPU_single_wave.do

# Make sure relevant windows are visible
view wave
view structure
view signals

# Run the simulation!
run -all
