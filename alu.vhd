library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.functions.or_reduce;
use work.alu_components.all;

entity alu is
	generic(n : integer := 8);
	port(	signal A: in std_logic_vector(n-1 downto 0);
			signal B: in std_logic_vector(n-1 downto 0);
			signal Cin: in std_logic;
			signal op: in std_logic_vector(3 downto 0);
			signal S: out std_logic_vector(n-1 downto 0);
			signal WC: out std_logic;
			signal Cout: out std_logic;
			signal lz: out std_logic;
			signal ez: out std_logic;
			signal gz: out std_logic
	);

end entity alu;

architecture simple of alu is
	constant SL_OP : std_logic_vector(3 downto 0) := "0001";
	constant SR_OP : std_logic_vector(3 downto 0) := "0010";
	constant ADD_OP : std_logic_vector(3 downto 0) := "0011";
	constant ADDC_OP : std_logic_vector(3 downto 0) := "0100";
	constant SUB_OP : std_logic_vector(3 downto 0) := "0101";
	constant NAND_OP : std_logic_vector(3 downto 0) := "0110";
	constant NOR_OP : std_logic_vector(3 downto 0) := "0111";
	constant XOR_OP : std_logic_vector(3 downto 0) := "1000";
	constant NOT_OP : std_logic_vector(3 downto 0) := "1001";
	
	
	signal sl_S, sr_S, addsub_S, nand_S, nor_S, xor_S, not_S, i_S: std_logic_vector(n-1 downto 0);
	signal sub: std_logic;
	signal icin : std_logic;
	signal iC: std_logic;
	signal addsub_op: boolean;
	
	
begin

---- Shift Left
	sl_S <= to_stdlogicvector(to_bitvector(A) sll to_integer(unsigned(B(2 downto 0))));

---- Shift Right
	sr_S <= to_stdlogicvector(to_bitvector(A) srl to_integer(unsigned(B(2 downto 0))));

---- Adder/Subtractor
ADD_SUB:
	adder_subtractor generic map(n=>n) port map(a=>A,b=>B,cin=>icin,sub=>sub,s=>addsub_S,cout=>iC);

	addsub_op <= std_match(op, ADD_OP) or std_match(op, ADDC_OP) or std_match(op, SUB_OP);
	
-- Sub logic
	sub <= 	'1' when std_match(op, SUB_OP) else
				'0';

-- Carry in logic
	icin <= '0' when std_match(op, ADD_OP) else
				cin;
	
-- Carry out logic
	WC <= '1' when addsub_op else
			'0';
	Cout <= 	iC when addsub_op else
				Cin;
				

---- Logic Operations

-- NAND
	nand_S <= A nand B;

-- NOR
	nor_S <= A nor B;

-- XOR
	xor_S <= A xor B;

-- NOT
	not_S <= not A;

-- Output logic

	i_S <=	sl_S when std_match(op, SL_OP) else
				sr_S when std_match(op, SR_OP) else
				addsub_S when addsub_op else
				nand_S when std_match(op, NAND_OP) else
				nor_S when std_match(op, NOR_OP) else
				xor_S when std_match(op, XOR_OP) else
				not_S;
				
	S <= i_s;

-- LZ, EZ, GZ flag check
	lz <= i_S(7);
	ez <= not or_reduce(i_S);
	gz <= or_reduce(i_S);
	
end architecture simple;