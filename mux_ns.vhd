library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.basic_types.std_logic_vector_array;

-- n -> n bit generic
-- s -> s bits selector generic

entity mux_ns is
generic( 
		n: integer := 1;
		s:	integer := 1
	);
port(
		sel: 				in std_logic_vector(s-1 downto 0);
		data_in: 		in std_logic_vector_array((2**s)-1 downto 0)(n-1 downto 0);
		data_out: 		out std_logic_vector(n-1 downto 0)
	);
end entity mux_ns;

architecture simple of mux_ns is
begin
	data_out <= data_in(to_integer(unsigned(sel)));
end architecture simple;