library ieee;
use ieee.std_logic_1164.all;

use work.basic_types.all;

use work.latch_b;
use work.latch_n;
use work.ff_d_c;
use work.reg;
use work.mux_8s;
use work.mux_16s;
use work.decoder_n;

package primitives is

	component latch_b is
		port(
			latch_enable:	in std_logic;
			data_in: 		in std_logic;
			data_out: 		out std_logic
		);
	end component;
	
	component latch_n is
		generic( n: integer := 8);
		port(
			latch_enable: 	in std_logic;
			data_in: 		in std_logic_vector(n-1 downto 0);
			data_out: 		out std_logic_vector(n-1 downto 0)
		);
	end component;
	
	component ff_d_c is
		port(
			D: 		in std_logic;
			clk_in: 	in std_logic;
			clr: 		in std_logic;
			Q:			out std_logic
		);
	end component;
	
	component reg is 
		generic(n: integer := 8);
		port(
			D: 		in std_logic_vector(n-1 downto 0);
			clk_in: 	in std_logic;
			clr: 		in std_logic;
			Q:			out std_logic_vector(n-1 downto 0)			
		);
	end component;
	
	component mux_8s is
		generic( s:	integer := 1);
		port(
			sel: 				in std_logic_vector(s-1 downto 0);
			data_in: 		in std_logic_vector8_array((2**s)-1 downto 0);
			data_out: 		out std_logic_vector(7 downto 0)
		);
	end component;
	
	component mux_16s is
		generic( s:	integer := 1);
		port(
			sel: 				in std_logic_vector(s-1 downto 0);
			data_in: 		in std_logic_vector16_array((2**s)-1 downto 0);
			data_out: 		out std_logic_vector(15 downto 0)
		);
	end component;
	
	component decoder_n is
		generic( 
			n: integer := 4
		);
		port(	
			input: 	in std_logic_vector(n-1 downto 0);
			output:	out std_logic_vector((2**n)-1 downto 0)
		);
	end component;	

end primitives;