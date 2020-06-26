library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.std_match;

-- c -> clear
-- en -> enable

entity ff_d_cen is
	port(
		D: 		in std_logic;
		clk_in: 	in std_logic;
		clk_en:	in std_logic;
		clr: 		in std_logic;
		Q:			out std_logic
	);
end entity ff_d_cen;

architecture asynchronous of ff_d_cen is
	begin
	process(clk_in, clk_en, clr) is
		begin
		if(std_match(clr, '1')) then
			if(falling_edge(clk_in) and std_match(clk_en, '1')) then
				Q<=D;
			end if;
		else
			Q<=clr;
		end if;
	end process;
end architecture asynchronous;

