LIBRARY IEEE               ;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL   ;
------------------------------------
USE WORK.basic_package.ALL ;
USE WORK.VGA_package.ALL   ;
-----------------------------------------------------
ENTITY pokemon_sel IS
	PORT
	(
		CLK       : IN  UINT01;
		PK0_SEL   : IN  UINT04;
		PK1_SEL   : IN  UINT04;
		ADDR_PK0  : IN  INT04K; 
		ADDR_PK1  : IN  INT04K;
		PIXEL_PK0 : OUT UINT16;
		PIXEL_PK1 : OUT UINT16
	);
END ENTITY pokemon_sel;
-----------------------------------------------------
ARCHITECTURE main OF pokemon_sel IS

SIGNAL ADDR_SLV_PK0   : UINT12 := NO_ADDR;
SIGNAL ADDR_SLV_PK1   : UINT12 := NO_ADDR;
SIGNAL ADDR_SLV_LEAF0 : UINT12 := NO_ADDR;
SIGNAL ADDR_SLV_LEAF1 : UINT12 := NO_ADDR;
SIGNAL ADDR_SLV_ZERA0 : UINT12 := NO_ADDR;
SIGNAL ADDR_SLV_ZERA1 : UINT12 := NO_ADDR;
SIGNAL ADDR_SLV_VAPO0 : UINT12 := NO_ADDR;
SIGNAL ADDR_SLV_VAPO1 : UINT12 := NO_ADDR;
SIGNAL ADDR_SLV_SAND0 : UINT12 := NO_ADDR;
SIGNAL ADDR_SLV_SAND1 : UINT12 := NO_ADDR;
SIGNAL ADDR_SLV_ODDI0 : UINT12 := NO_ADDR;
SIGNAL ADDR_SLV_ODDI1 : UINT12 := NO_ADDR;
SIGNAL ADDR_SLV_LAPR0 : UINT12 := NO_ADDR;
SIGNAL ADDR_SLV_LAPR1 : UINT12 := NO_ADDR;
SIGNAL ADDR_SLV_JOLT0 : UINT12 := NO_ADDR;
SIGNAL ADDR_SLV_JOLT1 : UINT12 := NO_ADDR;
SIGNAL ADDR_SLV_GARC0 : UINT12 := NO_ADDR;
SIGNAL ADDR_SLV_GARC1 : UINT12 := NO_ADDR;
SIGNAL ADDR_SLV_FLAR0 : UINT12 := NO_ADDR;
SIGNAL ADDR_SLV_FLAR1 : UINT12 := NO_ADDR;
SIGNAL ADDR_SLV_CHAR0 : UINT12 := NO_ADDR;
SIGNAL ADDR_SLV_CHAR1 : UINT12 := NO_ADDR;
SIGNAL ADDR_SLV_RAND0 : UINT12 := NO_ADDR;
SIGNAL ADDR_SLV_RAND1 : UINT12 := NO_ADDR;

SIGNAL PX_LEAF0       : UINT16;
SIGNAL PX_LEAF1       : UINT16;
SIGNAL PX_ZERA0       : UINT16;
SIGNAL PX_ZERA1       : UINT16;
SIGNAL PX_VAPO0       : UINT16;
SIGNAL PX_VAPO1       : UINT16;
SIGNAL PX_SAND0       : UINT16;
SIGNAL PX_SAND1       : UINT16;
SIGNAL PX_ODDI0       : UINT16;
SIGNAL PX_ODDI1       : UINT16;
SIGNAL PX_LAPR0       : UINT16;
SIGNAL PX_LAPR1       : UINT16;
SIGNAL PX_JOLT0       : UINT16;
SIGNAL PX_JOLT1       : UINT16;
SIGNAL PX_GARC0       : UINT16;
SIGNAL PX_GARC1       : UINT16;
SIGNAL PX_FLAR0       : UINT16;
SIGNAL PX_FLAR1       : UINT16;
SIGNAL PX_CHAR0       : UINT16;
SIGNAL PX_CHAR1       : UINT16;
SIGNAL PX_RAND0       : UINT16;
SIGNAL PX_RAND1       : UINT16;

BEGIN --///////////////////////////////////////////////////////////////
	
	ADDR_SLV_PK0  <= Int2Slv(ADDR_PK0, 12) ;
	ADDR_SLV_PK1  <= Int2Slv(ADDR_PK1, 12) ;
	
	PROCESS
	(
		PK0_SEL     , PK1_SEL     ,
		ADDR_SLV_PK0, ADDR_SLV_PK1,
		PX_LEAF0    , PX_LEAF1    ,
		PX_ZERA0    , PX_ZERA1    ,
		PX_VAPO0    , PX_VAPO1    ,
		PX_SAND0    , PX_SAND1    ,
		PX_ODDI0    , PX_ODDI1    ,
		PX_LAPR0    , PX_LAPR1    ,
		PX_JOLT0    , PX_JOLT1    ,
		PX_GARC0    , PX_GARC1    ,
		PX_FLAR0    , PX_FLAR1    ,
		PX_CHAR0    , PX_CHAR1    ,
		PX_RAND0    , PX_RAND1
	)
	BEGIN
		CASE PK0_SEL IS                                  --POKEMON 0 SEL
			WHEN "0000" =>                 --LEAFEON
				
				ADDR_SLV_LEAF0 <= ADDR_SLV_PK0;
				ADDR_SLV_ZERA0 <= NO_ADDR     ;
				ADDR_SLV_VAPO0 <= NO_ADDR     ;
				ADDR_SLV_SAND0 <= NO_ADDR     ;
				ADDR_SLV_ODDI0 <= NO_ADDR     ;
				ADDR_SLV_LAPR0 <= NO_ADDR     ;
				ADDR_SLV_JOLT0 <= NO_ADDR     ;
				ADDR_SLV_GARC0 <= NO_ADDR     ;
				ADDR_SLV_FLAR0 <= NO_ADDR     ;
				ADDR_SLV_CHAR0 <= NO_ADDR     ;
				ADDR_SLV_RAND0 <= NO_ADDR     ;
				PIXEL_PK0      <= PX_LEAF0    ;
				
			WHEN "0001" =>                 --ZERARORA
				
				ADDR_SLV_LEAF0 <= NO_ADDR     ;
				ADDR_SLV_ZERA0 <= ADDR_SLV_PK0;
				ADDR_SLV_VAPO0 <= NO_ADDR     ;
				ADDR_SLV_SAND0 <= NO_ADDR     ;
				ADDR_SLV_ODDI0 <= NO_ADDR     ;
				ADDR_SLV_LAPR0 <= NO_ADDR     ;
				ADDR_SLV_JOLT0 <= NO_ADDR     ;
				ADDR_SLV_GARC0 <= NO_ADDR     ;
				ADDR_SLV_FLAR0 <= NO_ADDR     ;
				ADDR_SLV_CHAR0 <= NO_ADDR     ;
				ADDR_SLV_RAND0 <= NO_ADDR     ;
				PIXEL_PK0      <= PX_ZERA0    ;
				
			WHEN "0010" =>                 --VAPOREON
				
				ADDR_SLV_LEAF0 <= NO_ADDR     ;
				ADDR_SLV_ZERA0 <= NO_ADDR     ;
				ADDR_SLV_VAPO0 <= ADDR_SLV_PK0;
				ADDR_SLV_SAND0 <= NO_ADDR     ;
				ADDR_SLV_ODDI0 <= NO_ADDR     ;
				ADDR_SLV_LAPR0 <= NO_ADDR     ;
				ADDR_SLV_JOLT0 <= NO_ADDR     ;
				ADDR_SLV_GARC0 <= NO_ADDR     ;
				ADDR_SLV_FLAR0 <= NO_ADDR     ;
				ADDR_SLV_CHAR0 <= NO_ADDR     ;
				ADDR_SLV_RAND0 <= NO_ADDR     ;
				PIXEL_PK0      <= PX_VAPO0    ;
				
			WHEN "0011" =>                 --SANDSLASH
				
				ADDR_SLV_LEAF0 <= NO_ADDR     ;
				ADDR_SLV_ZERA0 <= NO_ADDR     ;
				ADDR_SLV_VAPO0 <= NO_ADDR     ;
				ADDR_SLV_SAND0 <= ADDR_SLV_PK0;
				ADDR_SLV_ODDI0 <= NO_ADDR     ;
				ADDR_SLV_LAPR0 <= NO_ADDR     ;
				ADDR_SLV_JOLT0 <= NO_ADDR     ;
				ADDR_SLV_GARC0 <= NO_ADDR     ;
				ADDR_SLV_FLAR0 <= NO_ADDR     ;
				ADDR_SLV_CHAR0 <= NO_ADDR     ;
				ADDR_SLV_RAND0 <= NO_ADDR     ;
				PIXEL_PK0      <= PX_SAND0    ;
				
			WHEN "0100" =>                 --ODDISH
				
				ADDR_SLV_LEAF0 <= NO_ADDR     ;
				ADDR_SLV_ZERA0 <= NO_ADDR     ;
				ADDR_SLV_VAPO0 <= NO_ADDR     ;
				ADDR_SLV_SAND0 <= NO_ADDR     ;
				ADDR_SLV_ODDI0 <= ADDR_SLV_PK0;
				ADDR_SLV_LAPR0 <= NO_ADDR     ;
				ADDR_SLV_JOLT0 <= NO_ADDR     ;
				ADDR_SLV_GARC0 <= NO_ADDR     ;
				ADDR_SLV_FLAR0 <= NO_ADDR     ;
				ADDR_SLV_CHAR0 <= NO_ADDR     ;
				ADDR_SLV_RAND0 <= NO_ADDR     ;
				PIXEL_PK0      <= PX_ODDI0    ;
				
			WHEN "0101" =>                 --LAPRAS
				
				ADDR_SLV_LEAF0 <= NO_ADDR     ;
				ADDR_SLV_ZERA0 <= NO_ADDR     ;
				ADDR_SLV_VAPO0 <= NO_ADDR     ;
				ADDR_SLV_SAND0 <= NO_ADDR     ;
				ADDR_SLV_ODDI0 <= NO_ADDR     ;
				ADDR_SLV_LAPR0 <= ADDR_SLV_PK0;
				ADDR_SLV_JOLT0 <= NO_ADDR     ;
				ADDR_SLV_GARC0 <= NO_ADDR     ;
				ADDR_SLV_FLAR0 <= NO_ADDR     ;
				ADDR_SLV_CHAR0 <= NO_ADDR     ;
				ADDR_SLV_RAND0 <= NO_ADDR     ;
				PIXEL_PK0      <= PX_LAPR0    ;
				
			WHEN "0110" =>                 --JOLTEON
				
				ADDR_SLV_LEAF0 <= NO_ADDR     ;
				ADDR_SLV_ZERA0 <= NO_ADDR     ;
				ADDR_SLV_VAPO0 <= NO_ADDR     ;
				ADDR_SLV_SAND0 <= NO_ADDR     ;
				ADDR_SLV_ODDI0 <= NO_ADDR     ;
				ADDR_SLV_LAPR0 <= NO_ADDR     ;
				ADDR_SLV_JOLT0 <= ADDR_SLV_PK0;
				ADDR_SLV_GARC0 <= NO_ADDR     ;
				ADDR_SLV_FLAR0 <= NO_ADDR     ;
				ADDR_SLV_CHAR0 <= NO_ADDR     ;
				ADDR_SLV_RAND0 <= NO_ADDR     ;
				PIXEL_PK0      <= PX_JOLT0    ;
				
			WHEN "0111" =>                 --GARCHOMP
				
				ADDR_SLV_LEAF0 <= NO_ADDR     ;
				ADDR_SLV_ZERA0 <= NO_ADDR     ;
				ADDR_SLV_VAPO0 <= NO_ADDR     ;
				ADDR_SLV_SAND0 <= NO_ADDR     ;
				ADDR_SLV_ODDI0 <= NO_ADDR     ;
				ADDR_SLV_LAPR0 <= NO_ADDR     ;
				ADDR_SLV_JOLT0 <= NO_ADDR     ;
				ADDR_SLV_GARC0 <= ADDR_SLV_PK0;
				ADDR_SLV_FLAR0 <= NO_ADDR     ;
				ADDR_SLV_CHAR0 <= NO_ADDR     ;
				ADDR_SLV_RAND0 <= NO_ADDR     ;
				PIXEL_PK0      <= PX_GARC0    ;
				
			WHEN "1000" =>                 --FLAREON
				
				ADDR_SLV_LEAF0 <= NO_ADDR     ;
				ADDR_SLV_ZERA0 <= NO_ADDR     ;
				ADDR_SLV_VAPO0 <= NO_ADDR     ;
				ADDR_SLV_SAND0 <= NO_ADDR     ;
				ADDR_SLV_ODDI0 <= NO_ADDR     ;
				ADDR_SLV_LAPR0 <= NO_ADDR     ;
				ADDR_SLV_JOLT0 <= NO_ADDR     ;
				ADDR_SLV_GARC0 <= NO_ADDR     ;
				ADDR_SLV_FLAR0 <= ADDR_SLV_PK0;
				ADDR_SLV_CHAR0 <= NO_ADDR     ;
				ADDR_SLV_RAND0 <= NO_ADDR     ;
				PIXEL_PK0      <= PX_FLAR0    ;
				
			WHEN "1001" =>                 --CHARIZARD
				
				ADDR_SLV_LEAF0 <= NO_ADDR     ;
				ADDR_SLV_ZERA0 <= NO_ADDR     ;
				ADDR_SLV_VAPO0 <= NO_ADDR     ;
				ADDR_SLV_SAND0 <= NO_ADDR     ;
				ADDR_SLV_ODDI0 <= NO_ADDR     ;
				ADDR_SLV_LAPR0 <= NO_ADDR     ;
				ADDR_SLV_JOLT0 <= NO_ADDR     ;
				ADDR_SLV_GARC0 <= NO_ADDR     ;
				ADDR_SLV_FLAR0 <= NO_ADDR     ;
				ADDR_SLV_CHAR0 <= ADDR_SLV_PK0;
				ADDR_SLV_RAND0 <= NO_ADDR     ;
				PIXEL_PK0      <= PX_CHAR0    ;
				
			WHEN OTHERS =>                 --UNKNOWN PK
				
				ADDR_SLV_LEAF0 <= NO_ADDR     ;
				ADDR_SLV_ZERA0 <= NO_ADDR     ;
				ADDR_SLV_VAPO0 <= NO_ADDR     ;
				ADDR_SLV_SAND0 <= NO_ADDR     ;
				ADDR_SLV_ODDI0 <= NO_ADDR     ;
				ADDR_SLV_LAPR0 <= NO_ADDR     ;
				ADDR_SLV_JOLT0 <= NO_ADDR     ;
				ADDR_SLV_GARC0 <= NO_ADDR     ;
				ADDR_SLV_FLAR0 <= NO_ADDR     ;
				ADDR_SLV_CHAR0 <= NO_ADDR     ;
				ADDR_SLV_RAND0 <= ADDR_SLV_PK0;
				PIXEL_PK0      <= PX_RAND0    ;
				
		END CASE;
		CASE PK1_SEL IS                                  --POKEMON 1 SEL
			WHEN "0000" =>                 --LEAFEON
				
				ADDR_SLV_LEAF1 <= ADDR_SLV_PK1;
				ADDR_SLV_ZERA1 <= NO_ADDR     ;
				ADDR_SLV_VAPO1 <= NO_ADDR     ;
				ADDR_SLV_SAND1 <= NO_ADDR     ;
				ADDR_SLV_ODDI1 <= NO_ADDR     ;
				ADDR_SLV_LAPR1 <= NO_ADDR     ;
				ADDR_SLV_JOLT1 <= NO_ADDR     ;
				ADDR_SLV_GARC1 <= NO_ADDR     ;
				ADDR_SLV_FLAR1 <= NO_ADDR     ;
				ADDR_SLV_CHAR1 <= NO_ADDR     ;
				ADDR_SLV_RAND1 <= NO_ADDR     ;
				PIXEL_PK1      <= PX_LEAF1    ;
				
			WHEN "0001" =>                 --ZERARORA
				
				ADDR_SLV_LEAF1 <= NO_ADDR     ;
				ADDR_SLV_ZERA1 <= ADDR_SLV_PK1;
				ADDR_SLV_VAPO1 <= NO_ADDR     ;
				ADDR_SLV_SAND1 <= NO_ADDR     ;
				ADDR_SLV_ODDI1 <= NO_ADDR     ;
				ADDR_SLV_LAPR1 <= NO_ADDR     ;
				ADDR_SLV_JOLT1 <= NO_ADDR     ;
				ADDR_SLV_GARC1 <= NO_ADDR     ;
				ADDR_SLV_FLAR1 <= NO_ADDR     ;
				ADDR_SLV_CHAR1 <= NO_ADDR     ;
				ADDR_SLV_RAND1 <= NO_ADDR     ;
				PIXEL_PK1      <= PX_ZERA1    ;
				
			WHEN "0010" =>                 --VAPOREON
				
				ADDR_SLV_LEAF1 <= NO_ADDR     ;
				ADDR_SLV_ZERA1 <= NO_ADDR     ;
				ADDR_SLV_VAPO1 <= ADDR_SLV_PK1;
				ADDR_SLV_SAND1 <= NO_ADDR     ;
				ADDR_SLV_ODDI1 <= NO_ADDR     ;
				ADDR_SLV_LAPR1 <= NO_ADDR     ;
				ADDR_SLV_JOLT1 <= NO_ADDR     ;
				ADDR_SLV_GARC1 <= NO_ADDR     ;
				ADDR_SLV_FLAR1 <= NO_ADDR     ;
				ADDR_SLV_CHAR1 <= NO_ADDR     ;
				ADDR_SLV_RAND1 <= NO_ADDR     ;
				PIXEL_PK1      <= PX_VAPO1    ;
				
			WHEN "0011" =>                 --SANDSLASH
				
				ADDR_SLV_LEAF1 <= NO_ADDR     ;
				ADDR_SLV_ZERA1 <= NO_ADDR     ;
				ADDR_SLV_VAPO1 <= NO_ADDR     ;
				ADDR_SLV_SAND1 <= ADDR_SLV_PK1;
				ADDR_SLV_ODDI1 <= NO_ADDR     ;
				ADDR_SLV_LAPR1 <= NO_ADDR     ;
				ADDR_SLV_JOLT1 <= NO_ADDR     ;
				ADDR_SLV_GARC1 <= NO_ADDR     ;
				ADDR_SLV_FLAR1 <= NO_ADDR     ;
				ADDR_SLV_CHAR1 <= NO_ADDR     ;
				ADDR_SLV_RAND1 <= NO_ADDR     ;
				PIXEL_PK1      <= PX_SAND1    ;
				
			WHEN "0100" =>                 --ODDISH
				
				ADDR_SLV_LEAF1 <= NO_ADDR     ;
				ADDR_SLV_ZERA1 <= NO_ADDR     ;
				ADDR_SLV_VAPO1 <= NO_ADDR     ;
				ADDR_SLV_SAND1 <= NO_ADDR     ;
				ADDR_SLV_ODDI1 <= ADDR_SLV_PK1;
				ADDR_SLV_LAPR1 <= NO_ADDR     ;
				ADDR_SLV_JOLT1 <= NO_ADDR     ;
				ADDR_SLV_GARC1 <= NO_ADDR     ;
				ADDR_SLV_FLAR1 <= NO_ADDR     ;
				ADDR_SLV_CHAR1 <= NO_ADDR     ;
				ADDR_SLV_RAND1 <= NO_ADDR     ;
				PIXEL_PK1      <= PX_ODDI1    ;
				
			WHEN "0101" =>                 --LAPRAS
				
				ADDR_SLV_LEAF1 <= NO_ADDR     ;
				ADDR_SLV_ZERA1 <= NO_ADDR     ;
				ADDR_SLV_VAPO1 <= NO_ADDR     ;
				ADDR_SLV_SAND1 <= NO_ADDR     ;
				ADDR_SLV_ODDI1 <= NO_ADDR     ;
				ADDR_SLV_LAPR1 <= ADDR_SLV_PK1;
				ADDR_SLV_JOLT1 <= NO_ADDR     ;
				ADDR_SLV_GARC1 <= NO_ADDR     ;
				ADDR_SLV_FLAR1 <= NO_ADDR     ;
				ADDR_SLV_CHAR1 <= NO_ADDR     ;
				ADDR_SLV_RAND1 <= NO_ADDR     ;
				PIXEL_PK1      <= PX_LAPR1    ;
				
			WHEN "0110" =>                 --JOLTEON
				
				ADDR_SLV_LEAF1 <= NO_ADDR     ;
				ADDR_SLV_ZERA1 <= NO_ADDR     ;
				ADDR_SLV_VAPO1 <= NO_ADDR     ;
				ADDR_SLV_SAND1 <= NO_ADDR     ;
				ADDR_SLV_ODDI1 <= NO_ADDR     ;
				ADDR_SLV_LAPR1 <= NO_ADDR     ;
				ADDR_SLV_JOLT1 <= ADDR_SLV_PK1;
				ADDR_SLV_GARC1 <= NO_ADDR     ;
				ADDR_SLV_FLAR1 <= NO_ADDR     ;
				ADDR_SLV_CHAR1 <= NO_ADDR     ;
				ADDR_SLV_RAND1 <= NO_ADDR     ;
				PIXEL_PK1      <= PX_JOLT1    ;
				
			WHEN "0111" =>                 --GARCHOMP
				
				ADDR_SLV_LEAF1 <= NO_ADDR     ;
				ADDR_SLV_ZERA1 <= NO_ADDR     ;
				ADDR_SLV_VAPO1 <= NO_ADDR     ;
				ADDR_SLV_SAND1 <= NO_ADDR     ;
				ADDR_SLV_ODDI1 <= NO_ADDR     ;
				ADDR_SLV_LAPR1 <= NO_ADDR     ;
				ADDR_SLV_JOLT1 <= NO_ADDR     ;
				ADDR_SLV_GARC1 <= ADDR_SLV_PK1;
				ADDR_SLV_FLAR1 <= NO_ADDR     ;
				ADDR_SLV_CHAR1 <= NO_ADDR     ;
				ADDR_SLV_RAND1 <= NO_ADDR     ;
				PIXEL_PK1      <= PX_GARC1    ;
				
			WHEN "1000" =>                 --FLAREON
				
				ADDR_SLV_LEAF1 <= NO_ADDR     ;
				ADDR_SLV_ZERA1 <= NO_ADDR     ;
				ADDR_SLV_VAPO1 <= NO_ADDR     ;
				ADDR_SLV_SAND1 <= NO_ADDR     ;
				ADDR_SLV_ODDI1 <= NO_ADDR     ;
				ADDR_SLV_LAPR1 <= NO_ADDR     ;
				ADDR_SLV_JOLT1 <= NO_ADDR     ;
				ADDR_SLV_GARC1 <= NO_ADDR     ;
				ADDR_SLV_FLAR1 <= ADDR_SLV_PK1;
				ADDR_SLV_CHAR1 <= NO_ADDR     ;
				ADDR_SLV_RAND1 <= NO_ADDR     ;
				PIXEL_PK1      <= PX_FLAR1    ;
				
			WHEN "1001" =>                 --CHARIZARD
				
				ADDR_SLV_LEAF1 <= NO_ADDR     ;
				ADDR_SLV_ZERA1 <= NO_ADDR     ;
				ADDR_SLV_VAPO1 <= NO_ADDR     ;
				ADDR_SLV_SAND1 <= NO_ADDR     ;
				ADDR_SLV_ODDI1 <= NO_ADDR     ;
				ADDR_SLV_LAPR1 <= NO_ADDR     ;
				ADDR_SLV_JOLT1 <= NO_ADDR     ;
				ADDR_SLV_GARC1 <= NO_ADDR     ;
				ADDR_SLV_FLAR1 <= NO_ADDR     ;
				ADDR_SLV_CHAR1 <= ADDR_SLV_PK1;
				ADDR_SLV_RAND1 <= NO_ADDR     ;
				PIXEL_PK1      <= PX_CHAR1    ;
				
			WHEN OTHERS =>                 --UNKNOWN PK
				
				ADDR_SLV_LEAF1 <= NO_ADDR     ;
				ADDR_SLV_ZERA1 <= NO_ADDR     ;
				ADDR_SLV_VAPO1 <= NO_ADDR     ;
				ADDR_SLV_SAND1 <= NO_ADDR     ;
				ADDR_SLV_ODDI1 <= NO_ADDR     ;
				ADDR_SLV_LAPR1 <= NO_ADDR     ;
				ADDR_SLV_JOLT1 <= NO_ADDR     ;
				ADDR_SLV_GARC1 <= NO_ADDR     ;
				ADDR_SLV_FLAR1 <= NO_ADDR     ;
				ADDR_SLV_CHAR1 <= NO_ADDR     ;
				ADDR_SLV_RAND1 <= ADDR_SLV_PK1;
				PIXEL_PK1      <= PX_RAND1    ;
		END CASE;
	END PROCESS;
	
	--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	
	LEAFEON_SP : ENTITY WORK.LEAFEON_ROM --0 "0000"
	PORT MAP
	(
		address_a => ADDR_SLV_LEAF0 ,
		address_b => ADDR_SLV_LEAF1 ,
		clock     => CLK            ,
		q_a       => PX_LEAF0       ,
		q_b       => PX_LEAF1
	);
	ZERAORA_SP : ENTITY WORK.ZERAORA_ROM --1 "0001"
	PORT MAP
	(
		address_a => ADDR_SLV_ZERA0,
		address_b => ADDR_SLV_ZERA1,
		clock     => CLK           ,
		q_a       => PX_ZERA0      ,
		q_b       => PX_ZERA1
	);
	VAPOREON_SP : ENTITY WORK.VAPOREON_ROM --2 "0010"
	PORT MAP
	(
		address_a => ADDR_SLV_VAPO0,
		address_b => ADDR_SLV_VAPO1,
		clock     => CLK           ,
		q_a       => PX_VAPO0      ,
		q_b       => PX_VAPO1
	);
	SANDSLASH_SP : ENTITY WORK.SANDSLASH_ROM --3 "0011"
	PORT MAP
	(
		address_a => ADDR_SLV_SAND0,
		address_b => ADDR_SLV_SAND1,
		clock     => CLK           ,
		q_a       => PX_SAND0      ,
		q_b       => PX_SAND1
	);
	ODDISH_SP : ENTITY WORK.ODDISH_ROM --4 "0100"
	PORT MAP
	(
		address_a => ADDR_SLV_ODDI0,
		address_b => ADDR_SLV_ODDI1,
		clock     => CLK           ,
		q_a       => PX_ODDI0      ,
		q_b       => PX_ODDI1
	);
	LAPRAS_SP : ENTITY WORK.LAPRAS_ROM --5 "0101"
	PORT MAP
	(
		address_a => ADDR_SLV_LAPR0,
		address_b => ADDR_SLV_LAPR1,
		clock     => CLK           ,
		q_a       => PX_LAPR0      ,
		q_b       => PX_LAPR1
	);
	JOLTEON_SP : ENTITY WORK.JOLTEON_ROM --6 "0110"
	PORT MAP
	(
		address_a => ADDR_SLV_JOLT0,
		address_b => ADDR_SLV_JOLT1,
		clock     => clk           ,
		q_a       => PX_JOLT0      ,
		q_b       => PX_JOLT1
	);
	GARCHOMP_SP : ENTITY WORK.GARCHOMP_ROM --7 "0111"
	PORT MAP
	(
		address_a => ADDR_SLV_GARC0,
		address_b => ADDR_SLV_GARC1,
		clock     => CLK           ,
		q_a       => PX_GARC0      ,
		q_b       => PX_GARC1
	);
	FLAREON_SP : ENTITY WORK.FLAREON_ROM --8 "1000"
	PORT MAP
	(
		address_a => ADDR_SLV_FLAR0,
		address_b => ADDR_SLV_FLAR1,
		clock     => CLK           ,
		q_a       => PX_FLAR0      ,
		q_b       => PX_FLAR1
	);
	CHARIZARD_SP : ENTITY WORK.CHARIZARD_ROM --9 "1001"
	PORT MAP
	(
		address_a => ADDR_SLV_CHAR0,
		address_b => ADDR_SLV_CHAR1,
		clock     => CLK           ,
		q_a       => PX_CHAR0      ,
		q_b       => PX_CHAR1
	);
	RANDOM_SP : ENTITY WORK.RANDOM_ROM --OTHERS
	PORT MAP
	(
		address_a => ADDR_SLV_RAND0,
		address_b => ADDR_SLV_RAND1,
		clock     => CLK           ,
		q_a       => PX_RAND0      ,
		q_b       => PX_RAND1
	);
END ARCHITECTURE main;

