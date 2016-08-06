----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:39:50 10/28/2015 
-- Design Name: 
-- Module Name:    DISPLAY - Behavioral 
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

entity DISPLAY is
	Port ( clk : in std_logic;
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
end DISPLAY;

architecture Behavioral of DISPLAY is

signal alg : std_logic_vector(3 downto 0);
signal cont_clock : integer range 0 to 499999;
signal num_alg : std_logic_vector(1 downto 0);

begin

	co: process (clk, reset)
	begin
		if reset = '1' then
			cont_clock <= 0;
		elsif clk'event and clk = '1' then
			if cont_clock = 499999 then
				cont_clock <= 0;
				num_alg <= "00";
			else
				if cont_clock = 124999 then
					num_alg <= "01";
				elsif cont_clock = 249999 then
					num_alg <= "10";
				elsif cont_clock = 374999 then
					num_alg <= "11";
				end if;
				
				cont_clock <= cont_clock + 1;
			end if;
		end if;
	end process;
	
	an : process(clk, reset)
	begin
		if reset = '1' then
			an3 <= '0';
			an2 <= '0';
			an1 <= '0';
			an0 <= '0';
			alg <= "0000";
			algarismo(7) <= '1';
		elsif clk'event and clk = '1' then
			if num_alg = "00" then
				an3 <= '1';
				an2 <= '1';
				an1 <= '1';
				an0 <= '0';
				alg <= ALG4;
				algarismo(7) <= '1';
			elsif num_alg = "01" then
				an3 <= '1';
				an2 <= '1';
				an1 <= '0';
				an0 <= '1';
				alg <= ALG3;
				algarismo(7) <= '1';
			elsif num_alg = "10" then
				an3 <= '1';
				an2 <= '0';
				an1 <= '1';
				an0 <= '1';
				alg <= ALG2;
				algarismo(7) <= '0';
			elsif num_alg = "11" then
				an3 <= '0';
				an2 <= '1';
				an1 <= '1';
				an0 <= '1';
				alg <= ALG1;
				algarismo(7) <= '1';
			end if;
		end if;
	end process;
	
	al : process(clk, reset)
	begin
		if reset = '1' then
			algarismo(6 downto 0) <= "0000001";
		elsif clk'event and clk = '1' then
			case alg is
				when "0000" => algarismo(6 downto 0) <= "0000001";
				when "0001" => algarismo(6 downto 0) <= "1001111";
				when "0010" => algarismo(6 downto 0) <= "0010010";
				when "0011" => algarismo(6 downto 0) <= "0000110";
				when "0100" => algarismo(6 downto 0) <= "1001100";
				when "0101" => algarismo(6 downto 0) <= "0100100";
				when "0110" => algarismo(6 downto 0) <= "0100000";
				when "0111" => algarismo(6 downto 0) <= "0001111";
				when "1000" => algarismo(6 downto 0) <= "0000000";
				when "1001" => algarismo(6 downto 0) <= "0000100";
				when others => algarismo(6 downto 0) <= "0111000";
			end case;
		end if;
	end process;

end Behavioral;