library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- n -> n bit generic

entity decoder_n is
generic( 
		n: integer := 4
	);
port(	
		input: 	in std_logic_vector(n-1 downto 0);
		output:	out std_logic_vector((2**n)-1 downto 0)
	);
end entity decoder_n;

architecture simple of decoder_n is
begin
	process(input) is
	begin
		output <= (others=>'0');
		output(to_integer(unsigned(input))) <= '1';
	end process;
end architecture simple;