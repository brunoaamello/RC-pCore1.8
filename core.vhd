library ieee;
use ieee.std_logic_1164.all;
use work.base_components.all;
use work.primitives.all;

entity core is 
		generic(	
				n_data: integer := 8;
				n_prog: integer := 16;
				n_addr: integer := 16
				);
		port(	
				signal clk: in std_logic;
				signal rst: in std_logic;
				
				signal pmem_addr: out std_logic_vector(n_addr-1 downto 0);
				signal pmem_data_in: out std_logic_vector(n_data-1 downto 0);
				signal pmem_wr: out std_logic;
				signal pmem_rd: out std_logic;
				signal pmem_data_out: in std_logic_vector(n_prog-1 downto 0);
				
				signal dmem_addr: out std_logic_vector(n_addr-1 downto 0);
				signal dmem_data_in: out std_logic_vector(n_data-1 downto 0);
				signal dmem_wr: out std_logic;
				signal dmem_rd: out std_logic;
				signal dmem_data_out: in std_logic_vector(n_data-1 downto 0)				
		);
end entity core;

architecture simple of core is
	signal RET_PC, PC_IF, PC_IN, PC_OUT, PC_ADD, PC_ADD2: std_logic_vector(n_prog-1 downto 0);
begin
	
	
end architecture simple;
