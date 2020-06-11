library ieee;
use ieee.std_logic_1164.all;

use work.adder_subtractor;

package alu_components is

	component adder_subtractor is
		generic(
			n: integer := 8
		);
		port(
			a: in std_logic_vector(n-1 downto 0);
			b: in std_logic_vector(n-1 downto 0);
			cin: in std_logic;
			sub: in std_logic;
			s: out std_logic_vector(n-1 downto 0);
			cout: out std_logic
		);
	end component;

end alu_components;