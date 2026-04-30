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
		--CLK      : IN  UINT01    ;
		SCREEN_MAT : IN  SPRITE_T;
		POS_X      : IN  UINT11  ;
		POS_Y      : IN  UINT11  ;
		VIDEO_ON   : IN  UINT01  ;
		R          : OUT UINT08  ;
		G          : OUT UINT08  ;
		B          : OUT UINT08
	);
END ENTITY pixel_generate;
-----------------------------------------------------
ARCHITECTURE main OF pixel_generate IS
SIGNAL INT_POS_X : INTEGER;
SIGNAL INT_POS_Y : INTEGER;
BEGIN
	PROCESS(VIDEO_ON, INT_POS_X, INT_POS_Y, SCREEN_MAT) 
	BEGIN
		R <= (OTHERS => '0'); --WHITE.R;
		G <= (OTHERS => '0'); --WHITE.G;
		B <= (OTHERS => '0'); --WHITE.B;
		IF VIDEO_ON = '1' THEN
			
			IF (INT_POS_X < 128) AND (INT_POS_Y < 128) THEN
				
				R <= SCREEN_MAT(INT_POS_Y)(INT_POS_X).R;
				G <= SCREEN_MAT(INT_POS_Y)(INT_POS_X).G;
				B <= SCREEN_MAT(INT_POS_Y)(INT_POS_X).B;
				
			END IF;
			
		END IF;
	END PROCESS;
	
	INT_POS_X <= Slv2Int(POS_X);
	INT_POS_Y <= Slv2Int(POS_Y);
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

