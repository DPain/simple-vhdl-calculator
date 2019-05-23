-- dlatch.vhdl
-- CPEG324 - Lab 3
-- The D Latch
-- Reference www.startingelectronics.org/software/VHDL-CPLD-course/tut10-gated-D-latch/

library ieee;
use ieee. std_logic_1164.all;
 
entity dlatch is
    port
	(   
		D: in std_logic;
		E: in std_logic;
        Q: out std_logic
    );
end dlatch;

architecture behave of dlatch is
begin
process (E,D)
	begin
		if (E = '1') then
			Q <= D;
		end if;
	end process;
end behave;