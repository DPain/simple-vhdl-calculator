-- register_file_tb.vhdl
-- CPEG324 - Lab 3
-- Register file testbench

library ieee;
use ieee.std_logic_1164.all;

entity register_file_tb is
end entity register_file_tb;

architecture behave of register_file_tb is

    component register_file is
        port
        (
            RD, RS, RT : in std_logic_vector(1 downto 0);
            WD : in std_logic_vector(7 downto 0);
            RS_data, RT_data : out std_logic_vector(7 downto 0);
            WE, clk : in std_logic
        );
    end component;
    
    -- Signals
    signal rd, rs, rt : std_logic_vector(1 downto 0);
    signal wd, rs_data, rt_data : std_logic_vector(7 downto 0);
    signal we, clock : std_logic;
    
    begin
        --  Component
        comp: register_file 
            port map (
                RD => rd,
                RS => rs,
                RT => rt,
                WD => wd,
                RS_data => rs_data,
                RT_data => rt_data,
                WE => we,
                clk => clock
            );
           
    -- Testbench
    process
    
        type entry is record
            rd   : std_logic_vector(1 downto 0);
            rs   : std_logic_vector(1 downto 0);
            rt   : std_logic_vector(1 downto 0);
            wd   : std_logic_vector(7 downto 0);
            rs_data : std_logic_vector(7 downto 0);
            rt_data : std_logic_vector(7 downto 0);
            we   : std_logic;
            clock   : std_logic;
        end record;
        
        type entry_list is array (natural range <>) of entry;
        constant entries : entry_list :=(
            ("00", "01", "10", "00000000", "00000000", "00000000", '1', '0'),
            ("01", "00", "00", "11110000", "00000000", "00000000", '1', '1'),
            ("00", "01", "10", "00000000", "11110000", "00000000", '1', '0'),
            ("00", "01", "00", "00000000", "11110000", "00000000", '0', '1'),
            ("00", "01", "11", "00000000", "11110000", "00000000", '1', '0'),
            ("10", "00", "00", "00001111", "00000000", "00000000", '1', '1'),
            ("00", "00", "11", "00000000", "00000000", "00000000", '1', '0'),
            ("00", "00", "10", "00000000", "00000000", "00001111", '0', '1'),
            ("00", "01", "10", "00000000", "11110000", "00001111", '1', '0'),
            ("00", "00", "00", "00000000", "00000000", "00000000", '1', '1'),
            ("00", "10", "10", "00000000", "00001111", "00001111", '1', '0')
        );
        
        begin
	
        -- Test
        for i in entries'range loop
            rd <= entries(i).rd;
            rs <= entries(i).rs;
            rt <= entries(i).rt;
            wd <= entries(i).wd;
            we <= entries(i).we;
            clock <= entries(i).clock;
            
            wait for 10 ns;
            
            assert rs_data = entries(i).rs_data report "Incorrect RS!" severity error;
            assert rt_data = entries(i).rt_data report "Incorrect RT!" severity error;
        end loop;
        
        report "End test";
        wait;
    end process;
end behave;