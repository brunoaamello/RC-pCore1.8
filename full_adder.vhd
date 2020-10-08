library ieee;
use ieee.std_logic_1164.all;

library c35_corelib;
use c35_corelib.ADD31;
use c35_corelib.ADD32;


entity full_adder is

	port(
		a: in std_logic;
		b: in std_logic;
		cin: in std_logic;
		s: out std_logic;
		cout: out std_logic
	);


end entity full_adder;


architecture basic of full_adder is
	signal s0, cout0, cout1: std_logic;
begin
	
	s0 <= a xor b;
	cout0 <= a and b;

	s <= s0 xor cin;
	cout1 <= s0 and cin; 
	
	cout <= cout0 or cout1;
	
end architecture basic;


architecture c35_1 of full_adder is

	component ADD31 is
		port(
			A: in std_logic;
			B: in std_logic;
			CI: in std_logic;
			S: out std_logic;
			CO: out std_logic
		);
	end component;

begin

COMP_DECL:
	ADD31 port map(A=>a, B=>b, CI=>cin, S=>s, CO=>cout);


end architecture c35_1;

architecture c35_2 of full_adder is

	component ADD32 is
		port(
			A: in std_logic;
			B: in std_logic;
			CI: in std_logic;
			S: out std_logic;
			CO: out std_logic
		);
	end component;

begin

COMP_DECL:
	ADD32 port map(A=>a, B=>b, CI=>cin, S=>s, CO=>cout);


end architecture c35_2;
