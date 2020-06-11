library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- n -> n bits generic

entity mux_n1 is
	
	generic( 
		n:	integer := 8
	);
	port(
		sel: 				in std_logic;
		data_in0: 			in std_logic_vector(n-1 downto 0);
		data_in1: 			in std_logic_vector(n-1 downto 0);
		data_out: 		out std_logic_vector(n-1 downto 0)
	);
end entity mux_n1;

architecture simple of mux_n1 is
begin
	data_out <= data_in0 when std_match(sel, '0') else
					data_in1;
end architecture simple;