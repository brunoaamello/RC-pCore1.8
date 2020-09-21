library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.basic_types.all;

use work.memory15;

entity program_memory is
		generic(
				msb_file: string :="blank15.hex";
				lsb_file: string :="blank15.hex"
		);
		port(	signal clk: in std_logic;
				signal address: in std_logic_vector(15 downto 0);
				signal data_in: in std_logic_vector(7 downto 0);
				signal wr: in std_logic;
				signal rd: in std_logic;
				signal data_out: out std_logic_vector(15 downto 0)			
		);
end entity program_memory;

architecture simple of program_memory is

	component memory15 is
		generic(
				mem_file: string :="blank15.mif"
		);
		port(	signal clk: in std_logic;
				signal address: in std_logic_vector(14 downto 0);
				signal data_in: in std_logic_vector(7 downto 0);
				signal wr: in std_logic;
				signal rd: in std_logic;
				signal data_out: out std_logic_vector(7 downto 0)			
		);
	end component;

	signal address_LSB: std_logic_vector(15 downto 0);
	signal address_MSB: std_logic_vector(15 downto 0);
	
	signal wr_LSB, wr_MSB, rd_LSB, rd_MSB: std_logic;
	
begin

	wr_LSB <= wr and (not address(0));
	wr_MSB <= wr and address(0);
	rd_LSB <= rd;
	rd_MSB <= rd;
	
LSB_MEM:
	memory15 generic map(mem_file=>lsb_file) 
				port map(clk=>clk, address=>address(15 downto 1), data_in=>data_in, wr=>wr_LSB, rd=>rd_LSB, data_out=>data_out(7 downto 0));

MSB_MEM:
	memory15	generic map(mem_file=>msb_file)
				port map(clk=>clk, address=>address(15 downto 1), data_in=>data_in, wr=>wr_MSB, rd=>rd_MSB, data_out=>data_out(15 downto 8));

end architecture simple;