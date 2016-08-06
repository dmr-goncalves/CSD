----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:33:22 12/09/2015 
-- Design Name: 
-- Module Name:    TOP - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TOP is
    Port ( Clk : IN STD_LOGIC;
			  gateOpenIn1 : OUT STD_LOGIC;
			  gateOpenOutFloor1 : OUT STD_LOGIC;
			  gateOpenIn2 : OUT STD_LOGIC;
			  gateOpenOutFloor2 : OUT STD_LOGIC;
			  button1 : IN STD_LOGIC;
			  button2 : IN STD_LOGIC;
			  switchFloor : IN STD_LOGIC;
			  switchIO : IN STD_LOGIC;
			  switchRamp : IN STD_LOGIC;
			  sensorA : IN STD_LOGIC;
			  sensorB : IN STD_LOGIC;
			  LEDS : OUT STD_LOGIC_VECTOR (7 downto 0);
			  Enable : IN STD_LOGIC;
			  Reset : IN STD_LOGIC;
           RED : out  STD_LOGIC;
           GRN : out  STD_LOGIC;
           BLU : out  STD_LOGIC;
           HS : out  STD_LOGIC;
           VS : out  STD_LOGIC;
			  an3 : out std_logic;
			  an2 : out std_logic;
			  an1 : out std_logic;
			  an0 : out std_logic;
			  algarismo : out std_logic_vector(7 downto 0)
			 );
end TOP;

architecture Behavioral of TOP is

signal ALG1 : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal ALG2 : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal ALG3 : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal ALG4 : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal ALG5 : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal ALG6 : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal ALG7 : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal ALG8 : STD_LOGIC_VECTOR(3 downto 0) := "0000";

signal ALG1_display : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal ALG2_display : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal ALG3_display : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal ALG4_display : STD_LOGIC_VECTOR(3 downto 0) := "0000";

signal s_gateOpenIn1 : STD_LOGIC;
signal s_gateOpenOutFloor1 : STD_LOGIC;
signal s_gateOpenIn2 : STD_LOGIC;
signal s_gateOpenOutFloor2 : STD_LOGIC;

  Component park IS
  Port(
      Clk : IN STD_LOGIC;
		
		button1 : IN STD_LOGIC;
	   button2 : IN STD_LOGIC;
	   switchFloor : IN STD_LOGIC;
	   switchIO : IN STD_LOGIC;
	   switchRamp : IN STD_LOGIC;
	   sensorA : IN STD_LOGIC;
	   sensorB : IN STD_LOGIC;
		
      gateOpenIn1 : OUT STD_LOGIC;
      gateOpenOutFloor1 : OUT STD_LOGIC;
      gateOpenIn2 : OUT STD_LOGIC;
      gateOpenOutFloor2 : OUT STD_LOGIC;
      Enable : IN STD_LOGIC;
      Reset : IN STD_LOGIC;
		LEDS : OUT STD_LOGIC_VECTOR (7 downto 0);
		FreeSpacesAlgFloor1_1 : OUT STD_LOGIC_VECTOR (3 downto 0);
		FreeSpacesAlgFloor1_2 : OUT STD_LOGIC_VECTOR (3 downto 0);
		FreeSpacesAlgFloor2_1 : OUT STD_LOGIC_VECTOR (3 downto 0);
		FreeSpacesAlgFloor2_2 : OUT STD_LOGIC_VECTOR (3 downto 0);
		FreeSpacesAlgTotal_1 : OUT STD_LOGIC_VECTOR (3 downto 0);
		FreeSpacesAlgTotal_2 : OUT STD_LOGIC_VECTOR (3 downto 0);
		OccupiedSpacesAlgFloor1_1 : OUT STD_LOGIC_VECTOR (3 downto 0);
		OccupiedSpacesAlgFloor1_2 : OUT STD_LOGIC_VECTOR (3 downto 0);
		OccupiedSpacesAlgTotal_1 : OUT STD_LOGIC_VECTOR (3 downto 0);
		OccupiedSpacesAlgTotal_2 : OUT STD_LOGIC_VECTOR (3 downto 0);
		OccupiedSpacesAlgFloor2_1 : OUT STD_LOGIC_VECTOR (3 downto 0);
		OccupiedSpacesAlgFloor2_2 : OUT STD_LOGIC_VECTOR (3 downto 0)
  );
  End Component park;
  
  COMPONENT VGA
  PORT( ALG1 : in  STD_LOGIC_VECTOR (3 downto 0);
		  ALG2 : in  STD_LOGIC_VECTOR (3 downto 0);
		  ALG3 : in  STD_LOGIC_VECTOR (3 downto 0);
		  ALG4 : in  STD_LOGIC_VECTOR (3 downto 0);
		  ALG5 : in  STD_LOGIC_VECTOR (3 downto 0);
		  ALG6 : in  STD_LOGIC_VECTOR (3 downto 0);
		  ALG7 : in  STD_LOGIC_VECTOR (3 downto 0);
		  ALG8 : in  STD_LOGIC_VECTOR (3 downto 0);
		 Clk : in  STD_LOGIC;
		 RED : out  STD_LOGIC;
		 GRN : out  STD_LOGIC;
		 BLU : out  STD_LOGIC;
		 HS : out  STD_LOGIC;
		 VS : out  STD_LOGIC);
	END COMPONENT;
	
	  COMPONENT DISPLAY
  PORT ( clk : in std_logic;
			reset : in std_logic;
			ALG4 : in std_logic_vector(3 downto 0);
			ALG3 : in std_logic_vector(3 downto 0);
			ALG2 : in std_logic_vector(3 downto 0);
			ALG1 : in std_logic_vector(3 downto 0);
			an3 : out std_logic;
			an2 : out std_logic;
			an1 : out std_logic;
			an0 : out std_logic;
			algarismo : out std_logic_vector(7 downto 0));
	END COMPONENT;

begin

	vga_component: VGA PORT MAP (
		 ALG1 => ALG1,
		 ALG2 => ALG2,
		 ALG3 => ALG3,
		 ALG4 => ALG4,
		 ALG5 => ALG5,
		 ALG6 => ALG6,
		 ALG7 => ALG7,
		 ALG8 => ALG8,
		 Clk => Clk,
		 RED => RED,
		 GRN => GRN,
		 BLU => BLU,
		 HS => HS,
		 VS => VS
	  );
	  
	  display_component: DISPLAY PORT MAP (
			clk => Clk,
			reset => reset,
			ALG4 => ALG4_display,
			ALG3 => ALG3_display,
			ALG2 => ALG2_display,
			ALG1 => ALG1_display,
			an3 => an3,
			an2 => an2,
			an1 => an1,
			an0 => an0,
			algarismo => algarismo
	  );
	  
	  park_component : park Port Map(
        Clk => clk,
		  button1 => button1,
		  button2 => button2,
		  switchFloor => switchFloor,
		  switchIO => switchIO,
		  switchRamp => switchRamp,
		  sensorA => sensorA,
		  sensorB => sensorB,
        gateOpenIn1 => s_gateOpenIn1,
        gateOpenOutFloor1 => s_gateOpenOutFloor1,
        gateOpenIn2 => s_gateOpenIn2,
        gateOpenOutFloor2 => s_gateOpenOutFloor2,
        Enable => enable,
        Reset => reset,
		  LEDS => LEDS,
		  FreeSpacesAlgFloor1_1 => ALG6,
		  FreeSpacesAlgFloor1_2 => ALG5,
		  FreeSpacesAlgFloor2_1 => ALG2,
		  FreeSpacesAlgFloor2_2 => ALG1,
		  OccupiedSpacesAlgFloor1_1 => ALG8,
		  OccupiedSpacesAlgFloor1_2 => ALG7,
		  OccupiedSpacesAlgFloor2_1 => ALG4,
		  OccupiedSpacesAlgFloor2_2 => ALG3,
		  
		  OccupiedSpacesAlgTotal_1 => ALG4_display,
		  OccupiedSpacesAlgTotal_2 => ALG3_display,
		  FreeSpacesAlgTotal_1 => ALG2_display,
		  FreeSpacesAlgTotal_2 => ALG1_display
    );

end Behavioral;
