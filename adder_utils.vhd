library ieee;
use ieee.std_logic_1164.all;

use work.merger;
use work.half_adder;
use work.full_adder;

package adder_utils is

	component half_adder is
		port(
			a: in std_logic;
			b: in std_logic;
			s: out std_logic;
			cout: out std_logic
		);
	end component;
	
	component full_adder is
		port(
			a: in std_logic;
			b: in std_logic;
			cin: in std_logic;
			s: out std_logic;
			cout: out std_logic
		);
	end component;
	
	component merger is
		port(
			gin: in std_logic;
			ginprev: in std_logic;
			pin: in std_logic;
			pinprev: in std_logic;
			gout: out std_logic;
			pout: out std_logic
		);
	end component;
	
	pure function log2(a: integer) return integer;
	
	pure function sklansky_active(i: integer; stage: integer) return boolean;
	pure function sklansky_source(i: integer; stage: integer) return integer;
	
	pure function han_carlsson_active(i: integer; stage: integer) return boolean;
	pure function han_carlsson_source(i: integer; stage: integer) return integer;
	
	pure function kogge_stone_active(i: integer; stage: integer) return boolean;
	pure function kogge_stone_source(i: integer; stage: integer) return integer;
	

end adder_utils;


package body adder_utils is

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
	
--- Sklansky Adder
	
	pure function sklansky_active(i: integer; stage: integer) return boolean is
		begin
		
			if(i mod (2**stage) >= 2**(stage-1)) then
				return true;
			else
				return false;
			end if;
			
	end function;
	
	pure function sklansky_source(i: integer; stage: integer) return integer is
		begin
		
			return (i/(2**stage))*(2**stage) + (2**(stage-1)) - 1;
			
	end function;
	
--- Han-Carlsson Adder
	
	pure function han_carlsson_active(i: integer; stage: integer) return boolean is
		begin
		
			if(i >= (2**(stage-1)) and ((i mod 2) = 1)) then
				return true;
			else
				return false;
			end if;
		
	end function;
	
	pure function han_carlsson_source(i: integer; stage: integer) return integer is
		begin
		
			return i-(2**(stage-1));
		
	end function;
	
--- Kogge-Stone Adder
	
	pure function kogge_stone_active(i: integer; stage: integer) return boolean is
		begin
		
			if(i >= (2**(stage-1))) then
				return true;
			else
				return false;
			end if;
		
	end function;
	
	pure function kogge_stone_source(i: integer; stage: integer) return integer is
		begin
		
			return i-(2**(stage-1));
		
	end function;
	

end adder_utils;