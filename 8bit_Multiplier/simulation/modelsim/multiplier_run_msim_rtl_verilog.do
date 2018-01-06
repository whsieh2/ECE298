transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/altera/13.0/ece298/6\ final {C:/altera/13.0/ece298/6 final/HexDriver.sv}
vlog -sv -work work +incdir+C:/altera/13.0/ece298/6\ final {C:/altera/13.0/ece298/6 final/multiplier.sv}
vlog -sv -work work +incdir+C:/altera/13.0/ece298/6\ final {C:/altera/13.0/ece298/6 final/reg_8.sv}
vlog -sv -work work +incdir+C:/altera/13.0/ece298/6\ final {C:/altera/13.0/ece298/6 final/add_sub.sv}
vlog -sv -work work +incdir+C:/altera/13.0/ece298/6\ final {C:/altera/13.0/ece298/6 final/FA.sv}
vlog -sv -work work +incdir+C:/altera/13.0/ece298/6\ final {C:/altera/13.0/ece298/6 final/Dreg.sv}
vlog -sv -work work +incdir+C:/altera/13.0/ece298/6\ final {C:/altera/13.0/ece298/6 final/control.sv}

