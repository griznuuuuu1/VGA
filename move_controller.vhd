LIBRARY IEEE               ;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VGA_package.ALL   ; 
-------------------------------------
USE WORK.basic_package.ALL;
------------------------------------------------------
ENTITY move_controller IS
	GENERIC
	(
		REFRESH_RATE : INTEGER := 500000
	);
	PORT
	(
		CLK    : IN  UINT01;
		RST    : IN  UINT01;
		L_SIG  : IN  UINT01;
		R_SIG  : IN  UINT01;
		U_SIG  : IN  UINT01;
		D_SIG  : IN  UINT01;
		SP_X   : OUT UINT11;
		SP_Y   : OUT UINT11
	);
END ENTITY move_controller;
------------------------------------------------------
ARCHITECTURE sinchronous OF move_controller IS
SIGNAL VARP_X   : UINT11               ;
SIGNAL VARP_Y   : UINT11               ;
SIGNAL LR_OP        : UINT11           ;
SIGNAL UD_OP        : UINT11           ;
SIGNAL MV_X         : UINT02           ;
SIGNAL MV_Y         : UINT02           ;
SIGNAL P_FF_X       : UINT11           ;
SIGNAL P_FF_Y       : UINT11           ;
SIGNAL REFRESH_FLAG : UINT01           ;
BEGIN
	
	SP_X <= VARP_X;
	SP_Y <= VARP_Y;
	
	MV_X <= L_SIG & R_SIG;
	MV_Y <= U_SIG & D_SIG;
	
	WITH MV_X SELECT
		LR_OP <= "00000000001"   WHEN "01"  ,
				 (OTHERS => '1') WHEN "10"  ,
				 (OTHERS => '0') WHEN OTHERS;
	
	WITH MV_Y SELECT
		UD_OP <= "00000000001"   WHEN "01"  ,
				 (OTHERS => '1') WHEN "10"  ,
				 (OTHERS => '0') WHEN OTHERS;
	
	REFRESH_C : ENTITY WORK.contador_uni
	GENERIC MAP
	(
		N => 22
	)
	PORT MAP
	(
		clk      => CLK                      ,
		rst      => RST                      ,
		ena      => '1'                      ,
		syn_clr  => '0'                      ,
		ini      => Int2Slv(0, 22)           ,
		up       => '1'                      ,
		max      => Int2Slv(REFRESH_RATE, 22),
		max_tick => REFRESH_FLAG             ,
		counter  => OPEN
	);
	
	PROCESS(CLK, REFRESH_FLAG)
	BEGIN
		IF RISING_EDGE(CLK) THEN
			IF RST = '1' THEN
				VARP_X <= "00000000000";
			ELSE
				IF REFRESH_FLAG = '1' THEN
					VARP_X     <= P_FF_X;
					--TMP_VARP_X <= P_FF_X;
				ELSE
					VARP_X <= VARP_X;
				END IF;
			END IF;
		END IF;
	END PROCESS;
	
	PROCESS(CLK, REFRESH_FLAG)
	BEGIN
		IF RISING_EDGE(CLK) THEN
			IF RST = '1' THEN
				VARP_Y <= "00000000000";
			ELSE
				IF REFRESH_FLAG = '1' THEN
					VARP_Y     <= P_FF_Y;
					--TMP_VARP_Y <= P_FF_Y;
				ELSE
					VARP_Y <= VARP_Y;
				END IF;
			END IF;
		END IF;
	END PROCESS;
	
--	WITH MV_X SELECT
--		LR_OP <= "00000000001" WHEN "01"  ,
--				 "11111111111" WHEN "10"  ,
--				 "00000000000" WHEN OTHERS;
--	
--	WITH MV_Y SELECT
--		UD_OP <= "00000000001" WHEN "01"  ,
--				 "11111111111" WHEN "10"  ,
--				 "00000000000" WHEN OTHERS;
	
	POS_X_SUM : ENTITY WORK.bitn_fullAdder
	GENERIC MAP
	(
		B_LENGTH => 11
	)
	PORT MAP
	(
		A    => VARP_X,
		B    => LR_OP ,
		Cin  =>'0'    ,
		Cout => OPEN  ,
		S    => P_FF_X
	);
	
	POS_Y_SUM : ENTITY WORK.bitn_fullAdder
	GENERIC MAP
	(
		B_LENGTH => 11
	)
	PORT MAP
	(
		A    => VARP_Y,
		B    => UD_OP ,
		Cin  => '0'   ,
		Cout => OPEN  ,
		S    => P_FF_Y
	);
END ARCHITECTURE sinchronous;
------------------------------------------------------

























