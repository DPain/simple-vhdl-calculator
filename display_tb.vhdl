-- display_tb.vhdl
-- CPEG324 - Lab 3
-- Display testbench

library ieee;
use ieee.std_logic_1164.all;

entity display_tb is
end entity display_tb;

architecture behave of display_tb is

    component display is
        port
        (
            num:	in std_logic_vector (7 downto 0);
            clk:	in std_logic;
            show:   in std_logic
        );
    end component;
    
    -- Signals
    signal v : std_logic_vector (7 downto 0);
    signal clock, enable : std_logic;
    
    begin
        --  Component
        comp: display
            port map (
                num => v,
                clk => clock,
                show => enable
            );
           
    -- Testbench
    process
    
        type entry is record
            num   : std_logic_vector (7 downto 0);
            clk   : std_logic;
            show  : std_logic;
        end record;
        
        type entry_list is array (natural range <>) of entry;
        constant entries : entry_list :=(
            ("00000000", '0', '1'),
            ("11010111", '1', '1'), -- -41
            ("00101010", '0', '0'),
            ("01011010", '1', '0'),
            ("11111111", '0', '1'),
            ("11101000", '1', '1'), -- -24
            ("10000000", '0', '1'),
            ("00010001", '1', '1'), -- 17
            ("11000011", '0', '0')
        );
        
        begin
	
        -- Test
        for i in entries'range loop
            v <= entries(i).num;
            clock <= entries(i).clk;
            enable <= entries(i).show;
            
            wait for 1 ns;
        end loop;
        
        report "Check outputs: -41, -24, 17";
        wait;
    end process;
end behave;