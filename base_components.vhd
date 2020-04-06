library ieee;
use ieee.std_logic_1164.all;

use work.adder_n;

package base_components is

	component adder_n is
		generic(
			n: integer
		);
		port(
			a: in std_logic_vector(n-1 downto 0);
			b: in std_logic_vector(n-1 downto 0);
			cin: in std_logic;
			s: out std_logic_vector(n-1 downto 0);
			cout: out std_logic
		);
	end component;
	

end base_components;