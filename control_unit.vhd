library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.basic_types.std_logic_vector18_array;

entity control_unit is
	port(	signal opcode: 	in std_logic_vector(4 downto 0);
			signal C: 			in std_logic;
			signal GZ: 			in std_logic;
			signal EZ: 			in std_logic;
			signal LZ: 			in std_logic;
			signal RET: 		out std_logic;
			signal BRANCH: 	out std_logic;
			signal MSB_SEL: 	out std_logic;
			signal RD_OP:		out std_logic;
			signal RT:			out std_logic;
			signal STD_IMM:	out std_logic;
			signal IMM:			out std_logic;
			signal WRimm:		out std_logic;
			signal WR1:			out std_logic;
			signal WR0:			out std_logic;
			signal LW:			out std_logic;
			signal SW:			out std_logic;
			signal LWC:			out std_logic;
			signal SWC:			out std_logic;
			signal ALUop:		out std_logic_vector(3 downto 0);
			signal JAL:			out std_logic
	);
end entity control_unit;

architecture simple of control_unit is
	signal control_signals: std_logic_vector(17 downto 0);
	
	signal lut: std_logic_vector18_array(0 to 31) := ( 	"000000000000000000", 	--SMSB
																			"000001001000000010",	--SL
																			"000001001000000100",	--SR
																			"000100001000000110",	--ADD
																			"011011001000000110",	--ADDi
																			"000100001000001000",	--ADDC
																			"011011001000001000",	--ADDCi
																			"000100001000001010",	--SUB
																			"011011001000001010",	--SUBi
																			"000100001000001100",	--NAND
																			"011011001000001100",	--NANDi
																			"000100001000001110",	--NOR
																			"011011001000001110",	--NORi
																			"000100001000010000",	--XOR
																			"011011001000010000",	--XORi
																			"000000001000010010",	--NOT
																			"000000000010000000",	--SW
																			"010011000010000000",	--SWi
																			"000000000000100000",	--SWC
																			"000000010100000000",	--LW
																			"010011010100000000",	--LWi
																			"000000010001000000",	--LWC
																			"000000000000000000",	--J
																			"000000011000000001",	--JAL
																			"100000000000000000",	--RET
																			"000000000000000000",	--JC
																			"000000000000000000",	--JGZ
																			"000000000000000000",	--JEZ
																			"000000000000000000",	--JLZ
																			"000011101000000000",	--MOVi
																			"000000000000000000",	--UNDEFINED
																			"000000000000000000" );	--UNDEFINED
	
begin
	-- Read control signals
	
	control_signals <= lut(to_integer(unsigned(opcode)));
	
	-- Route 

	RET <= control_signals(17);
	MSB_SEL <= control_signals(16);
	RD_OP <= control_signals(15);
	RT <= control_signals(14);
	STD_IMM <= control_signals(13);
	IMM <= control_signals(12);
	WRimm <= control_signals(11);
	WR1 <= control_signals(10);
	WR0 <= control_signals(9);
	LW <= control_signals(8);
	SW <= control_signals(7);
	LWC <= control_signals(6);
	SWC <= control_signals(5);
	ALUop <= control_signals(4 downto 1);
	JAL <= control_signals(0);
	
	-- Branch logic
	
	BRANCH <= 	'1' 	when std_match(opcode, "01110") or std_match(opcode, "01111") else 	-- J & JAL
					C		when std_match(opcode, "10001") else											-- JC
					GZ		when std_match(opcode, "10010") else											-- JGZ
					EZ		when std_match(opcode, "10011") else											-- JEZ
					LZ		when std_match(opcode, "10100") else											-- JLZ
					'0';																								-- OTHERS
	
end architecture;
