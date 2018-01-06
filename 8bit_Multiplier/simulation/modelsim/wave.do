view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue 0 -period 50ps -dutycycle 25 -starttime 0ps -endtime 1000ps sim:/multiplier/Clk 
wave create -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 100ps sim:/multiplier/ClearA_LoadB 
wave modify -driver freeze -pattern clock -initialvalue St0 -period 50ps -dutycycle 50 -starttime 0ps -endtime 1000ps Edit:/multiplier/Clk 
wave modify -driver freeze -pattern constant -value St1 -starttime 0ps -endtime 1000ps Edit:/multiplier/ClearA_LoadB 
wave edit invert -start 64ps -end 1000ps Edit:/multiplier/ClearA_LoadB 
wave create -driver freeze -pattern constant -value 0000111 -range 7 0 -starttime 0ps -endtime 1000ps sim:/multiplier/S 
WaveExpandAll -1
wave edit change_value -start 79ps -end 1000ps -value 00000011 Edit:/multiplier/S 
wave create -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 1000ps sim:/multiplier/Run 
wave edit invert -start 103ps -end 134ps Edit:/multiplier/Run 
wave edit change_value -start 125ps -end 180ps -value 1 Edit:/multiplier/Run 
wave edit invert -start 0ps -end 19ps Edit:/multiplier/ClearA_LoadB 
wave modify -driver freeze -pattern clock -initialvalue St0 -period 5ps -dutycycle 50 -starttime 0ps -endtime 1000ps Edit:/multiplier/Clk 
wave create -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 1000ps sim:/multiplier/Reset 
wave edit invert -start 0ps -end 997ps Edit:/multiplier/ClearA_LoadB 
wave edit invert -start 0ps -end 1000ps Edit:/multiplier/Reset 
wave edit invert -start 0ps -end 15ps Edit:/multiplier/Reset 
wave edit invert -start 0ps -end 998ps Edit:/multiplier/Run 
wave edit invert -start 0ps -end 1000ps Edit:/multiplier/Run 
wave edit change_value -start 22ps -end 69ps -value 1 Edit:/multiplier/ClearA_LoadB 
wave edit invert -start 18ps -end 40ps Edit:/multiplier/ClearA_LoadB 
wave edit change_value -start 16ps -end 42ps -value 0 Edit:/multiplier/ClearA_LoadB 
wave edit change_value -start 43ps -end 221ps -value 1 Edit:/multiplier/Run 
wave edit change_value -start 0ps -end 491ps -value 1 Edit:/multiplier/Run 
wave edit change_value -start 531ps -end 998ps -value 1 Edit:/multiplier/Run 
wave edit change_value -start 0ps -end 541ps -value 0 Edit:/multiplier/Run 
wave modify -driver freeze -pattern constant -value St0 -starttime 0ps -endtime 1000ps Edit:/multiplier/Run 
wave modify -driver freeze -pattern constant -value St1 -starttime 0ps -endtime 1000ps Edit:/multiplier/Run 
wave edit invert -start 234ps -end 1000ps Edit:/multiplier/Run 
wave edit invert -start 262ps -end 1000ps Edit:/multiplier/Run 
wave edit invert -start 414ps -end 445ps Edit:/multiplier/Run 
wave edit change_value -start 977ps -end 1000ps -value 1 Edit:/multiplier/ClearA_LoadB 
WaveCollapseAll -1
wave clipboard restore
