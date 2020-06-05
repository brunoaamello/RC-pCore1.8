library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.functions.or_reduce;
use work.primitives.ff_d_c;
use work.base_components.adder_n;

entity alu is
	generic(n : integer := 8);
	port(	signal clk: in std_logic;
			signal rst: in std_logic;
			signal A: in std_logic_vector(n-1 downto 0);
			signal B: in std_logic_vector(n-1 downto 0);
			signal op: in std_logic_vector(3 downto 0);
			signal S: out std_logic_vector(n-1 downto 0);
			signal c: out std_logic;
			signal lz: out std_logic;
			signal ez: out std_logic;
			signal gz: out std_logic
	);

end entity alu;

architecture simple of alu is
	signal i_S: std_logic_vector(n-1 downto 0);
	signal cin: std_logic;
	signal ic: std_logic;
	signal ilz, iez, igz : std_logic;
begin

ADDER:
	adder_n generic map(n=>n) port map(a=>A,b=>B,cin=>cin,s=>i_S,cout=>ic);

	--i_S <= to_stdlogicvector(to_bitvector(A) sll to_integer(unsigned(B(2 downto 0))));
	
	S <= i_s; 
	
CARRY_FF:
	ff_d_c port map(D=>ic, Q=>cin, clk_in=>clk, clr=>rst);
	
	c <= ic;
	
	-- LZ, EZ, GZ flag check
	ilz <= i_S(7);
	iez <= not igz;
	igz <= or_reduce(i_S);
	
	lz <= ilz;
	ez <= iez;
	gz <= igz;
	
end architecture simple;