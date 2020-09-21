library ieee;
use ieee.std_logic_1164.all;

entity merger is
	port(
		gin: in std_logic;
		ginprev: in std_logic;
		pin: in std_logic;
		pinprev: in std_logic;
		gout: out std_logic;
		pout: out std_logic
	);
end entity merger;

architecture simple of merger is
begin
	gout <= (pin and ginprev) or gin;
	pout <= pin and pinprev;
end architecture simple;
