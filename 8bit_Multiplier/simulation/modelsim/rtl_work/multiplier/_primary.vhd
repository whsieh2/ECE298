library verilog;
use verilog.vl_types.all;
entity multiplier is
    port(
        S               : in     vl_logic_vector(7 downto 0);
        Clk             : in     vl_logic;
        Reset           : in     vl_logic;
        Run             : in     vl_logic;
        ClearA_LoadB    : in     vl_logic;
        AhexU           : out    vl_logic_vector(6 downto 0);
        AhexL           : out    vl_logic_vector(6 downto 0);
        BhexU           : out    vl_logic_vector(6 downto 0);
        BhexL           : out    vl_logic_vector(6 downto 0);
        Aval            : out    vl_logic_vector(7 downto 0);
        Bval            : out    vl_logic_vector(7 downto 0);
        X               : out    vl_logic
    );
end multiplier;
