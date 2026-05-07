LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY bit1_fullAdder IS
    PORT (
        A    : IN  STD_LOGIC;
        B    : IN  STD_LOGIC;
        Cin  : IN  STD_LOGIC;
        S	 : OUT STD_LOGIC;
		  Cout : OUT STD_LOGIC
    );
END ENTITY bit1_fullAdder;

ARCHITECTURE mux_sumador OF bit1_fullAdder IS
    SIGNAL sel : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN
    sel <= A & B & Cin; 

    WITH sel SELECT
        S <= '0' WHEN "000",
             '1' WHEN "001",
             '1' WHEN "010",
             '0' WHEN "011",
             '1' WHEN "100",
             '0' WHEN "101",
             '0' WHEN "110",
             '1' WHEN OTHERS; 

    WITH sel SELECT
        Cout <= '0' WHEN "000",
                '0' WHEN "001",
                '0' WHEN "010",
                '1' WHEN "011",
                '0' WHEN "100",
                '1' WHEN "101",
                '1' WHEN "110",
                '1' WHEN OTHERS;
END ARCHITECTURE mux_sumador;
