library ieee;
use ieee.std_logic_1164.all;

use work.core;
use work.memory16;
use work.memory15;
use work.memory14;
use work.memory12;
use work.program_memory;

package compute_components is

	component core is 
		port(	
			signal clk: in std_logic;
			signal rst: in std_logic;
				
			signal pmem_addr: out std_logic_vector(15 downto 0);
			signal pmem_data_in: out std_logic_vector(7 downto 0);
			signal pmem_wr: out std_logic;
			signal pmem_rd: out std_logic;
			signal pmem_data_out: in std_logic_vector(15 downto 0);
				
			signal dmem_addr: out std_logic_vector(15 downto 0);
			signal dmem_data_in: out std_logic_vector(7 downto 0);
			signal dmem_wr: out std_logic;
			signal dmem_rd: out std_logic;
			signal dmem_data_out: in std_logic_vector(7 downto 0)				
		);
	end component;
	
	component memory16 is
		port(	signal clk: in std_logic;
				signal address: in std_logic_vector(15 downto 0);
				signal data_in: in std_logic_vector(7 downto 0);
				signal wr: in std_logic;
				signal rd: in std_logic;
				signal data_out: out std_logic_vector(7 downto 0)			
		);
	end component;
	
	
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
	
	
	component memory14 is
		generic(
				mem_file: string :="blank14.mif"
		);
		port(	signal clk: in std_logic;
				signal address: in std_logic_vector(13 downto 0);
				signal data_in: in std_logic_vector(7 downto 0);
				signal wr: in std_logic;
				signal rd: in std_logic;
				signal data_out: out std_logic_vector(7 downto 0)			
		);
	end component;
	
	
	component program_memory is
		generic(
				msb_file: string :="blank15.mif";
				lsb_file: string :="blank15.mif"
		);
		port(	signal clk: in std_logic;
				signal address: in std_logic_vector(15 downto 0);
				signal data_in: in std_logic_vector(7 downto 0);
				signal wr: in std_logic;
				signal rd: in std_logic;
				signal data_out: out std_logic_vector(15 downto 0)			
		);
	end component;

end compute_components;