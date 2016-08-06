----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:45:01 09/23/2015 
-- Design Name: 
-- Module Name:    CONTROL - Behavioral 
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

entity CONTROL is
    Port ( RESET : in  STD_LOGIC;
           PLUS : in  STD_LOGIC;
           NEXTDIGIT : in  STD_LOGIC;
           ZERO : out  STD_LOGIC;
           SUM : out  STD_LOGIC;
           NEXT_DIGIT : out  STD_LOGIC;
           CLK : in  STD_LOGIC);
end CONTROL;

architecture Behavioral of CONTROL is

   type state_type is (STATE0, STATE1, STATE2, STATE3, STATE4); --adicionar os estados
   signal state, next_state : state_type;
	signal push : STD_LOGIC;
	
begin
--Insert the following in the architecture after the begin keyword
   SYNC_PROC: process (CLK)
   begin
		if (CLK'event and CLK = '1') then
			state <= next_state;      
		end if;
   end process;
	
	push_button : process (CLK)
	begin 
		if (CLK = '1' and CLK'Event) then
			if (PLUS = '1' or RESET = '1' or NEXTDIGIT = '1') then
				push <= '1';
			else 
				push <= '0';
			end if;
		end if;
	end process;
 
   --MOORE State-Machine - Outputs based on state only
   OUTPUT_DECODE: process (state)
   begin
      --insert statements to decode internal output signals
      --below is simple example
		if state = STATE0 then
			SUM <= '0';
			NEXT_DIGIT <= '0';
			ZERO <= '0';
		end if;
      if state = STATE1 then
         SUM <= '1';
			NEXT_DIGIT <= '0';
			ZERO <= '0';
      end if;
		if state = STATE2 then
			NEXT_DIGIT <= '1';	
			SUM <= '0';
			ZERO <= '0';
		end if;
		if state = STATE3 then
			ZERO <= '1';
			SUM <= '0';
			NEXT_DIGIT <= '0';
		end if;
		if state = STATE4 then
			SUM <= '0';
		end if;
   end process;
 
   NEXT_STATE_DECODE: process (state, push)
   begin
      next_state <= state;  --default is to stay in current state

      case (state) is 
         when STATE0 =>
            if PLUS = '1' and NEXTDIGIT <= '0' and RESET <= '0' then
               next_state <= STATE1;
            end if;
				if NEXTDIGIT <= '1' and PLUS <= '0' and RESET <= '0'  then 
					next_state <= STATE2;
				end if;
				if RESET = '1' and PLUS <= '0' and NEXTDIGIT <= '0'  then
					next_state <= STATE3;
				end if;
				if PLUS <= '0' and NEXTDIGIT <= '0' and RESET <= '0'  then
					next_state <= state;
				end if;
         when STATE1 =>
            next_state <= STATE4;
         when STATE2 =>
				next_state <= STATE4;
         when STATE3 =>
            next_state <= STATE4;
			when STATE4 =>
				if push = '0' then
					next_state <= STATE0;
				else
					next_state <= state;
				end if;
      end case;      
   end process;

end Behavioral;

