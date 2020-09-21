library ieee;
use ieee.std_logic_1164.all;

use work.merger;
use work.half_adder;
use work.full_adder;

package adder_utils is

	component half_adder is
		port(
			a: in std_logic;
			b: in std_logic;
			s: out std_logic;
			cout: out std_logic
		);
	end component;
	
	component full_adder is
		port(
			a: in std_logic;
			b: in std_logic;
			cin: in std_logic;
			s: out std_logic;
			cout: out std_logic
		);
	end component;
	
	component merger is
		port(
			gin: in std_logic;
			ginprev: in std_logic;
			pin: in std_logic;
			pinprev: in std_logic;
			gout: out std_logic;
			pout: out std_logic
		);
	end component;
	

end adder_utils;