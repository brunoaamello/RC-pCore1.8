library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.adder_n;

entity adder_tester is
	generic(n : integer := 16);
	port(clk: in std_logic;
		  correct: out boolean;
		  fos: inout std_logic_vector(n downto 0));
end entity adder_tester;

architecture exhaustive of adder_tester is

	component adder_n is
		generic(
			n: integer := 16
		);
		port(
			a: in std_logic_vector(n-1 downto 0);
			b: in std_logic_vector(n-1 downto 0);
			cin: in std_logic;
			s: out std_logic_vector(n-1 downto 0);
			cout: out std_logic
		);
end component;


	signal a, b: integer range 0 to 2**(n)-1 := 0;
	signal s: integer range 0 to 2**(n+1)-1;
	signal al, bl, os: std_logic_vector(n-1 downto 0);
	--shared variable sl: unsigned(n downto 0);
	signal cin : std_logic := '0';
	signal cout: std_logic;

begin
	
	al <= std_logic_vector(to_unsigned(a,n));
	bl <= std_logic_vector(to_unsigned(b,n));
	
	fos(n) <= cout;
	fos(n-1 downto 0) <= os;
	
	s <= to_integer(unsigned(fos));
	
ADDER: 
	adder_n generic map(n=>n) port map(a=>al,b=>bl,s=>os,cin=>cin,cout=>cout);

	
	process(clk) is
		variable er : boolean := false;
	begin
		if(rising_edge(clk)) then
			if(s /= a+b) then
				er := true;
			end if;
			assert (s = a+b) report "Adder Failure" severity failure;
			correct <= not er;
			er := false;
			if(a = (2**n)-1) then
				a <= 0;
				if(b = (2**n)-1) then
					b <= 0;
				else
					b <= b + 1;
				end if;
			else
				a <= a + 1;
			end if;
		end if;
	end process;
	

end architecture exhaustive;

architecture assertive of adder_tester is

	component adder_n is
		generic(
			n: integer := 16
		);
		port(
			a: in std_logic_vector(n-1 downto 0);
			b: in std_logic_vector(n-1 downto 0);
			cin: in std_logic;
			s: out std_logic_vector(n-1 downto 0);
			cout: out std_logic
		);
end component;
	constant n_tests: integer := 10;
	type test_set_type is array(n_tests-1 downto 0, 1 downto 0) of integer;
	
	constant test_set: test_set_type := (	(0, 0),
														(32767, 1),
														(4582, -1548),
														(15478, 14857),
														(65461, -32123),
														(0, 1),
														(1, -1),
														(45781, 14205),
														(14789, -5412),
														(1454, -8)
													);
	
	signal test_it: integer := 0;


	signal a: unsigned(n-1 downto 0);
	signal b: signed(n-1 downto 0);
	signal s: unsigned(n-1 downto 0);
	signal i_a, i_s, i_av: integer := 0;
	signal i_b: integer := 0;
	signal al, bl, os: std_logic_vector(n-1 downto 0);
	signal cin : std_logic := '0';
	signal cout: std_logic;

begin
	
	a <= to_unsigned(i_a, n);
	b <= to_signed(i_b, n);
	i_av <= i_a+i_b;
	i_s <= to_integer(s);
	
	al <= std_logic_vector(a);
	bl <= std_logic_vector(b);
	
	fos(n) <= cout;
	fos(n-1 downto 0) <= os;
	
	s <= unsigned(os);
	
ADDER: 
	adder_n generic map(n=>n) port map(a=>al,b=>bl,s=>os,cin=>cin,cout=>cout);

	process(clk) is
		variable er : boolean := false;
	begin
		if(rising_edge(clk)) then
			if(i_s /= i_av) then
				er := true;
			end if;
			assert (i_s = i_av) report "Adder Failure" severity failure;
			correct <= not er;
			er := false;
			i_a <= test_set(test_it, 1);
			i_b <= test_set(test_it, 0);
			
			if(test_it >= n_tests-1) then
				test_it <= 0;
				assert(false) report "Finished Simulation" severity failure;
			else
				test_it <= test_it + 1;
			end if;
		end if;
	end process;
	

end architecture assertive;



