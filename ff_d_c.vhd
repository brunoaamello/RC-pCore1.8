library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.std_match;

-- c -> clear

entity ff_d_c is
	port(
		D: 		in std_logic;
		clk_in: 	in std_logic;
		clr: 		in std_logic;
		Q:			out std_logic
	);
end entity ff_d_c;


architecture asynchronous_new of ff_d_c is
	signal iQ : std_logic;
	begin
	process(clk_in, clr) is
		begin
		iQ <= D;
		if(std_match(clr, '1')) then
			if(falling_edge(clk_in)) then
				Q<=iQ;
			end if;
		else
			Q<='0';
		end if;
	end process;
end architecture asynchronous_new;

architecture asynchronous of ff_d_c is
	begin
	process(clk_in, clr) is
		begin
		if(std_match(clr, '1')) then
			if(falling_edge(clk_in)) then
				Q<=D;
			end if;
		else
			Q<=clr;
		end if;
	end process;
end architecture asynchronous;