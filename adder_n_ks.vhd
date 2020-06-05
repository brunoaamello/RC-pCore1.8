library ieee;
use ieee.std_logic_1164.all;

use work.functions.log2;

use work.basic_types.std_logic_matrix;

use work.adder_utils.all;

entity adder_n_ks is
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


end entity adder_n_ks;

architecture Kogge_Stone of adder_n_ks is	
	
	constant n_s: integer := log2(n);
	
	signal g, p: std_logic_matrix(n_s downto 0, n-1 downto 0);
	
begin

-- Pre-Processing

PRE_PROCESSING_0:
	full_adder port map(a=>a(0), b=>b(0), cin=>cin, s=>p(0, 0), cout=>g(0, 0));

PRE_PROCESSING_1:
	for i in n-1 downto 1 generate
ADDERS:
		half_adder port map(a=>a(i), b=>b(i), s=>p(0, i), cout=>g(0, i));
	end generate PRE_PROCESSING_1;


-- Carry propagation
	
	
CARRY_PROPAGATION:
	for stage in 1 to n_s generate
	
CARRY_PROPAGATION_0:
		for i in n-1 downto 0 generate
		
CARRY_PROPAGATION_1:
			if(i >= (2**(stage-1))) generate
MERGERS:		merger port map(
					gin=>g(stage-1, i),
					ginprev=>g(stage-1, i-(2**(stage-1))),
					pin=>p(stage-1, i),
					pinprev=>p(stage-1, i-(2**(stage-1))),
					gout=>g(stage, i),
					pout=>p(stage, i)
				);
			end generate CARRY_PROPAGATION_1;
			
CARRY_PROPAGATION_2:
			if(not (i >= (2**(stage-1)))) generate
				g(stage, i) <= g(stage-1, i);
				p(stage, i) <= p(stage-1, i);
			end generate CARRY_PROPAGATION_2;
			
		end generate CARRY_PROPAGATION_0;
	
	end generate CARRY_PROPAGATION;
	
	
-- Post-Processing
	
POST_PROCESSING_0:
	s(0) <= p(n_s, 0);

POST_PROCESSING_1:
	for i in 1 to n-1 generate
		s(i) <= p(0, i) xor g(n_s, i-1);
	end generate POST_PROCESSING_1;
	

	cout <= g(n_s, n-1);
	
	
end architecture Kogge_Stone;