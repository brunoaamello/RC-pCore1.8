library ieee;
use ieee.std_logic_1164.all;

library c35_corelib;
use c35_corelib.ADD21;
use c35_corelib.ADD22;


entity half_adder is

	port(
		a: in std_logic;
		b: in std_logic;
		s: out std_logic;
		cout: out std_logic
	);


end entity half_adder;


architecture basic of half_adder is

begin
	
	s <= a xor b;
	cout <= a and b;

end architecture basic;

architecture c35_1 of half_adder is

	component ADD21 is
		port(
			A: in std_logic;
			B: in std_logic;
			S: out std_logic;
			CO: out std_logic
		);
	end component;

begin

COMP_DECL:
	ADD21 port map(A=>a, B=>b, S=>s, CO=>cout);


end architecture c35_1;

architecture c35_2 of half_adder is

	component ADD22 is
		port(
			A: in std_logic;
			B: in std_logic;
			S: out std_logic;
			CO: out std_logic
		);
	end component;

begin

COMP_DECL:
	ADD22 port map(A=>a, B=>b, S=>s, CO=>cout);


end architecture c35_2;

