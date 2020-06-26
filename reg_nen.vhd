library ieee;
use ieee.std_logic_1164.all;
use work.ff_d_cen;

entity reg_nen is 
		generic(n: integer := 8);
		port(
			D: 		in std_logic_vector(n-1 downto 0);
			clk_in: 	in std_logic;
			clk_en:	in std_logic;
			clr: 		in std_logic;
			Q:			out std_logic_vector(n-1 downto 0)			
		);
end entity reg_nen;

architecture simple of reg_nen is
begin
FF_GEN:
	for i in n-1 downto 0 generate
FFS:	ff_d_cen port map(D=>D(i), clk_in=>clk_in, clk_en=>clk_en, clr=>clr, Q=>Q(i));
	end generate FF_GEN;

end architecture simple;






