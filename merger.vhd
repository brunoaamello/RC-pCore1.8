library ieee;
use ieee.std_logic_1164.all;

library c35_corelib;
use c35_corelib.NAND22;

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

architecture manual of merger is

	component NAND22 is
		port(
			A: in std_logic;
			B: in std_logic;
			Q: out std_logic
		);
	end component;
	
	component INV3 is
		port(
			A: in std_logic;
			Q: out std_logic
		);
	end component;
	
	component AOI211 is
		port(
			A: in std_logic;
			B: in std_logic;
			C: in std_logic;
			Q: out std_logic
		);
	end component;
	
	signal ngout, npout: std_logic;
begin
	
COMP_ANDNOR:
	AOI211 port map(A=>pin, B=>ginprev, C=>gin, Q=>ngout);

COMP_GOUT_NOT:
	INV3 port map(A=>ngout, Q=>gout);
	
COMP_NAND:
	NAND22 port map(A=>pin, B=>pinprev, Q=>npout);
	
COMP_POUT_NOT:
	INV3 port map(A=>npout, Q=>pout);
	
	
end architecture manual;
