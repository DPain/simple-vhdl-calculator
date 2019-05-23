-- dlatch_tb.vhdl
-- CPEG324 - Lab 3
-- D-latch testbench

library ieee;
use ieee.std_logic_1164.all;

entity dlatch_tb is
end entity dlatch_tb;

architecture behave of dlatch_tb is

    component dlatch is
        port
        (
            D: in std_logic;
            E: in std_logic;
            Q: out std_logic
        );
    end component;
    
    -- Signals
    signal d, e, q : std_logic;
    
    begin
        --  Component
        comp: dlatch 
            port map (
                D => d,
                E => e,
                Q => q
            );
           
    -- Testbench
    process
    
        type entry is record
            d   : std_logic;
            e   : std_logic;
            q   : std_logic;
        end record;
        
        type entry_list is array (natural range <>) of entry;
        constant entries : entry_list :=(
            ('0', '1', '0'),
            ('1', '1', '1'),
            ('1', '0', '1'),
            ('0', '0', '1')
        );
        
        begin
	
        -- Test
        for i in entries'range loop
            d <= entries(i).d;
            e <= entries(i).e;
            
            wait for 1 ns;
            
            assert q = entries(i).q report "Incorrect!" severity error;
        end loop;
        
        report "End test";
        wait;
    end process;
end behave;