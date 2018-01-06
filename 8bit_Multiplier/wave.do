view wave 
wave clipboard store
wave create -driver freeze -pattern constant -value zzzzzzzz -range 7 0 -starttime 0ns -endtime 1000ns sim:/multiplier/S 
WaveExpandAll -1
wave create -driver freeze -pattern clock -initialvalue HiZ -period 100ns -dutycycle 50 -starttime 0ns -endtime 1000ns sim:/multiplier/Clk 
wave create -driver freeze -pattern constant -value 0 -starttime 0ns -endtime 1000ns sim:/multiplier/Run 
wave create -driver freeze -pattern constant -value 0 -starttime 0ns -endtime 1000ns sim:/multiplier/ClearA_LoadB 
wave modify -driver freeze -pattern clock -initialvalue HiZ -period 100ns -dutycycle 50 -starttime 0ns -endtime 1000ns Edit:/multiplier/Clk 
wave modify -driver freeze -pattern constant -value St1 -starttime 75ns -endtime 100ns Edit:/multiplier/ClearA_LoadB 
wave modify -driver freeze -pattern constant -value 11111101 -range 7 0 -starttime 0ns -endtime 1000ns Edit:/multiplier/S 
wave modify -driver freeze -pattern constant -value 11111010 -range 7 0 -starttime 200ns -endtime 1000ns Edit:/multiplier/S 
wave modify -driver freeze -pattern constant -value St1 -starttime 250ns -endtime 275ns Edit:/multiplier/Run 
wave modify -driver freeze -pattern constant -value St1 -starttime 250ns -endtime 1000ns Edit:/multiplier/Run 
WaveCollapseAll -1
wave clipboard restore
