LIBRARY IEEE;
USE ieee.std_logic_1164.all;
------------------------------------------------
ENTITY bitn_fullAdder IS
	GENERIC (B_LENGTH : INTEGER := 9);
	PORT
	(
		A    : IN  STD_LOGIC_VECTOR(B_LENGTH - 1 DOWNTO 0);
		B    : IN  STD_LOGIC_VECTOR(B_LENGTH - 1 DOWNTO 0);
		Cin  : IN  STD_LOGIC                              ;
		Cout : OUT STD_LOGIC                              ;
		S    : OUT STD_LOGIC_VECTOR(B_LENGTH - 1 DOWNTO 0)
	);
END ENTITY bitn_fullAdder;
------------------------------------------------
ARCHITECTURE call OF bitn_fullAdder IS
SIGNAL ICout : STD_LOGIC_VECTOR(B_LENGTH - 1 DOWNTO 0);
BEGIN
	
	Cout <= ICout(B_LENGTH - 1);
	fullAdder0 : ENTITY WORK.bit1_fullAdder
	PORT MAP
	(
		A    => A(0)    ,
		B    => B(0)    ,
		Cin  => Cin     ,
		Cout => ICout(0),
		S    => S(0)
	);
	
	fullAdderLoop : FOR i IN 1 TO (B_LENGTH -1) GENERATE
		
		fullAdder_i : ENTITY WORK.bit1_fullAdder
		PORT MAP
		(
			A    => A(i)        ,
			B    => B(i)        ,
			Cin  => ICout(i - 1),
			Cout => ICout(i)    ,
			S    => S(i)        
		);
	END GENERATE;
END call;

