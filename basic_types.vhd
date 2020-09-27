library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package basic_types is
--	type std_logic_vector_array is array(natural range <>) of std_logic_vector(natural range <>);
	type std_logic_vector20_array is array(natural range <>) of std_logic_vector(19 downto 0);
	type std_logic_vector18_array is array(natural range <>) of std_logic_vector(17 downto 0);
	type std_logic_vector16_array is array(natural range <>) of std_logic_vector(15 downto 0);
	type std_logic_vector8_array is array(natural range <>) of std_logic_vector(7 downto 0);
--	type std_logic_vector_matrix is array(natural range <>, natural range <>) of std_logic_vector(natural range <>);
--	type std_logic_vector_tensor3 is array(natural range <>, natural range <>, natural range <>) of std_logic_vector(natural range <>);
	type std_logic_array is array(natural range <>) of std_logic;
	type std_logic_matrix is array(natural range <>, natural range <>) of std_logic;
--	type std_logic_tensor3 is array(natural range <>, natural range <>, natural range <>) of std_logic;
end basic_types;
