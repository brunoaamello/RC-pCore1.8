library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.basic_types.std_logic_vector8_array;

-- s -> s bits selector generic

entity mux_8s is
generic( 
		s:	integer := 1
	);
port(
		sel: 				in std_logic_vector(s-1 downto 0);
		data_in: 		in std_logic_vector8_array((2**s)-1 downto 0);
		data_out: 		out std_logic_vector(7 downto 0)
	);
end entity mux_8s;

architecture simple of mux_8s is
begin
	data_out <= data_in(to_integer(unsigned(sel)));
end architecture simple;