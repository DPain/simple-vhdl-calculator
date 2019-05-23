-- dff_tb.vhdl
-- CPEG324 - Lab 3
-- DFF testbench

library ieee;
use ieee.std_logic_1164.all;

entity dff_tb is
end entity dff_tb;

architecture behave of dff_tb is

    component dff is
        port
        (
            clk: in std_logic;
            D: in std_logic;
            R: in std_logic;
            Q: out std_logic
        );
    end component;
    
    -- Signals
    signal d, r, q : std_logic;
    signal clk : std_logic;
    
    begin
        --  Component
        comp: dff 
            port map (
                D => d,
                R => r,
                Q => q,
                clk => clk
            );
           
    -- Testbench
    process
    
        type entry is record
            d   : std_logic;
            r   : std_logic;
            q   : std_logic;
            clk : std_logic;
        end record;
        
        type entry_list is array (natural range <>) of entry;
        constant entries : entry_list :=(
            ('0', '1' , '0', '1'),
            ('1', '0' , '0', '0'),
            ('1', '0' , '1', '1'),
            ('1', '1' , '0', '0'),
            ('0', '0' , '0', '1'),
            ('1', '1' , '0', '0'),
            ('0', '1' , '0', '1')
        );
        
        begin
	
        -- Test
        for i in entries'range loop
            d <= entries(i).d;
            r <= entries(i).r;
            clk <= entries(i).clk;
            
            wait for 1 ns;
            
            assert q = entries(i).q report "Incorrect!" severity error;
        end loop;
        
        report "End test";
        wait;
    end process;
end behave;