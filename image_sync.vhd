LIBRARY IEEE               ;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL   ;
------------------------------------------
USE WORK.basic_package.ALL ;
USE WORK.VGA_PACKAGE.ALL   ;
-------------------------------------------------------
ENTITY image_sync IS
	PORT
	(
		RESET    : IN  UINT01;
		SYNC_CLK : IN  UINT01;
		H_SYNC   : OUT UINT01;
		V_SYNC   : OUT UINT01;
		VIDEO_ON : OUT UINT01;
		PIXEL_X  : OUT UINT11;
		PIXEL_Y  : OUT UINT11
	);
END ENTITY image_sync;
-------------------------------------------------------
ARCHITECTURE main_arch OF image_sync IS
CONSTANT ZERO : UINT11 := (OTHERS => ('0'));
SIGNAL   V_ENABLE     : UINT01             ;
SIGNAL   H_COUNT      : UINT11             ;
SIGNAL   V_COUNT      : UINT11             ;
SIGNAL   VIDEO_V_ON   : UINT01             ;
SIGNAL   VIDEO_H_ON   : UINT01             ;
SIGNAL   TMP_VIDEO_ON : UINT01             ;
SIGNAL   TMP_H_S1     : UINT01             ;
SIGNAL   TMP_H_S2     : UINT01             ;
SIGNAL   TMP_V_S1     : UINT01             ;
SIGNAL   TMP_V_S2     : UINT01             ;
BEGIN
	
	TMP_VIDEO_ON <= VIDEO_V_ON AND VIDEO_H_ON;
	VIDEO_ON     <= TMP_VIDEO_ON           ;
	
	VIDEO_H_ON   <= '1' WHEN (UNSIGNED(H_COUNT) <= UNSIGNED(H_TIME.DISPLAY)) ELSE '0';
	VIDEO_V_ON   <= '1' WHEN (UNSIGNED(V_COUNT) <= UNSIGNED(V_TIME.DISPLAY)) ELSE '0';
	
	------------------------------------------
	
	WITH TMP_VIDEO_ON SELECT
		PIXEL_X <= H_COUNT WHEN '1',
				   ZERO    WHEN OTHERS;
	
	WITH TMP_VIDEO_ON SELECT
		PIXEL_Y <= V_COUNT WHEN '1',
				   ZERO    WHEN OTHERS;
	
	------------------------------------------
	
	TMP_H_S1 <= '1' WHEN (UNSIGNED(H_COUNT) <= UNSIGNED(H_TIME.FRONT_PORCH)) ELSE '0';
	TMP_H_S2 <= '1' WHEN (UNSIGNED(H_COUNT) >  UNSIGNED(H_TIME.RETRACE    )) ELSE '0';
	
	TMP_V_S1 <= '1' WHEN (UNSIGNED(V_COUNT) <= UNSIGNED(V_TIME.FRONT_PORCH)) ELSE '0';
	TMP_V_S2 <= '1' WHEN (UNSIGNED(V_COUNT) >  UNSIGNED(V_TIME.RETRACE    )) ELSE '0';
	
	H_SYNC   <= TMP_H_S1 OR TMP_H_S2;
	V_SYNC   <= TMP_V_S1 OR TMP_V_S2;
	
	------------------------------------------
	
	H_COUNTER : ENTITY WORK.contador_uni
	GENERIC MAP
	(
		N => 11
	)
	PORT MAP
	(
		clk      => SYNC_CLK        ,
		rst      => RESET           ,
		ena      => '1'             ,
		syn_clr  => '0'             ,
		ini      => "00000000000"   ,
		up       => '1'             ,
		max      => H_TIME.FULL_SCAN,
		max_tick => V_ENABLE        ,
		counter  => H_COUNT
	);
	
	V_COUNTER : ENTITY WORK.contador_uni
	GENERIC MAP
	(
		N => 11
	)
	PORT MAP
	(
		clk      => SYNC_CLK        ,
		rst      => RESET           ,
		ena      => V_ENABLE        ,
		syn_clr  => '0'             ,
		ini      => "00000000000"   ,
		up       => '1'             ,
		max      => V_TIME.FULL_SCAN,
		max_tick => OPEN            ,
		counter  => V_COUNT
	);
	
END ARCHITECTURE main_arch;
