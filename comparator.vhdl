-- comparator.vhdl
-- CPEG324 - Lab 3
-- The comparator is to take RS_data and RT_data and see if they are equal.

library ieee;
use ieee.std_logic_1164.all;

entity comparator is
port
	(
		RS_data, RT_data : in std_logic_vector(7 downto 0);
		comp_check : out std_logic
	);
end entity comparator;

architecture behave of comparator is
begin
	comp_check <= (RS_data(7) xnor RT_data(7)) and
        (RS_data(6) xnor RT_data(6)) and
        (RS_data(5) xnor RT_data(5)) and
        (RS_data(4) xnor RT_data(4)) and
        (RS_data(3) xnor RT_data(3)) and
		(RS_data(2) xnor RT_data(2)) and
        (RS_data(1) xnor RT_data(1)) and
        (RS_data(0) xnor RT_data(0));
end behave;