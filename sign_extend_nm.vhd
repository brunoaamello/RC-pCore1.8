library ieee;
use ieee.std_logic_1164.all;

-- n --> n bit in generic
-- m --> m bit out generic

entity sign_extend_nm is
	generic(
		n: integer := 12;
		m: integer := 16
	);
	port(
		signal A: in std_logic_vector(n-1 downto 0);
		signal B: out std_logic_vector(m-1 downto 0)
	);
end entity sign_extend_nm;

architecture simple of sign_extend_nm is
	begin
	B(m-1 downto n) <= (others => A(n-1));
	B(n-1 downto 0) <= A(n-1 downto 0);
end architecture simple;

