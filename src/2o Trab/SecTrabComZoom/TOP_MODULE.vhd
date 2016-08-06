----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:45:15 10/24/2015 
-- Design Name: 
-- Module Name:    TOP_MODULE - Behavioral 
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

entity TOP_MODULE is
    Port ( RESET : in  STD_LOGIC;
           NEXTDIGIT : in  STD_LOGIC;
           PLUS : in  STD_LOGIC;
			  CLK : in  STD_LOGIC;
			  COLOR : in  STD_LOGIC;
			  ZOOM : in STD_LOGIC_VECTOR(1 downto 0);
           RED : out  STD_LOGIC;
           GRN : out  STD_LOGIC;
           BLU : out  STD_LOGIC;
           HS : out  STD_LOGIC;
           VS : out  STD_LOGIC
			 );
end TOP_MODULE;

architecture Behavioral of TOP_MODULE is

signal ZERO : STD_LOGIC := '0';
signal SUM : STD_LOGIC := '0';
signal NEXT_DIGIT : STD_LOGIC := '0';
signal ALG1 : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal ALG2 : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal ALG3 : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal ALG4 : STD_LOGIC_VECTOR(3 downto 0) := "0000";


    COMPONENT CONTROL
    PORT( RESET : in  STD_LOGIC;
           PLUS : in  STD_LOGIC;
           NEXTDIGIT : in  STD_LOGIC;
           ZERO : out  STD_LOGIC;
           SUM : out  STD_LOGIC;
           NEXT_DIGIT : out  STD_LOGIC;
           CLK : in  STD_LOGIC
			  );
    END COMPONENT;
	 
	 COMPONENT DATA
    PORT( ZERO : in  STD_LOGIC;
          SUM : in  STD_LOGIC;
          NEXT_DIGIT : in  STD_LOGIC;
          CLK : in STD_LOGIC;
			 ALG1 : out STD_LOGIC_VECTOR(3 downto 0);
			 ALG2 : out STD_LOGIC_VECTOR(3 downto 0);
			 ALG3 : out STD_LOGIC_VECTOR(3 downto 0);
			 ALG4 : out STD_LOGIC_VECTOR(3 downto 0));
    END COMPONENT;
	 
	 COMPONENT VGA
    PORT( ALG1 : in  STD_LOGIC_VECTOR (3 downto 0);
			 ALG2 : in  STD_LOGIC_VECTOR (3 downto 0);
			 ALG3 : in  STD_LOGIC_VECTOR (3 downto 0);
			 ALG4 : in  STD_LOGIC_VECTOR (3 downto 0);
			 ZOOM : in STD_LOGIC_VECTOR (1 downto 0);
			 CLK : in  STD_LOGIC;
			 COLOR : in STD_LOGIC;
          RED : out  STD_LOGIC;
          GRN : out  STD_LOGIC;
          BLU : out  STD_LOGIC;
          HS : out  STD_LOGIC;
          VS : out  STD_LOGIC);
	  END COMPONENT;
	
begin
	
	  uut: CONTROL PORT MAP (
          RESET => RESET,
          PLUS => PLUS,
          NEXTDIGIT => NEXTDIGIT,
          ZERO => ZERO,
          SUM => SUM,
          NEXT_DIGIT => NEXT_DIGIT,
          CLK => CLK
        );
		  
		uut2: DATA PORT MAP (
          ZERO => ZERO,
          SUM => SUM,
          NEXT_DIGIT => NEXT_DIGIT,
          CLK => CLK,
			 ALG1 => ALG1,
			 ALG2 => ALG2,
			 ALG3 => ALG3,
			 ALG4 => ALG4
        );
		  
		 uut3: VGA PORT MAP (
          ALG1 => ALG1,
			 ALG2 => ALG2,
			 ALG3 => ALG3,
			 ALG4 => ALG4,
			 ZOOM => ZOOM,
			 CLK => CLK,
			 COLOR => COLOR,
          RED => RED,
          GRN => GRN,
          BLU => BLU,
          HS => HS,
          VS => VS
        );
	 
end Behavioral;

