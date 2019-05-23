-- dff.vhdl
-- CPEG324 - Lab 3
-- The D Flip-Flop (dff) with asynchronous reset on rising clock.
-- Reference from www.fpga4student.com/2017/02/vhdl-code-for-d-flip-flop.html

library ieee;
use ieee. std_logic_1164.all;
 
entity dff is
    port
	(   
        clk: in std_logic;
		D: in std_logic;
		R: in std_logic;
        Q: out std_logic
    );
end dff;
 
architecture behave of dff is
begin
    process(clk,R)
    begin
        if (R = '1') then
            Q <= '0';
        elsif(rising_edge(clk)) then
            Q <= D;
        end if;
    end process;
end behave;