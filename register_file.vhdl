-- register_file.vhdl
-- CPEG324 - Lab 3
-- Register_file contains all logic needed to read,
-- and write four 8-bit register files, R0 to R3.

library ieee;
use ieee.std_logic_1164.all;

entity register_file is
port
	(
		RD, RS, RT : in std_logic_vector(1 downto 0);
		WD : in std_logic_vector(7 downto 0);
		RS_data, RT_data : out std_logic_vector(7 downto 0);
		WE,clk : in std_logic
	);
end entity register_file;

architecture behave of register_file is
	signal R0, R1, R2, R3 : std_logic_vector(7 downto 0) := "00000000";
begin
    with RS select RS_data <=
		R0 when "00",
		R1 when "01",
		R2 when "10",
		R3 when others;
    with RT select RT_data <=
		R0 when "00",
		R1 when "01",
		R2 when "10",
		R3 when others;
    process (clk) is
		begin
			if (rising_edge(clk) and WE = '1') then
				if (RD = "00") then
					R0 <= WD;
				elsif (RD = "01") then
					R1 <= WD;
				elsif (RD = "10") then
					R2 <= WD;
				elsif (RD = "11") then
					R3 <= WD;
				end if;
			end if;
		end process;
end behave;