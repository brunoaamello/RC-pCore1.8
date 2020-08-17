library ieee;
use ieee.std_logic_1164.all;
use work.ff_d_c;

entity reg_n is 
		generic(n: integer := 8);
		port(
			D: 		in std_logic_vector(n-1 downto 0);
			clk_in: 	in std_logic;
			clr: 		in std_logic;
			Q:			out std_logic_vector(n-1 downto 0)			
		);
end entity reg_n;

architecture simple of reg_n is
	component ff_d_c is
		port(
			D: 		in std_logic;
			clk_in: 	in std_logic;
			clr: 		in std_logic;
			Q:			out std_logic
		);
	end component;
begin
FF_GEN:
	for i in n-1 downto 0 generate
FFS:	ff_d_c port map(D=>D(i), clk_in=>clk_in, clr=>clr, Q=>Q(i));
	end generate FF_GEN;

end architecture simple;






