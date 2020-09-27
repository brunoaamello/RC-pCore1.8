library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.basic_types.std_logic_vector20_array;

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
			signal SMSB:		out std_logic;
			signal ALUop:		out std_logic_vector(3 downto 0);
			signal JAL:			out std_logic;
			signal WS:			out std_logic
	);
end entity control_unit;

architecture simple of control_unit is
	signal control_signals: std_logic_vector(19 downto 0);
	
	signal lut: std_logic_vector20_array(0 to 31) := ( 	"00000000000000100000", 	--SMSB
																			"10000010010000000010",	--SL
																			"10000010010000000100",	--SR
																			"10001000010000000110",	--ADD
																			"10110110010000000110",	--ADDi
																			"10001000010000001000",	--ADDC
																			"10110110010000001000",	--ADDCi
																			"10001000010000001010",	--SUB
																			"10110110010000001010",	--SUBi
																			"10001000010000001100",	--NAND
																			"10110110010000001100",	--NANDi
																			"10001000010000001110",	--NOR
																			"10110110010000001110",	--NORi
																			"10001000010000010000",	--XOR
																			"10110110010000010000",	--XORi
																			"10000000010000010010",	--NOT
																			"00010000000100000000",	--SW
																			"00110110000100000000",	--SWi
																			"00010000000001000000",	--SWC
																			"00000000101000000000",	--LW
																			"00100110101000000000",	--LWi
																			"00000000100010000000",	--LWC
																			"00000000000000000000",	--J
																			"00000000110000000001",	--JAL
																			"01010000000000000000",	--RET
																			"00000000000000000000",	--JC
																			"00000000000000000000",	--JGZ
																			"00000000000000000000",	--JEZ
																			"00000000000000000000",	--JLZ
																			"00100111010000000000",	--MOVi
																			"00000000000000000000",	--UNDEFINED
																			"00000000000000000000" );	--UNDEFINED
	
begin
	-- Read control signals
	
	control_signals <= lut(to_integer(unsigned(opcode)));
	
	-- Route 
	WS <= control_signals(19);
	RET <= control_signals(18);
	MSB_SEL <= control_signals(17);
	RD_OP <= control_signals(16);
	RT <= control_signals(15);
	STD_IMM <= control_signals(14);
	IMM <= control_signals(13);
	WRimm <= control_signals(12);
	WR1 <= control_signals(11);
	WR0 <= control_signals(10);
	LW <= control_signals(9);
	SW <= control_signals(8);
	LWC <= control_signals(7);
	SWC <= control_signals(6);
	SMSB <= control_signals(5);
	ALUop <= control_signals(4 downto 1);
	JAL <= control_signals(0);
	
	-- Branch logic
	
	BRANCH <= 	'1' 	when std_match(opcode, "10110") or std_match(opcode, "10111") else 	-- J & JAL
					C		when std_match(opcode, "11001") else											-- JC
					GZ		when std_match(opcode, "11010") else											-- JGZ
					EZ		when std_match(opcode, "11011") else											-- JEZ
					LZ		when std_match(opcode, "11100") else											-- JLZ
					'0';																								-- OTHERS
	
end architecture;
