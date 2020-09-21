library ieee;
use ieee.std_logic_1164.all;

use work.adder_n;
use work.adder_xn;
use work.adder_subtractor;

use work.register_bank;
use work.control_unit;
use work.alu;
use work.sign_extend_nm;

package base_components is

	component adder_n is
		generic(
			n: integer := 8
		);
		port(
			a: in std_logic_vector(n-1 downto 0);
			b: in std_logic_vector(n-1 downto 0);
			cin: in std_logic;
			s: out std_logic_vector(n-1 downto 0);
			cout: out std_logic
		);
	end component;
	
	component adder_xn is
		generic(
			n: integer := 16;
			x: integer := 2
		);
		port(
			a: in std_logic_vector(n-1 downto 0);
			s: out std_logic_vector(n-1 downto 0);
			cout: out std_logic
		);
	end component;
	
	component adder_subtractor is
		generic(
			n: integer := 8
		);
		port(
			a: in std_logic_vector(n-1 downto 0);
			b: in std_logic_vector(n-1 downto 0);
			cin: in std_logic;
			sub: in std_logic;
			s: out std_logic_vector(n-1 downto 0);
			cout: out std_logic
		);
	end component;
	
	component register_bank is
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
	end component;
	
	component control_unit is
		port(	signal opcode: 	in std_logic_vector(4 downto 0);
				signal C: 			in std_logic;
				signal GZ: 			in std_logic;
				signal EZ: 			in std_logic;
				signal LZ: 			in std_logic;
				signal RET: 		out std_logic;
				signal BRANCH: 	out std_logic;
				signal MSB_SEL: 	out std_logic;
				signal RD_OP:		out std_logic;
				signal RT:			out std_logic;
				signal STD_IMM:	out std_logic;
				signal IMM:			out std_logic;
				signal WRimm:		out std_logic;
				signal WR1:			out std_logic;
				signal WR0:			out std_logic;
				signal LW:			out std_logic;
				signal SW:			out std_logic;
				signal LWC:			out std_logic;
				signal SWC:			out std_logic;
				signal SMSB:		out std_logic;
				signal ALUop:		out std_logic_vector(3 downto 0);
				signal JAL:			out std_logic
			);
	end component;
	
	component alu is
		generic(n : integer := 8);
		port(	signal A: in std_logic_vector(n-1 downto 0);
				signal B: in std_logic_vector(n-1 downto 0);
				signal Cin: in std_logic;
				signal op: in std_logic_vector(3 downto 0);
				signal S: out std_logic_vector(n-1 downto 0);
				signal WS: out std_logic;
				signal Cout: out std_logic;
				signal lz: out std_logic;
				signal ez: out std_logic;
				signal gz: out std_logic
			);
	end component;
	
	component sign_extend_nm is
		generic(
			n: integer := 12;
			m: integer := 16
		);
		port(
			signal A: in std_logic_vector(n-1 downto 0);
			signal B: out std_logic_vector(m-1 downto 0)
		);
	end component;

end base_components;