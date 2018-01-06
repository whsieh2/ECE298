library verilog;
use verilog.vl_types.all;
entity control is
    port(
        ClearA_LoadB    : in     vl_logic;
        Run             : in     vl_logic;
        Reset           : in     vl_logic;
        Clk             : in     vl_logic;
        M               : in     vl_logic;
        counter_msb     : in     vl_logic;
        shift           : out    vl_logic;
        add             : out    vl_logic;
        sub             : out    vl_logic;
        Clr_Ld          : out    vl_logic;
        counter_r       : out    vl_logic
    );
end control;
