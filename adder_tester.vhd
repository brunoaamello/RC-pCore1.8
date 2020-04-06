library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.adder_n;

entity adder_tester is
	generic(n : integer := 8);
	port(clk: in std_logic;
		  correct: out boolean;
		  fos: inout std_logic_vector(n downto 0));
end entity adder_tester;

architecture assertive of adder_tester is

	component adder_n is
		generic(
			n: integer := 17
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
	

end architecture assertive;



