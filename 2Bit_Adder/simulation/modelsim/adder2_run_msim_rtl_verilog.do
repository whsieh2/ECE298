transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/altera/13.0/ece298/2Bit_Adder {C:/altera/13.0/ece298/2Bit_Adder/full_adder.sv}
vlog -sv -work work +incdir+C:/altera/13.0/ece298/2Bit_Adder {C:/altera/13.0/ece298/2Bit_Adder/adder2.sv}

