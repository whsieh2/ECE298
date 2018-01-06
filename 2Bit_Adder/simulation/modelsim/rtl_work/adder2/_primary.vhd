library verilog;
use verilog.vl_types.all;
entity adder2 is
    port(
        A               : in     vl_logic_vector(1 downto 0);
        B               : in     vl_logic_vector(1 downto 0);
        c_in            : in     vl_logic;
        S               : out    vl_logic_vector(1 downto 0);
        c_out           : out    vl_logic
    );
end adder2;
