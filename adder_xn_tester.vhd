library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.adder_xn;

entity adder_xn_tester is
	generic(	x : integer := 2;
				n : integer := 16);
	port(clk: in std_logic;
		  correct: out boolean;
		  fos: inout std_logic_vector(n downto 0));
end entity adder_xn_tester;

architecture exhaustive of adder_xn_tester is

	component adder_xn is
		generic(
			x: integer := 2;
			n: integer := 16
		);
		port(
			a: in std_logic_vector(n-1 downto 0);
			s: out std_logic_vector(n-1 downto 0);
			cout: out std_logic
		);
end component;


	signal a: integer range 0 to 2**(n)-1 := 0;
	signal s: integer range 0 to 2**(n+1)-1;
	signal al, os: std_logic_vector(n-1 downto 0);
	signal cout: std_logic;

begin
	
	al <= std_logic_vector(to_unsigned(a,n));
	
	fos(n) <= cout;
	fos(n-1 downto 0) <= os;
	
	s <= to_integer(unsigned(fos));
	
ADDER: 
	adder_xn generic map(n=>n, x=>x) port map(a=>al,s=>os,cout=>cout);

	
	process(clk) is
		variable er : boolean := false;
	begin
		if(rising_edge(clk)) then
			if(s /= a+x) then
				er := true;
			end if;
			assert (s = a+x) report "Adder Failure" severity failure;
			correct <= not er;
			er := false;
			if(a = (2**n)-1) then
				a <= 0;
				assert (false) report "[Success]Finished Simulation" severity failure;
			else
				a <= a + 1;
			end if;
		end if;
	end process;
	

end architecture exhaustive;