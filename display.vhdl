-- Display on rising clock.
-- CPEG324 - Lab 3

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display is
	port
    (
        num:	in std_logic_vector (7 downto 0);
        clk:	in std_logic;
        show:   in std_logic;
		  output:	out std_logic_vector (7 downto 0)
	 );
end entity display;

architecture behave of display is

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if (show = '1') then
				    output <= num;
                report " " & integer'image(to_integer(signed(num)));
            end if;
        end if;
    end process;
end behave;