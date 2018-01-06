library verilog;
use verilog.vl_types.all;
entity add_sub is
    port(
        A               : in     vl_logic_vector(7 downto 0);
        S               : in     vl_logic_vector(7 downto 0);
        \Out\           : out    vl_logic_vector(8 downto 0);
        fn              : in     vl_logic;
        exec            : in     vl_logic
    );
end add_sub;
