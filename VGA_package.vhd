LIBRARY IEEE               ;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD       ;
--------------------------------------------------
USE WORK.basic_package.ALL ;
--------------------------------------------------
PACKAGE VGA_package IS
	
	TYPE VGA_CTRL_T IS RECORD
		CLK   : UINT01;
		BLANK : UINT01;
		SYNC  : UINT01;
		HSYNC : UINT01;
		VSYNC : UINT01;
	END RECORD VGA_CTRL_T;
	--//////////////////////////
	TYPE SVGA_DATA_T IS RECORD
		DISPLAY : INTEGER;
		FRONT_P : INTEGER;
		RETRACE : INTEGER;
		BACK_P  : INTEGER;
	END RECORD SVGA_DATA_T;
	
	CONSTANT H_DATA : SVGA_DATA_T := 
	(
		DISPLAY => (799),
		FRONT_P => ( 16),
		RETRACE => ( 80),
		BACK_P  => (160)
	);
	
	CONSTANT V_DATA : SVGA_DATA_T :=
	(
		DISPLAY => (599),
		FRONT_P => (  1),
		RETRACE => (  2),
		BACK_P  => ( 21)
	);
	--//////////////////////////
	TYPE TIME_STAMP_T IS RECORD
		DISPLAY     : UINT11;
		FRONT_PORCH : UINT11;
		RETRACE     : UINT11;
		FULL_SCAN   : UINT11;
	END RECORD TIME_STAMP_T;

	CONSTANT H_TIME : TIME_STAMP_T :=
	(
		DISPLAY     => (Int2Slv((H_DATA.DISPLAY), 11)),
		FRONT_PORCH => (Int2Slv((H_DATA.DISPLAY + H_DATA.FRONT_P), 11)),
		RETRACE     => (Int2Slv((H_DATA.DISPLAY + H_DATA.FRONT_P + H_DATA.RETRACE), 11)),
		FULL_SCAN   => (Int2Slv((H_DATA.DISPLAY + H_DATA.FRONT_P + H_DATA.RETRACE + H_DATA.BACK_P), 11))
	);
	
	CONSTANT V_TIME : TIME_STAMP_T :=
	(
		DISPLAY     => (Int2Slv((V_DATA.DISPLAY), 11)),
		FRONT_PORCH => (Int2Slv((V_DATA.DISPLAY + V_DATA.FRONT_P), 11)),
		RETRACE     => (Int2Slv((V_DATA.DISPLAY + V_DATA.FRONT_P + V_DATA.RETRACE), 11)),
		FULL_SCAN   => (Int2Slv((V_DATA.DISPLAY + V_DATA.FRONT_P + V_DATA.RETRACE + V_DATA.BACK_P), 11))
	);
	
END PACKAGE VGA_package;
--------------------------------------------------
PACKAGE BODY VGA_package IS
END VGA_package;
