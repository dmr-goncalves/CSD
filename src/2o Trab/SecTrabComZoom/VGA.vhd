----------------------------------------------------------------------------------
-- Company: 			Faculdade de Ciências e Tecnologia
-- Engineer: 			António Mendes / Dimo Naydenov / Duarte Gonçalves
-- 
-- Create Date:    	09:54:00 10/14/2015 
-- Design Name: 
-- Module Name:    	CARACTERES - Behavioral 
-- Project Name:		VGA Signal Generator
-- Target Devices:	Spartan3
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
use ieee.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VGA is
    Port ( ALG1 : in  STD_LOGIC_VECTOR (3 downto 0);
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
end VGA;

architecture Behavioral of VGA is

signal mclk: STD_LOGIC;

signal horz_scan: STD_LOGIC_VECTOR (9 downto 0);
signal vert_scan: STD_LOGIC_VECTOR (9 downto 0);
signal horz_scan_digit : STD_LOGIC_VECTOR (6 downto 0);

signal seg_1, seg_2, seg_3, seg_4, seg_5, seg_6, seg_7, seg_8, seg_9, seg_10, seg_11, seg_12, seg_13, seg_14, seg_15, seg_16, seg_17, seg_18, seg_19, seg_20, seg_21, seg_22, seg_23, seg_24, seg_25, seg_26, seg_27, seg_28 : STD_LOGIC;
signal vert_inc_flag: STD_LOGIC;
signal back_color, num_color: STD_LOGIC;
signal vert_pos, horz_pos, dist, height, inside_height, width, small_side, big_horiz_side, big_vert_side : STD_LOGIC_VECTOR (9 downto 0);

begin
  -- Clock divide by 1/2  
  process(CLK)
  begin
    if CLK = '1' and CLK'Event then
	   -- CLK <= CLK xor mclk;
	   mclk <= not mclk;
    end if;
  end process;
  
  -- horizonal clock
  process(mclk)
  begin
    if mclk = '1' and mclk'Event then
	   if horz_scan = "1100100000" then --800
		  horz_scan <= "0000000000";
		else
		  horz_scan <= horz_scan + 1;
		end if;
	 end if;
  end process;
  
  -- vertial clock (increments when the horizontal clock is on the front porch
  process(vert_inc_flag)
  begin
    if vert_inc_flag = '1' and vert_inc_flag'Event then
      if vert_scan = "1000001001" then --001001011000 - 600
	  	  vert_scan <= "0000000000";
      else
		  vert_scan <= vert_scan + 1;
      end if;
    end if;
  end process;
 
  -- horizontal sync for 96 horizontal clocks (96 pixels)
  -- HS <= '1' when horz_scan(9 downto "0111") = "000" else '0';
  HS <= '1' when horz_scan < 96 else '0';
  -- vertial sync for 2 scan lines
  VS <= '1' when vert_scan(9 downto 1) = "000000000" else '0';

process(mclk)
  begin
	 if mclk'Event and mclk = '1' then
		 
		if COLOR = '0' then
			back_color <= '0';
			num_color <= '1';
		elsif COLOR = '1' then
			back_color <= '1';
			num_color <= '0';
		end if;
			
		case (ALG1) is --numero primeiro segmento
			  when "0000" =>
					seg_1 <= '1'; seg_2 <= '1'; seg_3 <= '1'; seg_4 <= '1'; seg_5 <= '1'; seg_6 <= '1'; seg_7 <= '0';
			  when "0001" =>
					seg_1 <= '0'; seg_2 <= '1'; seg_3 <= '1'; seg_4 <= '0'; seg_5 <= '0'; seg_6 <= '0'; seg_7 <= '0';
			  when "0010" =>
					seg_1 <= '1'; seg_2 <= '1'; seg_3 <= '0'; seg_4 <= '1'; seg_5 <= '1'; seg_6 <= '0'; seg_7 <= '1';
			  when "0011" =>
					seg_1 <= '1'; seg_2 <= '1'; seg_3 <= '1'; seg_4 <= '1'; seg_5 <= '0'; seg_6 <= '0'; seg_7 <= '1';
			  when "0100" =>
					seg_1 <= '0'; seg_2 <= '1'; seg_3 <= '1'; seg_4 <= '0'; seg_5 <= '0'; seg_6 <= '1'; seg_7 <= '1';
			  when "0101" =>
					seg_1 <= '1'; seg_2 <= '0'; seg_3 <= '1'; seg_4 <= '1'; seg_5 <= '0'; seg_6 <= '1'; seg_7 <= '1';
			  when "0110" =>
					seg_1 <= '1'; seg_2 <= '0'; seg_3 <= '1'; seg_4 <= '1'; seg_5 <= '1'; seg_6 <= '1'; seg_7 <= '1';
			  when "0111" =>
					seg_1 <= '1'; seg_2 <= '1'; seg_3 <= '1'; seg_4 <= '0'; seg_5 <= '0'; seg_6 <= '0'; seg_7 <= '0';
			  when "1000" =>
					seg_1 <= '1'; seg_2 <= '1'; seg_3 <= '1'; seg_4 <= '1'; seg_5 <= '1'; seg_6 <= '1'; seg_7 <= '1';
			  when "1001" =>
					seg_1 <= '1'; seg_2 <= '1'; seg_3 <= '1'; seg_4 <= '1'; seg_5 <= '0'; seg_6 <= '1'; seg_7 <= '1';
			  when others =>
		end case;

		case (ALG2) is --numero primeiro segmento
			  when "0000" =>
					seg_8 <= '1'; seg_9 <= '1'; seg_10 <= '1'; seg_11 <= '1'; seg_12 <= '1'; seg_13 <= '1'; seg_14 <= '0';
			  when "0001" =>
					seg_8 <= '0'; seg_9 <= '1'; seg_10 <= '1'; seg_11 <= '0'; seg_12 <= '0'; seg_13 <= '0'; seg_14 <= '0';
			  when "0010" =>
					seg_8 <= '1'; seg_9 <= '1'; seg_10 <= '0'; seg_11 <= '1'; seg_12 <= '1'; seg_13 <= '0'; seg_14 <= '1';
			  when "0011" =>
					seg_8 <= '1'; seg_9 <= '1'; seg_10 <= '1'; seg_11 <= '1'; seg_12 <= '0'; seg_13 <= '0'; seg_14 <= '1';
			  when "0100" =>
					seg_8 <= '0'; seg_9 <= '1'; seg_10 <= '1'; seg_11 <= '0'; seg_12 <= '0'; seg_13 <= '1'; seg_14 <= '1';
			  when "0101" =>
					seg_8 <= '1'; seg_9 <= '0'; seg_10 <= '1'; seg_11 <= '1'; seg_12 <= '0'; seg_13 <= '1'; seg_14 <= '1';
			  when "0110" =>
					seg_8 <= '1'; seg_9 <= '0'; seg_10 <= '1'; seg_11 <= '1'; seg_12 <= '1'; seg_13 <= '1'; seg_14 <= '1';
			  when "0111" =>
					seg_8 <= '1'; seg_9 <= '1'; seg_10 <= '1'; seg_11 <= '0'; seg_12 <= '0'; seg_13 <= '0'; seg_14 <= '0';
			  when "1000" =>
					seg_8 <= '1'; seg_9 <= '1'; seg_10 <= '1'; seg_11 <= '1'; seg_12 <= '1'; seg_13 <= '1'; seg_14 <= '1';
			  when "1001" =>
					seg_8 <= '1'; seg_9 <= '1'; seg_10 <= '1'; seg_11 <= '1'; seg_12 <= '0'; seg_13 <= '1'; seg_14 <= '1';
			  when others =>
		end case;
		 
		 case (ALG3) is --numero primeiro segmento
			  when "0000" =>
					seg_15 <= '1'; seg_16 <= '1'; seg_17 <= '1'; seg_18 <= '1'; seg_19 <= '1'; seg_20 <= '1'; seg_21 <= '0';
			  when "0001" =>
					seg_15 <= '0'; seg_16 <= '1'; seg_17 <= '1'; seg_18 <= '0'; seg_19 <= '0'; seg_20 <= '0'; seg_21 <= '0';
			  when "0010" =>
					seg_15 <= '1'; seg_16 <= '1'; seg_17 <= '0'; seg_18 <= '1'; seg_19 <= '1'; seg_20 <= '0'; seg_21 <= '1';
			  when "0011" =>
					seg_15 <= '1'; seg_16 <= '1'; seg_17 <= '1'; seg_18 <= '1'; seg_19 <= '0'; seg_20 <= '0'; seg_21 <= '1';
			  when "0100" =>
					seg_15 <= '0'; seg_16 <= '1'; seg_17 <= '1'; seg_18 <= '0'; seg_19 <= '0'; seg_20 <= '1'; seg_21 <= '1';
			  when "0101" =>
					seg_15 <= '1'; seg_16 <= '0'; seg_17 <= '1'; seg_18 <= '1'; seg_19 <= '0'; seg_20 <= '1'; seg_21 <= '1';
			  when "0110" =>
					seg_15 <= '1'; seg_16 <= '0'; seg_17 <= '1'; seg_18 <= '1'; seg_19 <= '1'; seg_20 <= '1'; seg_21 <= '1';
			  when "0111" =>
					seg_15 <= '1'; seg_16 <= '1'; seg_17 <= '1'; seg_18 <= '0'; seg_19 <= '0'; seg_20 <= '0'; seg_21 <= '0';
			  when "1000" =>
					seg_15 <= '1'; seg_16 <= '1'; seg_17 <= '1'; seg_18 <= '1'; seg_19 <= '1'; seg_20 <= '1'; seg_21 <= '1';
			  when "1001" =>
					seg_15 <= '1'; seg_16 <= '1'; seg_24 <= '1'; seg_18 <= '1'; seg_19 <= '0'; seg_20 <= '1'; seg_21 <= '1';
			  when others =>
		end case;

		 case (ALG4) is --numero primeiro segmento
			  when "0000" =>
					seg_22 <= '1'; seg_23 <= '1'; seg_24 <= '1'; seg_25 <= '1'; seg_26 <= '1'; seg_27 <= '1'; seg_28 <= '0';
			  when "0001" =>
					seg_22 <= '0'; seg_23 <= '1'; seg_24 <= '1'; seg_25 <= '0'; seg_26 <= '0'; seg_27 <= '0'; seg_28 <= '0';
			  when "0010" =>
					seg_22 <= '1'; seg_23 <= '1'; seg_24 <= '0'; seg_25 <= '1'; seg_26 <= '1'; seg_27 <= '0'; seg_28 <= '1';
			  when "0011" =>
					seg_22 <= '1'; seg_23 <= '1'; seg_24 <= '1'; seg_25 <= '1'; seg_26 <= '0'; seg_27 <= '0'; seg_28 <= '1';
			  when "0100" =>
					seg_22 <= '0'; seg_23 <= '1'; seg_24 <= '1'; seg_25 <= '0'; seg_26 <= '0'; seg_27 <= '1'; seg_28 <= '1';
			  when "0101" =>
					seg_22 <= '1'; seg_23 <= '0'; seg_24 <= '1'; seg_25 <= '1'; seg_26 <= '0'; seg_27 <= '1'; seg_28 <= '1';
			  when "0110" =>
					seg_22 <= '1'; seg_23 <= '0'; seg_24 <= '1'; seg_25 <= '1'; seg_26 <= '1'; seg_27 <= '1'; seg_28 <= '1';
			  when "0111" =>
					seg_22 <= '1'; seg_23 <= '1'; seg_24 <= '1'; seg_25 <= '0'; seg_26 <= '0'; seg_27 <= '0'; seg_28 <= '0';
			  when "1000" =>
					seg_22 <= '1'; seg_23 <= '1'; seg_24 <= '1'; seg_25 <= '1'; seg_26 <= '1'; seg_27 <= '1'; seg_28 <= '1';
			  when "1001" =>
					seg_22 <= '1'; seg_23 <= '1'; seg_24 <= '1'; seg_25 <= '1'; seg_26 <= '0'; seg_27 <= '1'; seg_28 <= '1';
			  when others =>
		end case;

			vert_pos <= "0010000010";--130
			horz_pos <= "0010010110";--150
		
		if ( ZOOM = "00") then
			dist <= "0000001010";--10
			height <= "0010000010";--130
			width <= "0001011010";--90
			small_side <= "0000010100";--20
			inside_height <= "0000100011";--35
			big_horiz_side <= "0000110010";--50
			big_vert_side <= "0001000001";--65
		elsif (ZOOM = "01") then -- +- 3/4
			dist <= "0000001000";--8
			height <= "0001100010";--98
			width <= "0001000100";--68
			small_side <= "0000001111";--15
			inside_height <= "0000011000";--24
			big_horiz_side <= "0000100110";--38
			big_vert_side <= "0000110001";--49
		elsif (ZOOM = "10") then -- 1/2
			dist <= "0000000101";--5
			height <= "0001000001";--65
			width <= "0000101101";--45
			small_side <= "0000001010";--10
			inside_height <= "0000010010";--18
			big_horiz_side <= "0000011001";--25
			big_vert_side <= "0000100000";--32
		elsif(ZOOM = "11") then -- 1/4
			dist <= "0000000011";--3
			height <= "0000100001";--33
			width <= "0000011001";--25
			small_side <= "0000000101";--5
			inside_height <= "0000001001";--9
			big_horiz_side <= "0000001111";--15
			big_vert_side <= "0000010000";--16	
		end if;
		
	if (vert_scan >= vert_pos) and (vert_scan < (vert_pos + small_side)) and (horz_scan >= (horz_pos + small_side)) and (horz_scan < (horz_pos + small_side + big_horiz_side)) then
		if seg_1 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;
		
	elsif (vert_scan >= vert_pos) and (vert_scan < (vert_pos + big_vert_side)) and (horz_scan >= (horz_pos + small_side + big_horiz_side)) and (horz_scan < (horz_pos + small_side + big_horiz_side + small_side)) then
		if seg_2 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;
		
	elsif (vert_scan >= (vert_pos + big_vert_side)) and (vert_scan < (vert_pos + height)) and (horz_scan >= (horz_pos + small_side + big_horiz_side)) and (horz_scan < (horz_pos + small_side + big_horiz_side + small_side)) then
		if seg_3 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;

	elsif (vert_scan >= (vert_pos + height - small_side)) and (vert_scan < (vert_pos + height)) and (horz_scan >= (horz_pos + small_side)) and (horz_scan < (horz_pos + small_side + big_horiz_side)) then
		if seg_4 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;
		
	elsif (vert_scan >= (vert_pos + big_vert_side)) and (vert_scan < (vert_pos + height)) and (horz_scan >= horz_pos) and (horz_scan < (horz_pos + small_side)) then
		if seg_5 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;
		
	elsif (vert_scan >= vert_pos) and (vert_scan < (vert_pos + big_vert_side)) and (horz_scan >= horz_pos) and (horz_scan < (horz_pos + small_side)) then
		if seg_6 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;

	elsif (vert_scan >= (vert_pos + small_side + inside_height)) and (vert_scan < (vert_pos + small_side + inside_height + small_side)) and (horz_scan >= (horz_pos + small_side)) and (horz_scan < (horz_pos + small_side + big_horiz_side)) then
		if seg_7 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;
		
	elsif (vert_scan >= vert_pos) and (vert_scan < vert_pos + small_side) and (horz_scan >= horz_pos + width + small_side + dist) and (horz_scan < horz_pos + width + small_side + big_horiz_side + dist) then
		if seg_8 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;
		
	elsif (vert_scan >= vert_pos) and (vert_scan < vert_pos + big_vert_side) and (horz_scan >= horz_pos + width + dist + small_side + big_horiz_side) and (horz_scan < horz_pos + width + dist + small_side + big_horiz_side + small_side) then
		if seg_9 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;
		
	elsif (vert_scan >= vert_pos + big_vert_side) and (vert_scan < vert_pos + height) and (horz_scan >= horz_pos + width + dist + small_side + big_horiz_side) and (horz_scan < horz_pos + width + dist + small_side + big_horiz_side + small_side) then
	if seg_10 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;

	elsif (vert_scan >= vert_pos + height - small_side) and (vert_scan < vert_pos + height) and (horz_scan >= horz_pos + width + small_side + dist) and (horz_scan < horz_pos + width + small_side + big_horiz_side + dist) then
		if seg_11 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;
		
	elsif (vert_scan >= vert_pos + big_vert_side) and (vert_scan < vert_pos + height) and (horz_scan >= horz_pos + width + dist) and (horz_scan < horz_pos + width + small_side + dist) then
		if seg_12 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;
		
	elsif (vert_scan >= vert_pos) and (vert_scan < vert_pos + big_vert_side) and (horz_scan >= horz_pos + width + dist) and (horz_scan < horz_pos + width + small_side + dist) then
		if seg_13 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;	
	
	elsif (vert_scan >= vert_pos + small_side + inside_height) and (vert_scan < vert_pos + small_side + inside_height + small_side) and (horz_scan >= horz_pos + width + small_side + dist) and (horz_scan < horz_pos + width + small_side + big_horiz_side + dist) then
		if seg_14 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;
	
	elsif (vert_scan >= vert_pos) and (vert_scan < vert_pos + small_side) and (horz_scan >= horz_pos + width + small_side + dist + width + dist) and (horz_scan < horz_pos + width + small_side + big_horiz_side + dist + width + dist) then
		if seg_15 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;
			
	elsif (vert_scan >= vert_pos) and (vert_scan < vert_pos + big_vert_side) and (horz_scan >= horz_pos + width + dist + small_side + big_horiz_side + width + dist) and (horz_scan < horz_pos + width + dist + small_side + big_horiz_side + small_side + width + dist) then
		if seg_16 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;
		
	elsif (vert_scan >= vert_pos + big_vert_side) and (vert_scan < vert_pos + height) and (horz_scan >= horz_pos + width + dist + small_side + big_horiz_side + width + dist) and (horz_scan < horz_pos + width + dist + small_side + big_horiz_side + small_side + width + dist) then
		if seg_17 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;

	elsif (vert_scan >= vert_pos + height - small_side) and (vert_scan < vert_pos + height) and (horz_scan >= horz_pos + width + small_side + dist + width + dist) and (horz_scan < horz_pos + width + small_side + big_horiz_side + dist + width + dist) then
		if seg_18 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;
		
	elsif (vert_scan >= vert_pos + big_vert_side) and (vert_scan < vert_pos + height) and (horz_scan >= horz_pos + width + dist + width + dist) and (horz_scan < horz_pos + width + small_side + dist + width + dist) then
		if seg_19 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;
		
	elsif (vert_scan >= vert_pos) and (vert_scan < vert_pos + big_vert_side) and (horz_scan >= horz_pos + width + dist + width + dist) and (horz_scan < horz_pos + width + small_side + dist + width + dist) then
		if seg_20 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;
		
	elsif (vert_scan >= vert_pos + small_side + inside_height) and (vert_scan < vert_pos + small_side + inside_height + small_side) and (horz_scan >= horz_pos + width + small_side + dist + width + dist) and (horz_scan < horz_pos + width + small_side + big_horiz_side + dist + width + dist) then
		if seg_21 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;

	elsif (vert_scan >= vert_pos) and (vert_scan < vert_pos + small_side) and (horz_scan >= horz_pos + width + small_side + dist + width + dist + width + dist) and (horz_scan < horz_pos + width - small_side  + dist + width + dist + width + dist + width) then
		if seg_22 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;
		
	elsif (vert_scan >= vert_pos) and (vert_scan < vert_pos + big_vert_side) and (horz_scan >= horz_pos + width + dist + width + dist + width + dist + width - small_side) and (horz_scan < horz_pos + width + dist +  width + dist + width + dist + width) then
		if seg_23 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;
		
	elsif (vert_scan >= vert_pos + big_vert_side) and (vert_scan < vert_pos + height) and (horz_scan >= horz_pos + width + dist + width + dist + width + dist + width - small_side) and (horz_scan < horz_pos + width + dist +  width + dist + width + dist + width) then
		if seg_24 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;

	elsif (vert_scan >= vert_pos + height - small_side) and (vert_scan < vert_pos + height) and (horz_scan >= horz_pos + width + small_side + dist + width + dist + width + dist) and (horz_scan < horz_pos + width + dist + width + dist + width + dist+ width - small_side) then
		if seg_25 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;
		
	elsif (vert_scan >= vert_pos + big_vert_side) and (vert_scan < vert_pos + height) and (horz_scan >= horz_pos + width + dist + width + dist + width + dist) and (horz_scan < horz_pos + width + small_side + dist + width + dist + width + dist) then
		if seg_26 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;
		
	elsif (vert_scan >= vert_pos) and (vert_scan < vert_pos + big_vert_side) and (horz_scan >= horz_pos + width + dist + width + dist + width + dist) and (horz_scan < horz_pos + width + small_side + dist + width + dist + width + dist) then
		if seg_27 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;
		
	elsif (vert_scan >= vert_pos + small_side + inside_height) and (vert_scan < vert_pos + small_side + inside_height + small_side) and (horz_scan >= horz_pos + width + small_side + dist + width + dist + width + dist) and (horz_scan < horz_pos + width - small_side + width + dist + width + dist + width + dist) then
		if seg_28 = '1' then
			RED <= num_color;
			GRN <= num_color;
			BLU <= num_color;
		else 
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;
		
	else
		if COLOR = '1' then
			if vert_scan >= 100 and vert_scan < 290 and horz_scan >= 140 and horz_scan < 550  then
				RED <= back_color;
				GRN <= back_color;
				BLU <= back_color;
			else
				RED <= num_color;
				GRN <= num_color;
				BLU <= num_color;
			end if;
		elsif COLOR = '0' then
			RED <= back_color;
			GRN <= back_color;
			BLU <= back_color;
		end if;
   end if;
	end if;
 end process;

 vert_inc_flag <= '1' when horz_scan = "1100011000" else '0';

end Behavioral;
