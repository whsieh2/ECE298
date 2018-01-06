library verilog;
use verilog.vl_types.all;
entity Dreg is
    port(
        Clk             : in     vl_logic;
        Load            : in     vl_logic;
        Reset           : in     vl_logic;
        D               : in     vl_logic;
        Q               : out    vl_logic
    );
end Dreg;
