library ieee;
use ieee.std_logic_1164.all;

use work.latch_b;

-- n -> n bit generic

entity latch_n is
generic( n: integer := 8);
port(
		latch_enable: 	in std_logic;
		data_in: 		in std_logic_vector(n-1 downto 0);
		data_out: 		out std_logic_vector(n-1 downto 0)
	);
end entity latch_n;

architecture latch_b_arch of latch_n is
	begin
BLOCK_ASSEMBLY:
	for i in 0 to n-1 generate
	begin
	BASE_LATCHES:
		latch_b port map(latch_enable=>(latch_enable), data_in=>(data_in(i)), data_out=>(data_out(i)));
	end generate BLOCK_ASSEMBLY;
	
end architecture latch_b_arch;