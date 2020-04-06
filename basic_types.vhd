library ieee;
use ieee.std_logic_1164.all;

package basic_types is
	--type std_logic_vector_array is array(natural range <>) of std_logic_vector(natural range <>);
	--type std_logic_vector_matrix is array(natural range <>, natural range <>) of std_logic_vector(natural range <>);
	--type std_logic_vector_tensor3 is array(natural range <>, natural range <>, natural range <>) of std_logic_vector(natural range <>);
	--type std_logic_array is array(natural range <>) of std_logic;
	type std_logic_matrix is array(natural range <>, natural range <>) of std_logic;
	--type std_logic_tensor3 is array(natural range <>, natural range <>, natural range <>) of std_logic;
end package basic_types;