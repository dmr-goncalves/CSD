----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:31:27 09/30/2015 
-- Design Name: 
-- Module Name:    DATA_VHDL - Behavioral 
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

entity DATA is
    Port ( ZERO : in  STD_LOGIC;
           SUM : in  STD_LOGIC;
           NEXT_DIGIT : in  STD_LOGIC;
           CLK : in STD_LOGIC;
			  ALG1 : out STD_LOGIC_VECTOR(3 downto 0);
			  ALG2 : out STD_LOGIC_VECTOR(3 downto 0);
			  ALG3 : out STD_LOGIC_VECTOR(3 downto 0);
			  ALG4 : out STD_LOGIC_VECTOR(3 downto 0));
end DATA;

architecture Behavioral of DATA is

signal aux : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal reg_a : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal reg_b : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal reg_c : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal reg_d : STD_LOGIC_VECTOR(3 downto 0) := "0000";

begin
	process (CLK)
		begin
		if CLK'event and CLK = '1' then
			
			if ZERO = '1' then 
					reg_a <= "0000";
					reg_b <= "0000";
					reg_c <= "0000";
					reg_d <= "0000";
			end if;
			
			if aux = "0000" then
				if SUM = '1' then 
					reg_d <= reg_d + 1;
				end if;
				if NEXT_DIGIT = '1' then
					aux <= "0001";
				end if;
				if reg_d = "1001" and SUM = '1' then
					reg_d <= "0000";
				end if;		
			end if;
			
			if aux = "0001" then
				if SUM = '1' then 
					reg_c <= reg_c + 1;
				end if;
				if NEXT_DIGIT = '1' then
					aux <= "0010";
				end if;
				if reg_c = "1001" and SUM = '1' then
					reg_c <= "0000";
				end if;
			end if;
			
			if aux = "0010" then
				if SUM = '1' then 
					reg_b <= reg_b + 1;
				end if;
				if NEXT_DIGIT = '1' then
					aux <= "0011";
				end if;
				if reg_b = "1001" and SUM = '1' then
					reg_b <= "0000";
				end if;
			end if;
			
			if aux = "0011" then
				if SUM = '1' then 
					reg_a <= reg_a + 1;
				end if;
				if NEXT_DIGIT = '1' then
					aux <= "0000";
				end if;
				if reg_a = "1001" and SUM = '1' then
					reg_a <= "0000";
				end if;
			end if;
		end if;
	end process;
	
	ALG4 <= reg_d;
	ALG3 <= reg_c;
	ALG2 <= reg_b;
	ALG1 <= reg_a;

end Behavioral;
