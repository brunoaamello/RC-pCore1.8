library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.register_bank;

entity reg_bank_tester is
	port(signal dummy: out std_logic);
end entity reg_bank_tester;

architecture exhaustive of reg_bank_tester is

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


	signal ra, rb, rd: std_logic_vector(3 downto 0);
	signal wr_data, A, B, DPH: std_logic_vector(7 downto 0);
	signal wr, clk: std_logic;
	

begin
	
REG_BANK: 
	register_bank port map(clk=>clk, ra=>ra, rb=>rb, wr=>wr, rd=>rd, wr_data=>wr_data, A=>A, B=>B, DPH=>DPH);
	
	
	ra <= "0000", 
			"0001" after 210ps,
			"0010" after 220ps,
			"0011" after 230ps,
			"0100" after 240ps,
			"0101" after 250ps,
			"0110" after 260ps,
			"0111" after 270ps,
			"1000" after 280ps,
			"1001" after 290ps,
			"1010" after 300ps,
			"1011" after 310ps,
			"1100" after 320ps,
			"1101" after 330ps,
			"1110" after 340ps,
			"1111" after 350ps,
			"0000" after 360ps;
	
	rb <= "1111", 
			"1110" after 210ps,
			"1101" after 220ps,
			"1100" after 230ps,
			"1011" after 240ps,
			"1010" after 250ps,
			"1001" after 260ps,
			"1000" after 270ps,
			"0111" after 280ps,
			"0110" after 290ps,
			"0101" after 300ps,
			"0100" after 310ps,
			"0011" after 320ps,
			"0010" after 330ps,
			"0001" after 340ps,
			"0000" after 350ps,
			"0000" after 360ps;
	
	process
	begin
		clk <= '1';
		wait for 5ps;
		clk <= '0';
		while(true) loop
			wait for 5ps;
			clk <= not clk;
		end loop;
	end process;
			
	dummy <= clk;
	
	wr <= '1',
			'0' after 160ps;
	
	rd <= "0000", 
			"0001" after 10ps,
			"0010" after 20ps,
			"0011" after 30ps,
			"0100" after 40ps,
			"0101" after 50ps,
			"0110" after 60ps,
			"0111" after 70ps,
			"1000" after 80ps,
			"1001" after 90ps,
			"1010" after 100ps,
			"1011" after 110ps,
			"1100" after 120ps,
			"1101" after 130ps,
			"1110" after 140ps,
			"1111" after 150ps,
			"0000" after 160ps;
			
	wr_data <= "00000000", 
			"00000001" after 10ps,
			"00000100" after 20ps,
			"00000101" after 30ps,
			"00010000" after 40ps,
			"00010001" after 50ps,
			"00010100" after 60ps,
			"00010101" after 70ps,
			"01000000" after 80ps,
			"01000001" after 90ps,
			"01000100" after 100ps,
			"01000101" after 110ps,
			"01010000" after 120ps,
			"01010001" after 130ps,
			"01010100" after 140ps,
			"01010101" after 150ps,
			"11111111" after 160ps;
		
	process
	begin
		wait for 155ps;
		assert std_match(DPH,"01010101") report "[Failure]Wrong DPH Value" severity failure;
		wait for 50ps;
		assert std_match(DPH,"01010101") report "[Failure]Wrong DPH Value" severity failure;
		assert std_match(A, "00000000") report "[Failure]Wrong A Value" severity failure;
		assert std_match(B, "01010101") report "[Failure]Wrong B Value" severity failure;
		wait for 10ps;
		assert std_match(DPH,"01010101") report "[Failure]Wrong DPH Value" severity failure;
		assert std_match(A, "00000001") report "[Failure]Wrong A Value" severity failure;
		assert std_match(B, "01010100") report "[Failure]Wrong B Value" severity failure;
		wait for 10ps;
		assert std_match(DPH,"01010101") report "[Failure]Wrong DPH Value" severity failure;
		assert std_match(A, "00000100") report "[Failure]Wrong A Value" severity failure;
		assert std_match(B, "01010001") report "[Failure]Wrong B Value" severity failure;
		wait for 10ps;
		assert std_match(DPH,"01010101") report "[Failure]Wrong DPH Value" severity failure;
		assert std_match(A, "00000101") report "[Failure]Wrong A Value" severity failure;
		assert std_match(B, "01010000") report "[Failure]Wrong B Value" severity failure;
		wait for 10ps;
		assert std_match(DPH,"01010101") report "[Failure]Wrong DPH Value" severity failure;
		assert std_match(A, "00010000") report "[Failure]Wrong A Value" severity failure;
		assert std_match(B, "01000101") report "[Failure]Wrong B Value" severity failure;
		wait for 10ps;
		assert std_match(DPH,"01010101") report "[Failure]Wrong DPH Value" severity failure;
		assert std_match(A, "00010001") report "[Failure]Wrong A Value" severity failure;
		assert std_match(B, "01000100") report "[Failure]Wrong B Value" severity failure;
		wait for 10ps;
		assert std_match(DPH,"01010101") report "[Failure]Wrong DPH Value" severity failure;
		assert std_match(A, "00010100") report "[Failure]Wrong A Value" severity failure;
		assert std_match(B, "01000001") report "[Failure]Wrong B Value" severity failure;
		wait for 10ps;
		assert std_match(DPH,"01010101") report "[Failure]Wrong DPH Value" severity failure;
		assert std_match(A, "00010101") report "[Failure]Wrong A Value" severity failure;
		assert std_match(B, "01000000") report "[Failure]Wrong B Value" severity failure;
		wait for 10ps;
		assert std_match(DPH,"01010101") report "[Failure]Wrong DPH Value" severity failure;
		assert std_match(A, "01000000") report "[Failure]Wrong A Value" severity failure;
		assert std_match(B, "00010101") report "[Failure]Wrong B Value" severity failure;
		wait for 10ps;
		assert std_match(DPH,"01010101") report "[Failure]Wrong DPH Value" severity failure;
		assert std_match(A, "01000001") report "[Failure]Wrong A Value" severity failure;
		assert std_match(B, "00010100") report "[Failure]Wrong B Value" severity failure;
		wait for 10ps;
		assert std_match(DPH,"01010101") report "[Failure]Wrong DPH Value" severity failure;
		assert std_match(A, "01000100") report "[Failure]Wrong A Value" severity failure;
		assert std_match(B, "00010001") report "[Failure]Wrong B Value" severity failure;
		wait for 10ps;
		assert std_match(DPH,"01010101") report "[Failure]Wrong DPH Value" severity failure;
		assert std_match(A, "01000101") report "[Failure]Wrong A Value" severity failure;
		assert std_match(B, "00010000") report "[Failure]Wrong B Value" severity failure;
		wait for 10ps;
		assert std_match(DPH,"01010101") report "[Failure]Wrong DPH Value" severity failure;
		assert std_match(A, "01010000") report "[Failure]Wrong A Value" severity failure;
		assert std_match(B, "00000101") report "[Failure]Wrong B Value" severity failure;
		wait for 10ps;
		assert std_match(DPH,"01010101") report "[Failure]Wrong DPH Value" severity failure;
		assert std_match(A, "01010001") report "[Failure]Wrong A Value" severity failure;
		assert std_match(B, "00000100") report "[Failure]Wrong B Value" severity failure;
		wait for 10ps;
		assert std_match(DPH,"01010101") report "[Failure]Wrong DPH Value" severity failure;
		assert std_match(A, "01010100") report "[Failure]Wrong A Value" severity failure;
		assert std_match(B, "00000001") report "[Failure]Wrong B Value" severity failure;
		wait for 10ps;
		assert std_match(DPH,"01010101") report "[Failure]Wrong DPH Value" severity failure;
		assert std_match(A, "01010101") report "[Failure]Wrong A Value" severity failure;
		assert std_match(B, "00000000") report "[Failure]Wrong B Value" severity failure;
		
		wait for 100ps;
		assert false report "[Success]Finished Simulation" severity failure;
		
	end process;
	

end architecture exhaustive;