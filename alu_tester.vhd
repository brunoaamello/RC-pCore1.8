library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.alu;

entity alu_tester is
	generic(n : integer := 8);
	port(clk: in std_logic;
		  correct: out boolean;
		  fos: inout std_logic_vector(n-1 downto 0));
end entity alu_tester;

architecture exhaustive of alu_tester is

	component alu is
		generic(n : integer := 8);
		port(	
			signal A: in std_logic_vector(n-1 downto 0);
			signal B: in std_logic_vector(n-1 downto 0);
			signal Cin: in std_logic;
			signal op: in std_logic_vector(3 downto 0);
			signal S: out std_logic_vector(n-1 downto 0);
			signal WC: out std_logic;
			signal Cout: out std_logic;
			signal lz: out std_logic;
			signal ez: out std_logic;
			signal gz: out std_logic
		);

	end component;
	
	constant NOP:	std_logic_vector(3 downto 0) := "0000";
	constant SL_OP : std_logic_vector(3 downto 0) := "0001";
	constant SR_OP : std_logic_vector(3 downto 0) := "0010";
	constant ADD_OP : std_logic_vector(3 downto 0) := "0011";
	constant ADDC_OP : std_logic_vector(3 downto 0) := "0100";
	constant SUB_OP : std_logic_vector(3 downto 0) := "0101";
	constant NAND_OP : std_logic_vector(3 downto 0) := "0110";
	constant NOR_OP : std_logic_vector(3 downto 0) := "0111";
	constant XOR_OP : std_logic_vector(3 downto 0) := "1000";
	constant NOT_OP : std_logic_vector(3 downto 0) := "1001";
	
	signal stage: integer := 0;
	
	signal A,B,S: std_logic_vector(n-1 downto 0);
	signal op: std_logic_vector(3 downto 0) := "0000";
	signal cin: std_logic := '0';
	signal wc, cout, lz, ez, gz: std_logic;
	
	signal A_count, B_count, C_count: integer := 0;
	signal S_count, S_count_sub: integer;
	
begin
	
	A <= std_logic_vector(to_unsigned(A_count, n));
	B <= std_logic_vector(to_unsigned(B_count, n));
	C_count <= 	1 when std_match(cin, '1') else
					0;
	S_count <= to_integer(unsigned(cout & S));
	S_count_sub <= to_integer(signed((not cout) & S));
	
ALU_INST: 
	alu generic map(n=>n) port map(A=>A,B=>B,Cin=>cin,op=>op,s=>S,WC=>WC,cout=>cout,lz=>lz,ez=>ez,gz=>gz);
	
	
	process(clk) is
	begin
		if(rising_edge(clk)) then
			if(stage = 0) then -- NOP
				assert std_match(WC, '0') report "[NOP]Wrong Write Carry flag" severity failure;				
				if(A_count = (2**n)-1) then
					A_count <= 0;
					if(B_count = (2**n)-1) then
						B_count <= 0;
						if(cin = '0') then
							cin <= '1';
						else
							cin <= '0';
							A_count <= 0;
							B_count <= 0;
							stage <= 1;
							op <= SL_OP;
						end if;
					else
						B_count <= B_count + 1;
					end if;
				else
					A_count <= A_count + 1;
				end if;
				
			elsif(stage = 1) then -- SL
				assert std_match(WC, '0') report "[SL]Wrong Write Carry flag" severity failure;
				assert to_bitvector(S) = to_bitvector(A) sll to_integer(unsigned(B)) report "[SL]Wrong shift" severity failure;
				if(A_count = (2**n)-1) then
					A_count <= 0;
					if(B_count = n-1) then
						B_count <= 0;
						if(cin = '0') then
							cin <= '1';
						else
							cin <= '0';
							A_count <= 0;
							B_count <= 0;
							stage <= 2;
							op <= SR_OP;
						end if;
					else
						B_count <= B_count + 1;
					end if;
				else
					A_count <= A_count + 1;
				end if;
			elsif(stage = 2) then -- SR
				assert std_match(WC, '0') report "[SR]Wrong Write Carry flag" severity failure;
				assert to_bitvector(S) = to_bitvector(A) srl to_integer(unsigned(B)) report "[SR]Wrong shift" severity failure;
				if(A_count = (2**n)-1) then
					A_count <= 0;
					if(B_count = n-1) then
						B_count <= 0;
						if(cin = '0') then
							cin <= '1';
						else
							cin <= '0';
							A_count <= 0;
							B_count <= 0;
							stage <= 3;
							op <= ADD_OP;
						end if;
					else
						B_count <= B_count + 1;
					end if;
				else
					A_count <= A_count + 1;
				end if;
			elsif(stage = 3) then -- ADD
				assert std_match(WC, '1') report "[ADD]Wrong Write Carry flag" severity failure;
				assert S_count = A_count + B_count report "[ADD]Wrong add" severity failure;
				if(A_count = (2**n)-1) then
					A_count <= 0;
					if(B_count = (2**n)-1) then
						B_count <= 0;
						if(cin = '0') then
							cin <= '1';
						else
							cin <= '0';
							A_count <= 0;
							B_count <= 0;
							stage <= 4;
							op <= ADDC_OP;
						end if;
					else
						B_count <= B_count + 1;
					end if;
				else
					A_count <= A_count + 1;
				end if;
			elsif(stage = 4) then -- ADDC
				assert std_match(WC, '1') report "[ADDC]Wrong Write Carry flag" severity failure;
				assert S_count = A_count + B_count + C_count report "[ADDC]Wrong add" severity failure;
				if(A_count = (2**n)-1) then
					A_count <= 0;
					if(B_count = (2**n)-1) then
						B_count <= 0;
						if(cin = '0') then
							cin <= '1';
						else
							cin <= '0';
							A_count <= 0;
							B_count <= 0;
							stage <= 5;
							op <= SUB_OP;
						end if;
					else
						B_count <= B_count + 1;
					end if;
				else
					A_count <= A_count + 1;
				end if;
			elsif(stage = 5) then -- SUB
				assert std_match(WC, '1') report "[SUB]Wrong Write Carry flag" severity failure;
				assert S_count_sub = A_count - B_count report "[SUB]Wrong subtraction" severity failure;
				if(A_count = (2**n)-1) then
					A_count <= 0;
					if(B_count = (2**n)-1) then
						B_count <= 0;
						if(cin = '0') then
							cin <= '1';
						else
							cin <= '0';
							A_count <= 0;
							B_count <= 0;
							stage <= 6;
							op <= NAND_OP;
						end if;
					else
						B_count <= B_count + 1;
					end if;
				else
					A_count <= A_count + 1;
				end if;
			elsif(stage = 6) then -- NAND
				assert std_match(WC, '0') report "[NAND]Wrong Write Carry flag" severity failure;
				assert (S = (A nand B)) report "[NAND]Wrong nand operation" severity failure;
				if(A_count = (2**n)-1) then
					A_count <= 0;
					if(B_count = (2**n)-1) then
						B_count <= 0;
						if(cin = '0') then
							cin <= '1';
						else
							cin <= '0';
							A_count <= 0;
							B_count <= 0;
							stage <= 7;
							op <= NOR_OP;
						end if;
					else
						B_count <= B_count + 1;
					end if;
				else
					A_count <= A_count + 1;
				end if;
			elsif(stage = 7) then -- NOR
				assert std_match(WC, '0') report "[NOR]Wrong Write Carry flag" severity failure;
				assert S = (A nor B) report "[NOR]Wrong nor operation" severity failure;
				if(A_count = (2**n)-1) then
					A_count <= 0;
					if(B_count = (2**n)-1) then
						B_count <= 0;
						if(cin = '0') then
							cin <= '1';
						else
							cin <= '0';
							A_count <= 0;
							B_count <= 0;
							stage <= 8;
							op <= XOR_OP;
						end if;
					else
						B_count <= B_count + 1;
					end if;
				else
					A_count <= A_count + 1;
				end if;
			elsif(stage = 8) then -- XOR
				assert std_match(WC, '0') report "[XOR]Wrong Write Carry flag" severity failure;
				assert S = (A xor B) report "[XOR]Wrong xor operation" severity failure;
				if(A_count = (2**n)-1) then
					A_count <= 0;
					if(B_count = (2**n)-1) then
						B_count <= 0;
						if(cin = '0') then
							cin <= '1';
						else
							cin <= '0';
							A_count <= 0;
							B_count <= 0;
							stage <= 9;
							op <= NOT_OP;
						end if;
					else
						B_count <= B_count + 1;
					end if;
				else
					A_count <= A_count + 1;
				end if;
			elsif(stage = 9) then -- NOR
				assert std_match(WC, '0') report "[NOT]Wrong Write Carry flag" severity failure;
				assert S = (not A) report "[NOT]Wrong not operation" severity failure;
				if(A_count = (2**n)-1) then
					A_count <= 0;
					if(B_count = (2**n)-1) then
						B_count <= 0;
						if(cin = '0') then
							cin <= '1';
						else
							assert false report "[SUCCESS]Finished Simulation" severity failure;
						end if;
					else
						B_count <= B_count + 1;
					end if;
				else
					A_count <= A_count + 1;
				end if;
			end if;
		end if;
	end process;
	

end architecture exhaustive;

