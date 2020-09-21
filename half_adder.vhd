library ieee;
use ieee.std_logic_1164.all;

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

