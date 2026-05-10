LIBRARY IEEE               ;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL   ;
------------------------------------
USE WORK.basic_package.ALL ;
USE WORK.VGA_package.ALL   ;
-----------------------------------------------------
ENTITY pixel_generate IS
	PORT
	(
		CLK           : IN  UINT01  ;
		SPRITE0_POS_X : IN  UINT11  ;                --POSICION DE ESCANEO DEL PK0
		SPRITE0_POS_Y : IN  UINT11  ;                --POSICION DE ESCANEO DEL PK0
--		SPRITE1_POS_X : IN  UINT11  ;                --POSICION DE ESCANEO DEL PK1
--		SPRITE1_POS_Y : IN  UINT11  ;                --POSICION DE ESCANEO DEL PK1
		POS_X         : IN  UINT11  ;                --POSICION DE ESCANEO DE PANTALLA
		POS_Y         : IN  UINT11  ;                --POSICION DE ESCANEO DE PANTALLA
		PK0_SELECTOR  : IN  UINT04  ;
		PK1_SELECTOR  : IN  UINT04  ;
		POKEMON0_ENA  : IN  UINT01  ;
		POKEMON1_ENA  : IN  UINT01  ;
		VIDEO_ON      : IN  UINT01  ;
		R             : OUT UINT08  ;
		G             : OUT UINT08  ;
		B             : OUT UINT08  
	);
END ENTITY pixel_generate;
-----------------------------------------------------
ARCHITECTURE main OF pixel_generate IS

SIGNAL INT_POS_X                          : INTEGER;
SIGNAL INT_POS_Y                          : INTEGER;

SIGNAL X_REG       , Y_REG                : INTEGER;

SIGNAL LOCAL_X_PK0     , LOCAL_Y_PK0      : INTEGER;
SIGNAL LOCAL_X_PK1     , LOCAL_Y_PK1      : INTEGER;

SIGNAL LOCAL_X_REG_PK0 , LOCAL_Y_REG_PK0  : INTEGER; --UNSIGNED(10 DOWNTO 0)    ;
SIGNAL LOCAL_X_REG_PK1 , LOCAL_Y_REG_PK1  : INTEGER; --UNSIGNED(10 DOWNTO 0)    ;

SIGNAL LOCAL_X_REG2_PK0, LOCAL_Y_REG2_PK0 : INTEGER;
SIGNAL LOCAL_X_REG2_PK1, LOCAL_Y_REG2_PK1 : INTEGER;

SIGNAL LOCAL_X_REG3_PK0, LOCAL_Y_REG3_PK0 : INTEGER;
SIGNAL LOCAL_X_REG3_PK1, LOCAL_Y_REG3_PK1 : INTEGER;

SIGNAL ADDR_INT_PK0, ADDR_INT_PK1         : INTEGER RANGE 0 TO 16383 := 0;

SIGNAL PIXEL_PK0, PIXEL_PK1               : UINT16                       ;

SIGNAL S_POS_X  : INTEGER         ;
SIGNAL S_POS_Y  : INTEGER         ;
CONSTANT PK1_X  : INTEGER := 130  ;    --DEJA ESTOS 2 COMO SEÑALES PARA MAS ADELANTE
CONSTANT PK1_Y  : INTEGER := 0    ;    --PARA MANIPULAR SU POSICION EN EL MOVE_CONT

SIGNAL PK0_VISIBLE, PK1_VISIBLE : UINT01     ;

BEGIN --/////////////////////////////////////////////////////////////////////////////
	
	S_POS_X        <= Slv2Int(SPRITE0_POS_X)      ; --POS DE LEAFEON
	S_POS_Y        <= Slv2Int(SPRITE0_POS_Y)      ; --POS DE LEAFEON
	INT_POS_X      <= Slv2Int(POS_X)             ;
	INT_POS_Y      <= Slv2Int(POS_Y)             ;
	
	PK_SEL : ENTITY WORK.pokemon_sel
	PORT MAP
	(
		CLK       => CLK         ,
		PK0_SEL   => PK0_SELECTOR,
		PK1_SEL   => PK1_SELECTOR,
		ADDR_PK0  => ADDR_INT_PK0,
		ADDR_PK1  => ADDR_INT_PK1,
		PIXEL_PK0 => PIXEL_PK0   ,
		PIXEL_PK1 => PIXEL_PK1
	);
	
	PROCESS(CLK) --process para el pipeline (desface de 1 ciclo de reloj)
	BEGIN
		IF RISING_EDGE(CLK) THEN
			--capa1
			X_REG        <= INT_POS_X           ;
			Y_REG        <= INT_POS_Y           ;
			
			--capa2
			LOCAL_X_PK0      <= X_REG - S_POS_X; --POS DE LEAFEON
			LOCAL_Y_PK0      <= Y_REG - S_POS_Y; --POS DE LEAFEON
			LOCAL_X_PK1      <= X_REG - PK1_X ;
			LOCAL_Y_PK1      <= Y_REG - PK1_Y ;
			
			--capa3
			LOCAL_X_REG_PK0  <= LOCAL_X_PK0   ;
			LOCAL_Y_REG_PK0  <= LOCAL_Y_PK0   ;
			LOCAL_X_REG_PK1  <= LOCAL_X_PK1   ;
			LOCAL_Y_REG_PK1  <= LOCAL_Y_PK1   ;
			
			--capa4
			IF  (LOCAL_X_REG_PK0 >=   0) AND
			    (LOCAL_X_REG_PK0 <  128) AND  --IF DE LEAF
			    (LOCAL_Y_REG_PK0 >=   0) AND
			    (LOCAL_Y_REG_PK0 <  128) THEN
				
				ADDR_INT_PK0 <= LOCAL_Y_REG_PK0 * 128 + LOCAL_X_REG_PK0;
				--(LOCAL_Y_REG_PK0 SLL 7) + LOCAL_X_REG_PK0;
			END IF;
			IF  (LOCAL_X_REG_PK1 >=   0) AND
			    (LOCAL_X_REG_PK1 <  128) AND  --IF DE ZERA
			    (LOCAL_Y_REG_PK1 >=   0) AND
			    (LOCAL_Y_REG_PK1 <  128) THEN
				
				ADDR_INT_PK1 <= LOCAL_Y_REG_PK1 * 128 + LOCAL_X_REG_PK1;
				--(LOCAL_Y_REG_PK1 SLL 7) + LOCAL_X_REG_PK1;
			END IF;
			
			--pinche capa6 DDDDDDDDDDDDDDD'>
			LOCAL_X_REG2_PK0 <= LOCAL_X_REG_PK0;
			LOCAL_Y_REG2_PK0 <= LOCAL_Y_REG_PK0;
			LOCAL_X_REG2_PK1 <= LOCAL_X_REG_PK1;
			LOCAL_Y_REG2_PK1 <= LOCAL_Y_REG_PK1;
			
			--capa7
			
		END IF;
	END PROCESS;
	
	PROCESS(CLK)
	BEGIN
		IF(RISING_EDGE(CLK)) THEN
			R        <= X"00"; --X"30";
			G        <= X"00"; --X"A0";
			B        <= X"00"; --X"30";
			
			IF VIDEO_ON = '1' THEN
				IF (PK0_VISIBLE = '1') THEN
					
					R <= PIXEL_PK0(15 DOWNTO 11) & "000";
					G <= PIXEL_PK0(10 DOWNTO  5) &  "00";
					B <= PIXEL_PK0( 4 DOWNTO  0) & "000";
					
				ELSIF (PK1_VISIBLE = '1') THEN
					
					R <= PIXEL_PK1(15 DOWNTO 11) & "000";
					G <= PIXEL_PK1(10 DOWNTO  5) &  "00";
					B <= PIXEL_PK1( 4 DOWNTO  0) & "000";
					
				END IF;
			END IF;
		END IF;
	END PROCESS;
	
	PK0_VISIBLE <= '1' WHEN
	(
		(LOCAL_X_REG2_PK0 >=   0) AND
		(LOCAL_X_REG2_PK0 <  128) AND
		(LOCAL_Y_REG2_PK0 >=   0) AND
		(LOCAL_Y_REG2_PK0 < 128) AND
		(PIXEL_PK0 /= X"FFFF") AND
		(POKEMON0_ENA       = '1')
	)
	ELSE '0';
	PK1_VISIBLE <= '1' WHEN
	(
		(LOCAL_X_REG2_PK1 >=   0) AND
		(LOCAL_X_REG2_PK1 <  128) AND
		(LOCAL_Y_REG2_PK1 >=   0) AND
		(LOCAL_Y_REG2_PK1 <  128) AND
		(PIXEL_PK1 /=  X"FFFF") AND
		(POKEMON1_ENA        = '1')
	)
	ELSE '0';
END ARCHITECTURE main;

