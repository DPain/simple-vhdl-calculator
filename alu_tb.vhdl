-- alu_tb.vhdl
-- CPEG324 - Lab 3
-- 8Bit ALU testbench

library ieee;
use ieee.std_logic_1164.all;

entity alu_tb is
end entity alu_tb;

architecture behave of alu_tb is

    component alu is
        port
        (
            A:	in std_logic_vector (7 downto 0);
            B:	in std_logic_vector (7 downto 0);
            OP: in std_logic;
            S:	out std_logic_vector(7 downto 0)
        );
    end component;
    
    -- Signals
    signal a, b, s : std_logic_vector (7 downto 0);
    signal op : std_logic;
    
    begin
        --  Component
        comp: alu 
            port map (
                A => a,
                B => b,
                OP => op,
                S => s
            );
           
    -- Testbench
    process
    
        type entry is record
            a   : std_logic_vector (7 downto 0);
            b   : std_logic_vector (7 downto 0);
            op  : std_logic;
            s   : std_logic_vector (7 downto 0);
        end record;
        
        type entry_list is array (natural range <>) of entry;
        constant entries : entry_list :=(
            ("00000000", "00000000" , '0', "00000000"),
            ("00010000", "00000001" , '0', "00010001"),
            ("11110000", "00000000" , '0', "11110000"),
            ("00111100", "00000111" , '0', "01000011"),
            ("10101010", "01010101" , '0', "11111111"),
            ("11101100", "00110011" , '0', "00011111"),
            ("00000001", "00000001" , '0', "00000010"),
            ("00001100", "00001111" , '0', "00011011"),
            ("11111111", "11111111" , '0', "11111110"),
            ("00000000", "00000000" , '1', "00000000"),
            ("00010000", "00000001" , '1', "00001111"),
            ("11110000", "00000000" , '1', "11110000"),
            ("00111100", "00000111" , '1', "00110101"),
            ("10101010", "01010101" , '1', "01010101"),
            ("11101100", "00110011" , '1', "10111001"),
            ("00000001", "00000001" , '1', "00000000"),
            ("00001100", "00001111" , '1', "11111101"),
            ("11111111", "11111111" , '1', "00000000")
        );
        
        begin
	
        -- Test
        for i in entries'range loop
            a <= entries(i).a;
            b <= entries(i).b;
            op <= entries(i).op;
            
            wait for 1 ns;
            
            assert s = entries(i).s report "Incorrect!" severity error;
        end loop;
        
        report "End test";
        wait;
    end process;
end behave;