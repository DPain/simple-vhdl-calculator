-- clock_buffer.vhdl
-- CPEG324 - Lab 3
-- Clock buffer is to skip instructions for the compare
-- function in the ISA, using three D Flip-Flops and two
-- D Latches.

library ieee;
use ieee.std_logic_1164.all;

entity clock_buffer is
	port
	(
		clk_in : in std_logic;
		clk_out : out std_logic;
		SL: in std_logic;
		CC: in std_logic -- Comparator Check
	);
end entity clock_buffer;

architecture behave of clock_buffer is
	component dff is
		port
		(
			clk : in std_logic;
			D : in std_logic;
			R : in std_logic;
			Q : out std_logic
		);
	end component dff;
  
	component dlatch is
		port
		(
			D : in std_logic;
			E : in std_logic;
			Q : out std_logic
		);
	end component dlatch;

	signal Q0,Q1,Q2,Q3,Q4 : std_logic := '1';
	signal D3,D4 : std_logic := '1';
	
begin
	dff0 : dff port map(clk_in, '1', Q3, Q0);
	dff1 : dff port map(clk_in, Q0, Q4, Q1);
	dff2 : dff port map(clk_in, Q1, '0', Q2);
	dlatch0 : dlatch port map(D3, clk_in, Q3);
	dlatch1 : dlatch port map(D4, clk_in, Q4);
	
	D3 <= SL and D4;
	D4 <= CC and Q0 and Q1 and Q2;
	clk_out <= Q2 and clk_in after 1 ps;
end behave;
