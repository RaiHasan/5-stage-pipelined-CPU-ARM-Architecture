onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /control_unit_tb/instruction
add wave -noupdate /control_unit_tb/reg2Loc
add wave -noupdate /control_unit_tb/Branch
add wave -noupdate /control_unit_tb/condBranch
add wave -noupdate /control_unit_tb/ALUsrc
add wave -noupdate /control_unit_tb/memAddr
add wave -noupdate /control_unit_tb/loadReg
add wave -noupdate /control_unit_tb/memRead
add wave -noupdate /control_unit_tb/memWrite
add wave -noupdate /control_unit_tb/setFlag
add wave -noupdate /control_unit_tb/aluCtrl
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {299999657 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 50
configure wave -gridperiod 100
configure wave -griddelta 2
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {299999500 ps} {300000500 ps}
