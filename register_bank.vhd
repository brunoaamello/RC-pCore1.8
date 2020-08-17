library ieee;
use ieee.std_logic_1164.all;

use work.basic_types.std_logic_vector8_array;

use work.primitives.latch_n;
use work.primitives.decoder_n;
use work.primitives.mux_8s;

entity register_bank is
	port(	signal clk: in std_logic;
			signal ra: in std_logic_vector(3 downto 0);
			signal rb: in std_logic_vector(3 downto 0);
			signal wr: in std_logic;
			signal rd: in std_logic_vector(3 downto 0);
			signal wr_data: in std_logic_vector(7 downto 0);
			signal A: out std_logic_vector(7 downto 0);
			signal B: out std_logic_vector(7 downto 0);
			signal DPH: out std_logic_vector(7 downto 0)
	);
end entity register_bank;

architecture simple of register_bank is
	CONSTANT DPH_ADDRESS: integer := 15;
	
	signal wr_en: std_logic;
	
	signal reg_outputs: std_logic_vector8_array(15 downto 0);
	signal reg_enable: std_logic_vector(15 downto 0);
	signal reg_select: std_logic_Vector(15 downto 0);
begin

	wr_en <= wr and clk;

DECODER:
	decoder_n generic map(n=>4) port map (input=>rd, output=>reg_select);

REG_EN_GEN:
	for i in 15 downto 0 generate
		reg_enable(i) <= wr_en and reg_select(i);
	end generate REG_EN_GEN;

REG_GEN:
	for i in 15 downto 0 generate
REGS:	latch_n generic map(n=>8) port map(latch_enable=>reg_enable(i), data_in=>wr_data, data_out=>reg_outputs(i));
	end generate REG_GEN;
	
A_MUX:
	mux_8s generic map(s=>4) port map(sel=>ra, data_in=>reg_outputs, data_out=>A);
	
B_MUX:
	mux_8s generic map(s=>4) port map(sel=>rb, data_in=>reg_outputs, data_out=>B);

	DPH <= reg_outputs(DPH_ADDRESS);	
	
end architecture simple;
