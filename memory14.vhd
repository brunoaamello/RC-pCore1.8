library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.basic_types.all;

entity memory14 is
		generic(
				mem_file: string :="blank14.hex"
		);
		port(	signal clk: in std_logic;
				signal address: in std_logic_vector(13 downto 0);
				signal data_in: in std_logic_vector(7 downto 0);
				signal wr: in std_logic;
				signal rd: in std_logic;
				signal data_out: out std_logic_vector(7 downto 0)			
		);
end entity memory14;

architecture simple of memory14 is
	signal ram: std_logic_vector8_array(0 to (2**14)-1);
	
	attribute ram_init_file : string;
	attribute ram_init_file of ram : signal is mem_file;
	
	signal address_int: integer range 0 to (2**14)-1;
begin
	address_int <= to_integer(unsigned(address));
	process(clk) is
	begin
		if(rising_edge(clk)) then
			if(std_match(wr, '1')) then
				ram(address_int) <= data_in;
			end if;
			if(std_match(rd, '1')) then
				data_out <= ram(address_int);
			end if;
		end if;
	end process;


end architecture simple;