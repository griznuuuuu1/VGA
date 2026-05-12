LIBRARY IEEE               ;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VGA_package.ALL   ; 
-------------------------------------
USE WORK.basic_package.ALL;
------------------------------------------------------
ENTITY move_controller IS
	PORT
	(
		CLK          : IN  UINT01;
		RST          : IN  UINT01;
	--	L_SIG        : IN  UINT01;
	--	R_SIG        : IN  UINT01;
		PK0_MOV_CONT : IN  UINT01;
		PK1_MOV_CONT : IN  UINT01;
		SP0_X        : OUT UINT11;
		SP0_Y        : OUT UINT11;
		SP1_X        : OUT UINT11;
		SP1_Y        : OUT UINT11
	);
END ENTITY move_controller;
------------------------------------------------------
ARCHITECTURE sinchronous OF move_controller IS
CONSTANT I_POS0_X_INT  : INTEGER := 150     ;
CONSTANT I_POS0_Y_INT  : INTEGER := 400     ;
CONSTANT I_POS1_X_INT  : INTEGER := 540     ;
CONSTANT I_POS1_Y_INT  : INTEGER := 230     ;
SIGNAL   I_POS0_X_SLV  : UINT11             ;
SIGNAL   I_POS0_Y_SLV  : UINT11             ;
SIGNAL   I_POS1_X_SLV  : UINT11             ;
SIGNAL   I_POS1_Y_SLV  : UINT11             ;
SIGNAL   POS0_X_RST    : UINT01 := '0'      ;
SIGNAL   POS0_Y_RST    : UINT01 := '0'      ;
SIGNAL   POS1_X_RST    : UINT01 := '0'      ;
SIGNAL   POS1_Y_RST    : UINT01 := '0'      ;
SIGNAL   VARP0_X       : UINT11             ;
SIGNAL   VARP0_Y       : UINT11             ;
SIGNAL   VARP1_X       : UINT11             ;
SIGNAL   VARP1_Y       : UINT11             ;
SIGNAL   LR0_OP        : UINT11             ;
SIGNAL   UD0_OP        : UINT11             ;
SIGNAL   LR1_OP        : UINT11             ;
SIGNAL   UD1_OP        : UINT11             ;
SIGNAL   MV0_X         : UINT02 := "00"     ;
SIGNAL   MV0_Y         : UINT02 := "00"     ;
SIGNAL   MV1_X         : UINT02 := "00"     ;
SIGNAL   MV1_Y         : UINT02 := "00"     ;
SIGNAL   P0_FF_X       : UINT11             ;
SIGNAL   P0_FF_Y       : UINT11             ;
SIGNAL   P1_FF_X       : UINT11             ;
SIGNAL   P1_FF_Y       : UINT11             ;
SIGNAL   ANIM_CONTR0   : UINT01             ;
SIGNAL   ANIM_CONTR1   : UINT01             ;
SIGNAL   R_RATE0       : INTEGER := 0       ;
SIGNAL   R_RATE1       : INTEGER := 0       ;
SIGNAL   REFRESH_FLAG0 : UINT01             ;
SIGNAL   REFRESH_FLAG1 : UINT01             ;
CONSTANT REFRESH_RATE  : INTEGER := 50000000;
CONSTANT H_R_RATE      : INTEGER := 200000 ;
BEGIN
	
	SP0_X <= VARP0_X;
	SP0_Y <= VARP0_Y;
	SP1_X <= VARP1_X;
	SP1_Y <= VARP1_Y;
	
	I_POS0_X_SLV <= Int2Slv(I_POS0_X_INT, 11);
	I_POS0_Y_SLV <= Int2Slv(I_POS0_Y_INT, 11);
	I_POS1_X_SLV <= Int2Slv(I_POS1_X_INT, 11);
	I_POS1_Y_SLV <= Int2Slv(I_POS1_Y_INT, 11);
	
	WITH PK0_MOV_CONT SELECT
		ANIM_CONTR0  <= '0' WHEN '1',
					    '1' WHEN OTHERS;
	WITH PK1_MOV_CONT SELECT
		ANIM_CONTR1  <= '0' WHEN '1',
					    '1' WHEN OTHERS;
	
	PROCESS(CLK)
	BEGIN
		IF RISING_EDGE(CLK) THEN
			CASE ANIM_CONTR0 IS
				WHEN '0'    =>
					R_RATE0 <= REFRESH_RATE;
					POS0_X_RST <= '1'      ;
					CASE (REFRESH_FLAG0 & MV0_Y) IS
						WHEN "000" => NULL;
							
						WHEN "100" =>
							MV0_Y      <=  "01";
							POS0_Y_RST <=   '0';
						WHEN "001" => NULL;
							
						WHEN "101" =>
							MV0_Y      <=  "10";
							POS0_Y_RST <=   '0';
						WHEN "010" => NULL;
							
						WHEN "110" =>
							MV0_Y      <=  "00";
							POS0_Y_RST <=   '0';
						WHEN OTHERS =>
							MV0_Y      <=  "00";
							POS0_Y_RST <=   '0';
					END CASE;
				WHEN OTHERS => 
					R_RATE0 <= H_R_RATE;
					MV0_Y      <= "00";
					POS0_Y_RST <=  '1';
					CASE (REFRESH_FLAG0 & MV0_X) IS
						WHEN "000" => NULL;
						
						WHEN "100" =>
							MV0_X      <= "01";
							POS0_X_RST <=  '0';
						WHEN "001" => NULL;
						
						WHEN "101" =>
							MV0_X      <= "10";
							POS0_X_RST <=  '0';
						WHEN "010" => NULL;
						
						WHEN "110" =>
							MV0_X      <= "00";
							POS0_X_RST <=  '0';
						WHEN OTHERS =>
							MV0_X      <= "00";
							POS0_X_RST <=  '0';
					END CASE;
			END CASE;
			CASE ANIM_CONTR1 IS
				WHEN '0'    =>
					R_RATE1 <= REFRESH_RATE;
					POS1_X_RST <= '1'      ;
					CASE (REFRESH_FLAG1 & MV1_Y) IS
						WHEN "000" => NULL;
							
						WHEN "100" =>
							MV1_Y      <=  "01";
							POS1_Y_RST <=  '0';
						WHEN "001" => NULL;
							
						WHEN "101" =>
							MV1_Y      <=  "10";
							POS1_Y_RST <=  '0';
						WHEN "010" => NULL;
							
						WHEN "110" =>
							MV1_Y      <=  "00";
							POS1_Y_RST <=   '0';
						WHEN OTHERS =>
							MV1_Y      <=  "00";
							POS1_Y_RST <=   '0';
					END CASE;
				WHEN OTHERS =>
					R_RATE1 <= H_R_RATE;
					MV1_Y      <= "00";
					POS1_Y_RST <=  '1';
					CASE (REFRESH_FLAG1 & MV1_X) IS
						WHEN "000" => NULL;
						
						WHEN "100" =>
							MV1_X      <= "01";
							POS1_X_RST <=  '0';
						WHEN "001" => NULL;
						
						WHEN "101" =>
							MV1_X      <= "10";
							POS1_X_RST <=  '0';
						WHEN "010" => NULL;
						
						WHEN "110" =>
							MV1_X      <= "00";
							POS1_X_RST <=  '0';
						WHEN OTHERS =>
							MV1_X      <= "00";
							POS1_X_RST <=  '0';
					END CASE;
			END CASE;
		END IF;
	END PROCESS;
	
	WITH MV0_X SELECT
		LR0_OP <= "00000001010"   WHEN "01"  ,
				  "11111110110"   WHEN "10"  ,
				  (OTHERS => '0') WHEN OTHERS;
	
	WITH MV0_Y SELECT
		UD0_OP <= "00000001010"   WHEN "01"  ,
				  "11111110110"   WHEN "10"  ,
				  (OTHERS => '0') WHEN OTHERS;
	
	WITH MV1_X SELECT
		LR1_OP <= "00000001010"   WHEN "01"  ,
				  "11111110110"   WHEN "10"  ,
				  (OTHERS => '0') WHEN OTHERS;
	
	WITH MV1_Y SELECT
		UD1_OP <= "00000001010"   WHEN "01"  ,
				  "11111110110"   WHEN "10"  ,
				  (OTHERS => '0') WHEN OTHERS;
	
	REFRESH_C0 : ENTITY WORK.contador_uni
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
		max      => Int2Slv(R_RATE0, 22)     ,
		max_tick => REFRESH_FLAG0            ,
		counter  => OPEN
	);
	REFRESH_C1 : ENTITY WORK.contador_uni
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
		max      => Int2Slv(R_RATE1, 22)     ,
		max_tick => REFRESH_FLAG1            ,
		counter  => OPEN
	);
	
	PROCESS(CLK, REFRESH_FLAG0)
	BEGIN
		IF RISING_EDGE(CLK) THEN
			IF (RST = '1') OR (POS0_X_RST = '1') THEN
				VARP0_X <= I_POS0_X_SLV;
			ELSE
				IF REFRESH_FLAG0 = '1' THEN
					VARP0_X     <= P0_FF_X;
				ELSE
					VARP0_X <= VARP0_X;
				END IF;
			END IF;
		END IF;
	END PROCESS;
	
	PROCESS(CLK, REFRESH_FLAG0)
	BEGIN
		IF RISING_EDGE(CLK) THEN
			IF (RST = '1') OR (POS0_Y_RST = '1') THEN
				VARP0_Y <= I_POS0_Y_SLV;
			ELSE
				IF REFRESH_FLAG0 = '1' THEN
					VARP0_Y     <= P0_FF_Y;
				ELSE
					VARP0_Y <= VARP0_Y;
				END IF;
			END IF;
		END IF;
	END PROCESS;
	
	PROCESS(CLK, REFRESH_FLAG1)
	BEGIN
		IF RISING_EDGE(CLK) THEN
			IF (RST = '1') OR (POS1_X_RST = '1') THEN
				VARP1_X <= I_POS1_X_SLV;
			ELSE
				IF REFRESH_FLAG1 = '1' THEN
					VARP1_X     <= P1_FF_X;
				ELSE
					VARP1_X <= VARP1_X;
				END IF;
			END IF;
		END IF;
	END PROCESS;
	
	PROCESS(CLK, REFRESH_FLAG1)
	BEGIN
		IF RISING_EDGE(CLK) THEN
			IF (RST = '1') OR (POS1_Y_RST = '1') THEN
				VARP1_Y <= I_POS1_Y_SLV;
			ELSE
				IF REFRESH_FLAG1 = '1' THEN
					VARP1_Y     <= P1_FF_Y;
				ELSE
					VARP1_Y <= VARP1_Y;
				END IF;
			END IF;
		END IF;
	END PROCESS;

	POS0_X_SUM : ENTITY WORK.bitn_fullAdder
	GENERIC MAP
	(
		B_LENGTH => 11
	)
	PORT MAP
	(
		A    => VARP0_X,
		B    => LR0_OP ,
		Cin  =>'0'     ,
		Cout => OPEN   ,
		S    => P0_FF_X
	);
	
	POS0_Y_SUM : ENTITY WORK.bitn_fullAdder
	GENERIC MAP
	(
		B_LENGTH => 11
	)
	PORT MAP
	(
		A    => VARP0_Y,
		B    => UD0_OP ,
		Cin  => '0'    ,
		Cout => OPEN   ,
		S    => P0_FF_Y
	);
	
	POS1_X_SUM : ENTITY WORK.bitn_fullAdder
	GENERIC MAP
	(
		B_LENGTH => 11
	)
	PORT MAP
	(
		A    => VARP1_X,
		B    => LR1_OP ,
		Cin  =>'0'     ,
		Cout => OPEN   ,
		S    => P1_FF_X
	);
	
	POS1_Y_SUM : ENTITY WORK.bitn_fullAdder
	GENERIC MAP
	(
		B_LENGTH => 11
	)
	PORT MAP
	(
		A    => VARP1_Y,
		B    => UD1_OP ,
		Cin  => '0'    ,
		Cout => OPEN   ,
		S    => P1_FF_Y
	);
END ARCHITECTURE sinchronous;
------------------------------------------------------

























