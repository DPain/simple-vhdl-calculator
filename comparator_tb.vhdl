-- comparator_tb.vhdl
-- CPEG324 - Lab 3
-- Comparator testbench

library ieee;
use ieee.std_logic_1164.all;

entity comparator_tb is
end entity comparator_tb;

architecture behave of comparator_tb is

    component comparator is
        port
        (
            RS_data, RT_data : in std_logic_vector(7 downto 0);
            comp_check : out std_logic
        );
    end component;
    
    -- Signals
    signal rs, rt : std_logic_vector (7 downto 0);
    signal comp : std_logic;
    
    begin
        --  Component
        compon: comparator 
            port map (
                RS_data => rs,
                RT_data => rt,
                comp_check => comp
            );
           
    -- Testbench
    process
    
        type entry is record
            rs   : std_logic_vector (7 downto 0);
            rt   : std_logic_vector (7 downto 0);
            comp  : std_logic;
        end record;
        
        type entry_list is array (natural range <>) of entry;
        constant entries : entry_list :=(
            ("00000000", "00000000" , '1'),
            ("11110001", "10011100" , '0'),
            ("11001100", "11001100" , '1'),
            ("10000000", "00000001" , '0'),
            ("00110001", "00110001" , '1'),
            ("01010101", "11010010" , '0')
        );
        
        begin
	
        -- Test
        for i in entries'range loop
            rs <= entries(i).rs;
            rt <= entries(i).rt;
            
            wait for 1 ns;
            
            assert comp = entries(i).comp report "Incorrect!" severity error;
        end loop;
        
        report "End test";
        wait;
    end process;
end behave;