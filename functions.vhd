library ieee;
use ieee.std_logic_1164.all;

package functions is
	
	pure function log2(a: integer) return integer;
	
	pure function or_reduce(a: std_logic_vector) return std_logic;

end functions;


package body functions is

	pure function log2(a: integer) return integer is
		variable count : integer := 0;
		variable ia: integer := a;
		begin
			-- Log Calculation
			while(ia > 1) loop
				count := count + 1;
				ia := ia/2;
			end loop;
			-- Round up if not exact
			if(2**count < a) then
				count := count + 1;
			end if;
			-- Return result
			return count;
	end function;
	
	pure function or_reduce(a: std_logic_vector) return std_logic is
		variable result: std_logic := '0';
		begin
			for i in 0 to a'length-1 loop
				result := result or a(i);
			end loop;
			return result;
	end function;
	
	
	

end functions;