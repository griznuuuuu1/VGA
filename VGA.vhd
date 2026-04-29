LIBRARY IEEE               ;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL   ;
-----------------------------------
LIBRARY PLL_40MHz          ;
USE PLL_40MHz.ALL          ;
USE WORK.basic_package.ALL ;
USE WORK.VGA_package.ALL   ;
-----------------------------------------------------
ENTITY VGA IS
	PORT
	(
		CLK       : IN  UINT01;
		VGA_RST   : IN  UINT01;
		VGA_CLK   : OUT UINT01;
		R_VGA     : OUT UINT08;
		G_VGA     : OUT UINT08;
		B_VGA     : OUT UINT08;
		VGA_HS    : OUT UINT01;
		VGA_VS    : OUT UINT01
	);
END ENTITY VGA;
-----------------------------------------------------
ARCHITECTURE call OF VGA IS
SIGNAL VIDEO_ENA  : UINT01  ;
SIGNAL CLK_40MHz  : UINT01  ;
SIGNAL PLL_LOCKED : UINT01  ;
SIGNAL GLOBAL_RST : UINT01  ;
SIGNAL SCREEN     : SCREEN_T;
SIGNAL POS_X      : UINT11  ;
SIGNAL POS_Y      : UINT11  ;
BEGIN
	
	PROCESS(VIDEO_ENA, POS_X, POS_Y)
	VARIABLE TEMP_X : INTEGER;
	VARIABLE TEMP_Y : INTEGER;
	BEGIN
		TEMP_X := Slv2Int(POS_X);
		TEMP_Y := Slv2Int(POS_Y);
		IF VIDEO_ENA = '1' THEN
			IF (Slv2Int(POS_X)) < 200 THEN
				SCREEN(TEMP_Y)(TEMP_X).R <= X"FF";
				SCREEN(TEMP_Y)(TEMP_X).G <= X"00"; 
				SCREEN(TEMP_Y)(TEMP_X).B <= X"00";
			ELSIF (Slv2Int(POS_X)) < 400 THEN
				SCREEN(TEMP_Y)(TEMP_X).R <= X"00";
				SCREEN(TEMP_Y)(TEMP_X).G <= X"FF";
				SCREEN(TEMP_Y)(TEMP_X).B <= X"00";
			ELSIF (Slv2Int(POS_X)) < 600 THEN
				SCREEN(TEMP_Y)(TEMP_X).R <= X"00";
				SCREEN(TEMP_Y)(TEMP_X).G <= X"00";
				SCREEN(TEMP_Y)(TEMP_X).B <= X"FF";
			ELSE
				SCREEN(TEMP_Y)(TEMP_X).R <= X"FF";
				SCREEN(TEMP_Y)(TEMP_X).G <= X"FF";
				SCREEN(TEMP_Y)(TEMP_X).B <= X"FF";
			END IF;
		END IF;
	END PROCESS;
	
	VGA_CLK    <= CLK_40MHz            ;
	GLOBAL_RST <= (NOT PLL_LOCKED) OR VGA_RST;
	
	CLOCK_BLOCK : ENTITY PLL_40MHz.PLL_40MHz
	PORT MAP
	(
		refclk   => CLK       ,
		rst      => VGA_RST   ,
		outclk_0 => CLK_40MHz ,
		locked   => PLL_LOCKED
	);
	
	SYNC_BLOCK : ENTITY WORK.image_sync
	PORT MAP
	(
		RESET    => GLOBAL_RST,
		SYNC_CLK => CLK_40MHz ,
		H_SYNC   => VGA_HS    ,
		V_SYNC   => VGA_VS    ,
		VIDEO_ON => VIDEO_ENA ,
		PIXEL_X  => POS_X     ,
		PIXEL_Y  => POS_Y
	);
	
	COLOR_BLOCK : ENTITY WORK.pixel_generate
	PORT MAP
	(
		SCREEN_MAT => SCREEN   ,
		POS_X      => POS_X    ,
		POS_Y      => POS_Y    ,
		VIDEO_ON   => VIDEO_ENA,
		R          => R_VGA    ,
		G          => G_VGA    ,
		B          => B_VGA
	);
	
END ARCHITECTURE call;















