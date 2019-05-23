-- calculator_tb.vhdl
-- CPEG324 - Lab 3
-- Calculator testbench

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calculator_tb is
end entity calculator_tb;

architecture behave of calculator_tb is

    component calculator is
        port
        (
            I : in std_logic_vector(7 downto 0);
            clk : in std_logic
        );
    end component;
    
    -- Signals
    signal input : std_logic_vector (7 downto 0);
    signal test_clk : std_logic;
    
    begin
        --  Component
        comp: calculator 
            port map (
                I => input,
                clk => test_clk
            );

    -- Testbench
    process
    
        type entry is record
            input   : std_logic_vector (7 downto 0);
            clk   : std_logic;
        end record;
        
        type entry_list is array (natural range <>) of entry;
        constant entries : entry_list :=(
            ("11000011", '0'),
            ("11010110", '1'),
            ("01100001", '0'),
            ("10111001", '1'),
            ("00101100", '0')
        );
        
        begin
	
        -- Test
        for i in entries'range loop
            input <= entries(i).input;
            test_clk <= entries(i).clk;
            
            wait for 1 ns;
        end loop;
        
        report "Expecting: 00000011. End test";
        wait;
    end process;
end behave;