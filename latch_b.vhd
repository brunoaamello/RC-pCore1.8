library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.std_match;

-- b -> bit

entity latch_b is
port(
		latch_enable:	in std_logic;
		data_in: 		in std_logic;
		data_out: 		out std_logic
	);
end entity latch_b;

architecture synchronous of latch_b is
	signal iQ : std_logic;
	begin
	
	iQ			<= data_in when std_match(latch_enable, '1') else
					iQ;
	
	data_out <= iQ;
	
end architecture synchronous;