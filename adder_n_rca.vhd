library ieee;
use ieee.std_logic_1164.all;

use work.functions.log2;

use work.basic_types.std_logic_matrix;

use work.adder_utils.all;

entity adder_n_rca is
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


end entity adder_n_rca;
	

architecture rca of adder_n_rca is

	signal icout, icin: std_logic_vector(n-1 downto 0);

begin

	cout <= icout(n-1);
	icin(0) <= cin;
	icin(n-1 downto 1) <= icout(n-2 downto 0);

ADDITION:
	for i in 0 to n-1 generate
FULL_ADDERS:
		full_adder port map(a=>a(i),b=>b(i),cin=>icin(i),s=>s(i),cout=>icout(i));
	end generate ADDITION;

end architecture rca;

