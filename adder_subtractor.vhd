library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.std_match;

use work.adder_n;

entity adder_subtractor is
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
end entity adder_subtractor;

architecture simple of adder_subtractor is
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

	signal i_a, i_b, i_s: std_logic_vector(n-1 downto 0);
	signal i_cin, i_cout: std_logic;
begin
	
	i_a <= a;
	i_b <= b when std_match(sub, '0') else
			 not b;
	
	i_cin <= cin when std_match(sub, '0') else
				'1';
	
	s <= i_s;
	cout <= i_cout;

ADDER:
	adder_n generic map(n=>n) port map(a=>i_a, b=>i_b, cin=>i_cin, s=>i_s, cout=>i_cout);
	
	
end architecture simple;


