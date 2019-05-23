-- calculator.vhdl
-- CPEG324 - Lab 3
-- The full controller for all the ISA operations.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calculator is
	port
	(
		I : in std_logic_vector(7 downto 0);
		clk : in std_logic;
		Led : out std_logic_vector(7 downto 0)
	);
end entity calculator;

architecture behave of calculator is
	component alu is
		port
		(
			A:	in std_logic_vector (7 downto 0);
			B:	in std_logic_vector (7 downto 0);
			OP: in std_logic;
			S:	out std_logic_vector(7 downto 0)
		);
	end component alu;
	
	component register_file is
		port
		(
			RD, RS, RT : in std_logic_vector(1 downto 0);
			WD : in std_logic_vector(7 downto 0);
			RS_data, RT_data : out std_logic_vector(7 downto 0);
			WE,clk : in std_logic
		);
	end component register_file;
	
	component comparator is
		port
		(
			RS_data, RT_data : in std_logic_vector(7 downto 0);
			comp_check : out std_logic
		);
	end component comparator;
	
	component display is
		port
		(
			num:	in std_logic_vector (7 downto 0);
         clk:	in std_logic;
         show:   in std_logic;
			output:    out std_logic_vector (7 downto 0)
		);
	end component display;
	
	component clock_buffer is
		port
		(
			clk_in : in std_logic;
			clk_out : out std_logic;
			SL: in std_logic;
			CC: in std_logic
		);
	end component clock_buffer;
	
	-- Signals Need to be Here
	signal WE : std_logic;
	signal comp_check : std_logic;
	signal disp : std_logic;
	signal buff_clk : std_logic;
	signal WD_en : std_logic;
	signal RD : std_logic_vector(1 downto 0);
	signal RS : std_logic_vector(1 downto 0);
	signal RT : std_logic_vector(1 downto 0);
	signal WD : std_logic_vector(7 downto 0);
	signal RS_data : std_logic_vector(7 downto 0);
	signal RT_data : std_logic_vector(7 downto 0);
	signal sign_ext : std_logic_vector(7 downto 0);
	signal alu_out : std_logic_vector(7 downto 0);
	signal display_val : std_logic_vector(7 downto 0);
	
	begin
		register_file_component : register_file port map(RD, RS, RT, WD, RS_data, RT_data, WE, buff_clk);
		alu_component : alu port map(RS_data, RT_data, I(7), alu_out);
		display_component: display port map(
                num => RS_data,
                clk => buff_clk,
                show => disp,
					 output => display_val
            );
		clock_buffer_component : clock_buffer port map(clk, buff_clk, I(4), comp_check);
		comparator_component : comparator port map(RS_data, RT_data, comp_check);
		
		RD <= I(5 downto 4);
		RS <= I(3 downto 2);
		RT <= I(1 downto 0);
	
		disp <= '1' when I(7 downto 5) = "001" else
				'0';
		
		sign_ext(3 downto 0) <= I(3 downto 0);
		with I(3) select sign_ext(7 downto 4) <=
			"1111" when '1',
			"0000" when others;
	
		WD_en <= not(I(7) and I(6));
		with WD_en select WD <=
			sign_ext when '0',
			alu_out when others;
		
		WE <= I(7) or I(6);
		
		Led <= display_val;
		
end behave;