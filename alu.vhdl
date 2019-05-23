-- alu.vhdl
-- CPEG324 - Lab 3
-- 8Bit ALU that can add or subtract

library ieee;
use ieee.std_logic_1164.all;

entity alu is
	port
    (
        A:	in std_logic_vector (7 downto 0);
        B:	in std_logic_vector (7 downto 0);
        OP: in std_logic;   -- 0 = add, 1 = subtract
        S:	out std_logic_vector(7 downto 0)
	);
end entity alu;

architecture structural of alu is

    component full_adder is
        port
        (
            A, B, Cin : in std_logic;
            S, Cout : out std_logic
        );
    end component;
    
    -- Signals
    signal cint : std_logic_vector (7 downto 0);
    signal bint : std_logic_vector (7 downto 0);
    
    begin
        bint(0) <= B(0) xor OP;
        bint(1) <= B(1) xor OP;
        bint(2) <= B(2) xor OP;
        bint(3) <= B(3) xor OP;
        bint(4) <= B(4) xor OP;
        bint(5) <= B(5) xor OP;
        bint(6) <= B(6) xor OP;
        bint(7) <= B(7) xor OP;
            
        fa_0: full_adder port map(
                A => A(0),
                B => bint(0),
                Cin => OP,
                S => S(0),
                Cout => cint(0)
            );

        fa_1: full_adder port map(
                    A => A(1),
                    B => bint(1),
                    Cin => cint(0),
                    S => S(1),
                    Cout => cint(1)
                );
				
		fa_2: full_adder port map(
                    A => A(2),
                    B => bint(2),
                    Cin => cint(1),
                    S => S(2),
                    Cout => cint(2)
                );
				
		fa_3: full_adder port map(
                    A => A(3),
                    B => bint(3),
                    Cin => cint(2),
                    S => S(3),
                    Cout => cint(3)
                );
				
		fa_4: full_adder port map(
                    A => A(4),
                    B => bint(4),
                    Cin => cint(3),
                    S => S(4),
                    Cout => cint(4)
                );
				
		fa_5: full_adder port map(
                    A => A(5),
                    B => bint(5),
                    Cin => cint(4),
                    S => S(5),
                    Cout => cint(5)
                );
				
		fa_6: full_adder port map(
                    A => A(6),
                    B => bint(6),
                    Cin => cint(5),
                    S => S(6),
                    Cout => cint(6)
                );
				
		fa_7: full_adder port map(
                    A => A(7),
                    B => bint(7),
                    Cin => cint(6),
                    S => S(7),
                    Cout => cint(7)
                );
		
end architecture;