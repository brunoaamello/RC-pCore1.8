library ieee;
use ieee.std_logic_1164.all;
use work.compute_components.all;

entity compute_module is 
		port(	
				signal clk: in std_logic;
				signal rst: in std_logic;
				
				signal pmem_addr: out std_logic_vector(15 downto 0);
				signal pmem_data_in: out std_logic_vector(7 downto 0);
				signal pmem_wr: out std_logic;
				signal pmem_rd: out std_logic;
				signal pmem_data_out: out std_logic_vector(15 downto 0);
				
				signal dmem_addr: out std_logic_vector(15 downto 0);
				signal dmem_data_in: out std_logic_vector(7 downto 0);
				signal dmem_wr: out std_logic;
				signal dmem_rd: out std_logic;
				signal dmem_data_out: out std_logic_vector(7 downto 0)				
		);
end entity compute_module;

architecture simple of compute_module is
	signal i_pmem_addr: std_logic_vector(15 downto 0);
	signal i_pmem_data_in: std_logic_vector(7 downto 0);
	signal i_pmem_wr: std_logic;
	signal i_pmem_rd: std_logic;
	signal i_pmem_data_out: std_logic_vector(15 downto 0);
	
	signal i_dmem_addr: std_logic_vector(15 downto 0);
	signal i_dmem_data_in: std_logic_vector(7 downto 0);
	signal i_dmem_wr: std_logic;
	signal i_dmem_rd: std_logic;
	signal i_dmem_data_out: std_logic_vector(7 downto 0);

begin

	pmem_addr <= i_pmem_addr;
	pmem_data_in <= i_pmem_data_in;
	pmem_wr <= i_pmem_wr;
	pmem_rd <= i_pmem_rd;
	pmem_data_out <= i_pmem_data_out;
	
	dmem_addr <= i_dmem_addr;
	dmem_data_in <= i_dmem_data_in;
	dmem_wr <= i_dmem_wr;
	dmem_rd <= i_dmem_rd;
	dmem_data_out <= i_dmem_data_out;
	
CORE_DECL:
	core port map(clk=>clk, rst=>rst, pmem_addr=>i_pmem_addr, pmem_data_in=>i_pmem_data_in,
					  pmem_wr=>i_pmem_wr, pmem_rd=>i_pmem_rd, pmem_data_out=>i_pmem_data_out,
					  dmem_addr=>i_dmem_addr, dmem_data_in=>i_dmem_data_in, dmem_wr=>i_dmem_wr,
					  dmem_rd=>i_dmem_rd, dmem_data_out=>i_dmem_data_out);
					  
PROGRAM_MEMORY_DECL:
	program_memory port map(clk=>clk, address=>i_pmem_addr, data_in=>i_pmem_data_in,
									wr=>i_pmem_wr, rd=>i_pmem_rd, data_out=>i_pmem_data_out);

DATA_MEMORY_DECL:
	memory16 port map(clk=>clk, address=>i_dmem_addr, data_in=>i_dmem_data_in,
							wr=>i_dmem_wr, rd=>i_dmem_rd, data_out=>i_dmem_data_out);

	
	

end architecture simple;