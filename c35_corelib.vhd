library ieee;
use ieee.std_logic_1164.all;
	---- Dummy library for compiling without corelib
	
	-- ADD21
library ieee;
use ieee.std_logic_1164.all;

	entity ADD21 is
		port(
			A: in std_logic;
			B: in std_logic;
			S: out std_logic;
			CO: out std_logic
		);
	end entity ADD21;
	
	architecture basic of ADD21 is
	begin
		S <= A xor B;
		CO <= A and B;
	end architecture basic;
	
	-- ADD22
library ieee;
use ieee.std_logic_1164.all;
	
	entity ADD22 is
		port(
			A: in std_logic;
			B: in std_logic;
			S: out std_logic;
			CO: out std_logic
		);
	end entity ADD22;
	
	architecture basic of ADD22 is
	begin
		S <= A xor B;
		CO <= A and B;
	end architecture basic;
	
	-- ADD31
library ieee;
use ieee.std_logic_1164.all;
	
	entity ADD31 is
		port(
			A: in std_logic;
			B: in std_logic;
			CI: in std_logic;
			S: out std_logic;
			CO: out std_logic
		);
	end entity ADD31;
	
	architecture basic of ADD31 is
		signal s0, cout0, cout1: std_logic;
	begin
		s0 <= A xor B;
		cout0 <= A and a;
		S <= s0 xor CI;
		cout1 <= s0 and CI; 
		CO <= cout0 or cout1;
	end architecture basic;
	
	-- ADD32
library ieee;
use ieee.std_logic_1164.all;
	
	entity ADD32 is
		port(
			A: in std_logic;
			B: in std_logic;
			CI: in std_logic;
			S: out std_logic;
			CO: out std_logic
		);
	end entity ADD32;
	
	architecture basic of ADD32 is
		signal s0, cout0, cout1: std_logic;
	begin
		s0 <= A xor B;
		cout0 <= A and a;
		S <= s0 xor CI;
		cout1 <= s0 and CI; 
		CO <= cout0 or cout1;
	end architecture basic;
	
		-- AOI210
library ieee;
use ieee.std_logic_1164.all;
	
	entity AOI210 is
		port(
			A: in std_logic;
			B: in std_logic;
			C: in std_logic;
			Q: out std_logic
		);
	end entity AOI210;
	
	architecture basic of AOI210 is
	begin
		Q <= (A and B) nor C;
	end architecture basic;
		
		-- AOI211
library ieee;
use ieee.std_logic_1164.all;
	
	entity AOI211 is
		port(
			A: in std_logic;
			B: in std_logic;
			C: in std_logic;
			Q: out std_logic
		);
	end entity AOI211;
	
	architecture basic of AOI211 is
	begin
		Q <= (A and B) nor C;
	end architecture basic;
		
		-- AOI212
library ieee;
use ieee.std_logic_1164.all;
	
	entity AOI212 is
		port(
			A: in std_logic;
			B: in std_logic;
			C: in std_logic;
			Q: out std_logic
		);
	end entity AOI212;
	
	architecture basic of AOI212 is
	begin
		Q <= (A and B) nor C;
	end architecture basic;
	
		-- INV0
library ieee;
use ieee.std_logic_1164.all;
	
	entity INV0 is
		port(
			A: in std_logic;
			Q: out std_logic
		);
	end entity INV0;
	
	architecture basic of INV0 is
	begin
		Q <= not A;
	end architecture basic;
		
		-- INV1
library ieee;
use ieee.std_logic_1164.all;
	
	entity INV1 is
		port(
			A: in std_logic;
			Q: out std_logic
		);
	end entity INV1;
	
	architecture basic of INV1 is
	begin
		Q <= not A;
	end architecture basic;
		
		-- INV2
library ieee;
use ieee.std_logic_1164.all;
	
	entity INV2 is
		port(
			A: in std_logic;
			Q: out std_logic
		);
	end entity INV2;
	
	architecture basic of INV2 is
	begin
		Q <= not A;
	end architecture basic;
		
		-- INV3
library ieee;
use ieee.std_logic_1164.all;
	
	entity INV3 is
		port(
			A: in std_logic;
			Q: out std_logic
		);
	end entity INV3;
	
	architecture basic of INV3 is
	begin
		Q <= not A;
	end architecture basic;
		
		-- INV4
library ieee;
use ieee.std_logic_1164.all;
	
	entity INV4 is
		port(
			A: in std_logic;
			Q: out std_logic
		);
	end entity INV4;
	
	architecture basic of INV4 is
	begin
		Q <= not A;
	end architecture basic;
		
		-- INV6
library ieee;
use ieee.std_logic_1164.all;
	
	entity INV6 is
		port(
			A: in std_logic;
			Q: out std_logic
		);
	end entity INV6;
	
	architecture basic of INV6 is
	begin
		Q <= not A;
	end architecture basic;
		
		-- INV8
library ieee;
use ieee.std_logic_1164.all;
	
	entity INV8 is
		port(
			A: in std_logic;
			Q: out std_logic
		);
	end entity INV8;
	
	architecture basic of INV8 is
	begin
		Q <= not A;
	end architecture basic;
		
		-- INV10
library ieee;
use ieee.std_logic_1164.all;
	
	entity INV10 is
		port(
			A: in std_logic;
			Q: out std_logic
		);
	end entity INV10;
	
	architecture basic of INV10 is
	begin
		Q <= not A;
	end architecture basic;
		
		-- INV12
library ieee;
use ieee.std_logic_1164.all;
	
	entity INV12 is
		port(
			A: in std_logic;
			Q: out std_logic
		);
	end entity INV12;
	
	architecture basic of INV12 is
	begin
		Q <= not A;
	end architecture basic;
	
		-- INV15
library ieee;
use ieee.std_logic_1164.all;
	
	entity INV15 is
		port(
			A: in std_logic;
			Q: out std_logic
		);
	end entity INV15;
	
	architecture basic of INV15 is
	begin
		Q <= not A;
	end architecture basic;
	
		-- NAND20
library ieee;
use ieee.std_logic_1164.all;
	
	entity NAND20 is
		port(
			A: in std_logic;
			B: in std_logic;
			Q: out std_logic
		);
	end entity NAND20;
	
	architecture basic of NAND20 is
	begin
		Q <= A nand B;
	end architecture basic;
	
		-- NAND21
library ieee;
use ieee.std_logic_1164.all;
	
	entity NAND21 is
		port(
			A: in std_logic;
			B: in std_logic;
			Q: out std_logic
		);
	end entity NAND21;
	
	architecture basic of NAND21 is
	begin
		Q <= A nand B;
	end architecture basic;
	
		-- NAND22
library ieee;
use ieee.std_logic_1164.all;
	
	entity NAND22 is
		port(
			A: in std_logic;
			B: in std_logic;
			Q: out std_logic
		);
	end entity NAND22;
	
	architecture basic of NAND22 is
	begin
		Q <= A nand B;
	end architecture basic;
	
		-- NAND23
library ieee;
use ieee.std_logic_1164.all;
	
	entity NAND23 is
		port(
			A: in std_logic;
			B: in std_logic;
			Q: out std_logic
		);
	end entity NAND23;
	
	architecture basic of NAND23 is
	begin
		Q <= A nand B;
	end architecture basic;
	
		-- NAND24
library ieee;
use ieee.std_logic_1164.all;
	
	entity NAND24 is
		port(
			A: in std_logic;
			B: in std_logic;
			Q: out std_logic
		);
	end entity NAND24;
	
	architecture basic of NAND24 is
	begin
		Q <= A nand B;
	end architecture basic;
	
		-- NAND26
library ieee;
use ieee.std_logic_1164.all;
	
	entity NAND26 is
		port(
			A: in std_logic;
			B: in std_logic;
			Q: out std_logic
		);
	end entity NAND26;
	
	architecture basic of NAND26 is
	begin
		Q <= A nand B;
	end architecture basic;
	
		-- NAND28
library ieee;
use ieee.std_logic_1164.all;
	
	entity NAND28 is
		port(
			A: in std_logic;
			B: in std_logic;
			Q: out std_logic
		);
	end entity NAND28;
	
	architecture basic of NAND28 is
	begin
		Q <= A nand B;
	end architecture basic;
