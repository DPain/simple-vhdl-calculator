-- clock_buffer_tb.vhdl
-- CPEG324 - Lab 3
-- Clock buffer testbench

library ieee;
use ieee.std_logic_1164.all;

entity clock_buffer_tb is
end entity clock_buffer_tb;

architecture behave of clock_buffer_tb is

    component clock_buffer is
        port
        (
            clk_in : in std_logic;
            clk_out : out std_logic;
            SL: in std_logic;
            CC: in std_logic -- Comparator Check
        );
    end component;
    
    -- Signals
    signal in_int, out_int, sl_int, cc_int : std_logic;
    
    begin
        --  Component
        comp: clock_buffer 
            port map (
                clk_in => in_int,
                clk_out => out_int,
                SL => sl_int,
                CC => cc_int
            );
           
    -- Testbench
    process
    
        type entry is record
            in_int  : std_logic;
            out_int : std_logic;
            sl_int  : std_logic;
            cc_int  : std_logic;
        end record;
        
        type entry_list is array (natural range <>) of entry;
        constant entries : entry_list :=(
            ('1', '1' , '1', '0'),
            ('1', '0' , '1', '0'),
            ('1', '1' , '0', '1'),
            ('1', '0' , '0', '1')
        );
        
        begin
	
        -- Test
        for i in entries'range loop
            in_int <= entries(i).in_int;
            out_int <= entries(i).out_int;
            sl_int <= entries(i).sl_int;
            cc_int <= entries(i).cc_int;
            
            wait for 1 ns;
            
            assert cc_int = entries(i).cc_int report "Incorrect!" severity error;
        end loop;
        
        report "End test";
        wait;
    end process;
end behave;