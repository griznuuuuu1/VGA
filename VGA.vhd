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
		LEFT_SIG  : IN  UINT01;
		RIGHT_SIG : IN  UINT01;
		UP_SIG    : IN  UINT01;
		DOWN_SIG  : IN  UINT01;
		
		--ENTRADAS DE TEST
		POKE0_SEL : IN  UINT04;
		POKE1_SEL : IN  UINT04;
		
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
SIGNAL VIDEO_ENA    : UINT01  ;
SIGNAL CLK_40MHz    : UINT01  ;
SIGNAL PLL_LOCKED   : UINT01  ;
SIGNAL GLOBAL_RST   : UINT01  ;
SIGNAL S0_POS_X     : UINT11  ;
SIGNAL S0_POS_Y     : UINT11  ;
SIGNAL S1_POS_X     : UINT11  ;
SIGNAL S1_POS_Y     : UINT11  ;
SIGNAL POS_X        : UINT11  ;
SIGNAL POS_Y        : UINT11  ;
BEGIN
	
	MOVE_CONT : ENTITY WORK.move_controller
	PORT MAP
	(
		CLK           => CLK_40MHz ,
		RST           => GLOBAL_RST,
	--	L_SIG         => LEFT_SIG  ,
	--	R_SIG         => RIGHT_SIG ,
		PK0_MOV_CONT  => UP_SIG    ,
		PK1_MOV_CONT  => DOWN_SIG  ,
		SP0_X         => S0_POS_X  ,
		SP0_Y         => S0_POS_Y  ,
		SP1_X         => S1_POS_X  ,
		SP1_Y         => S1_POS_Y  
	);
	
	--S_POS_X <= VARP_X; --Int2Slv(300, 11);
	--S_POS_Y <= VARP_Y; --Int2Slv(200, 11);
	
	
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
		CLK           => CLK_40MHz,
		SPRITE0_POS_X => S0_POS_X ,
		SPRITE0_POS_Y => S0_POS_Y ,
		SPRITE1_POS_X => S1_POS_X ,
		SPRITE1_POS_Y => S1_POS_Y ,
		POS_X         => POS_X    ,
		POS_Y         => POS_Y    ,
		PK0_SELECTOR  => POKE0_SEL,
		PK1_SELECTOR  => POKE1_SEL,
		POKEMON0_ENA  => '1'      ,
		POKEMON1_ENA  => '1'      ,
		VIDEO_ON      => VIDEO_ENA,
		R             => R_VGA    ,
		G             => G_VGA    ,
		B             => B_VGA
	);
	
END ARCHITECTURE call;















