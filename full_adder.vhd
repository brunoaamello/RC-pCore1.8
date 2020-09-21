library ieee;
use ieee.std_logic_1164.all;

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

