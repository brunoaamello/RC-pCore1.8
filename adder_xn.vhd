library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.adder_n;

entity adder_xn is
	generic(
		n: integer := 16;
		x: integer := 2
	);
	port(
		a: in std_logic_vector(n-1 downto 0);
		s: out std_logic_vector(n-1 downto 0);
		cout: out std_logic
	);
end entity adder_xn;
	

architecture simple of adder_xn is
	
	component adder_n is
		generic(
			n: integer := 8
		);
		port(
			a: in std_logic_vector(n-1 downto 0);
			b: in std_logic_vector(n-1 downto 0);
			cin: in std_logic;
			s: out std_logic_vector(n-1 downto 0);
			cout: out std_logic
		);
	end component;
	
	
	signal i_b: std_logic_vector(n-1 downto 0) := std_logic_vector(to_unsigned(x,n));

begin

ADDER:
	adder_n generic map(n=>n) port map(a=>a, b=>i_b, cin=>'0', s=>s, cout=>cout);
	
	
end architecture simple;
