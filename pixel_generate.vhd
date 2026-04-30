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
		CLK          : IN  UINT01  ;
	--	SCREEN_MAT   : IN  SPRITE_T;
		SPRITE_POS_X : IN  UINT11  ;
		SPRITE_POS_Y : IN  UINT11  ;
		POS_X        : IN  UINT11  ;
		POS_Y        : IN  UINT11  ;
		VIDEO_ON     : IN  UINT01  ;
		R            : OUT UINT08  ;
		G            : OUT UINT08  ;
		B            : OUT UINT08
	);
END ENTITY pixel_generate;
-----------------------------------------------------
ARCHITECTURE main OF pixel_generate IS
SIGNAL INT_POS_X     : INTEGER                      ;
--SIGNAL INT_POS_X_REG : INTEGER                      ;
SIGNAL INT_POS_Y     : INTEGER                      ;
--SIGNAL INT_POS_Y_REG : INTEGER                      ;
SIGNAL ADDR_INT      : INTEGER RANGE 0 TO 16383 := 0;
SIGNAL ADDR_SLV      : UINT14                       ;
SIGNAL PIXEL         : UINT24                       ;
SIGNAL S_POS_X       : INTEGER                      ;
SIGNAL S_POS_Y       : INTEGER                      ;
BEGIN
	
	S_POS_X   <= Slv2Int(SPRITE_POS_X)      ;
	S_POS_Y   <= Slv2Int(SPRITE_POS_Y)      ;
	INT_POS_X <= Slv2Int(POS_X)             ;
	INT_POS_Y <= Slv2Int(POS_Y)             ;
	ADDR_SLV  <= Int2Slv(ADDR_INT, 14)      ;
	ADDR_INT  <= (INT_POS_Y - S_POS_Y) * 128 + (INT_POS_X - S_POS_X);
	
	LEAFEON_ROM : ENTITY WORK.LEAFEON_OB_ROM
	PORT MAP
	(
		address => ADDR_SLV ,
		clock   => CLK  ,
		q       => PIXEL
	);
	
--	PROCESS(CLK)
--	BEGIN
--		IF RISING_EDGE(CLK) THEN
--			INT_POS_X_REG <= INT_POS_X;
--			INT_POS_Y_REG <= INT_POS_Y;
--		END IF;
--	END PROCESS;
	
	PROCESS(VIDEO_ON, INT_POS_X, S_POS_X,INT_POS_Y, S_POS_Y,PIXEL) 
	BEGIN
		R        <= (OTHERS => '0'); --WHITE.R;
		G        <= (OTHERS => '0'); --WHITE.G;
		B        <= X"FF"; --(OTHERS => '0'); --WHITE.B;
	--	ADDR_INT <= 0                         ;
		
		IF VIDEO_ON = '1' THEN
			
			IF (INT_POS_X >= S_POS_X AND INT_POS_X < S_POS_X + 128) AND
			   (INT_POS_Y >= S_POS_Y AND INT_POS_Y < S_POS_Y + 128) THEN
				
				--ADDR_INT <= INT_POS_Y * 128 + INT_POS_X;
				
				R <= PIXEL(23 DOWNTO 16);
				G <= PIXEL(15 DOWNTO  8);
				B <= PIXEL( 7 DOWNTO  0);
				
				--R <= SCREEN_MAT(INT_POS_Y)(INT_POS_X).R;
				--G <= SCREEN_MAT(INT_POS_Y)(INT_POS_X).G;
				--B <= SCREEN_MAT(INT_POS_Y)(INT_POS_X).B;
				
			END IF;
			
		END IF;
	END PROCESS;
	
--	
--	WITH VIDEO_ON SELECT
--	R <= SCREEN_MAT(INT_POS_Y)(INT_POS_X).R WHEN '1'   ,
--		 BLACK.R                    WHEN OTHERS;
--	
--	WITH VIDEO_ON SELECT
--	G <= SCREEN_MAT(INT_POS_Y)(INT_POS_X).G WHEN '1'   ,
--		 BLACK.G                    WHEN OTHERS;
--	
--	WITH VIDEO_ON SELECT
--	B <= SCREEN_MAT(INT_POS_Y)(INT_POS_X).B WHEN '1'   ,
--		 BLACK.B                    WHEN OTHERS;
	
END ARCHITECTURE main;

