----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:39:56 01/24/2019 
-- Design Name: 
-- Module Name:    control_logic - fsm 
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

entity control_logic is
    Port ( 	clk			: in STD_LOGIC;
				key_plus 	: in  STD_LOGIC;
				key_minus 	: in  STD_LOGIC;
				en_vector 	: in STD_LOGIC_VECTOR (1 downto 0);
				key_action 	: in  STD_LOGIC;
				key_reset 	: in  STD_LOGIC; 
				q_pause 		: out STD_LOGIC;
				q_run 	: out STD_LOGIC;
				q_lap 		: out  STD_LOGIC;				
				q_reset 		: out  STD_LOGIC);
end control_logic;

architecture fsm of control_logic is
	type state_type is (sw_active,sw_running,sw_pause, sw_lap, sw_reset, sys_reset);--described for fsm
	signal current_s, next_s: state_type;--described for fsm
begin

--State register
	state_reg: process(clk)
	begin
		if (clk'event and clk='1') then
			if (key_reset='1') then
				current_s <= sys_reset;
			else
				current_s <= next_s;
			end if;
		end if;
	end process;

--Control logic
	Finite_State_Machine: process(current_s,key_action,key_plus,key_minus,key_reset,en_vector)--sensitivity list
	begin
	case current_s is
		-------------------------------------------------------------------------------------------- 
		when sw_active=>  --Stopwatch_on
			if en_vector = "11" then --if the stopwatch is active
				if key_action = '1' then  --start the stopwatch with action
					next_s <=sw_running;
				elsif key_plus = '1' then --Stopwatch reset
					next_s <= sw_reset;
				elsif key_reset = '1'  then --System Reset
					next_s <= sys_reset;
				else
					next_s<=sw_active;
				end if;
			else
				next_s<=sw_active;
			end if;
			--Output Assignment
			q_run <= '0';
			q_reset <= '0';
			q_lap <= '0';
			q_pause <= '0';
		--------------------------------------------------------------------------------------------------------------------------------------------
		when sw_running => --Stopwatch_running
			if en_vector = "11" then --if the stopwatch is active
				if key_action = '1' then --pause mode with action key
					next_s <= sw_pause;
				elsif key_minus = '1' then -- Lap mode with minus key
					next_s <= sw_lap;
				elsif key_plus = '1' then --Stopwatch reset
					next_s <= sw_reset;	
				elsif key_reset = '1'  then --System Reset
					next_s <= sys_reset;
				else
					next_s<=sw_running;
				end if;
			else
				next_s<=sw_running;
			end if;
			--Output Assignment
			q_reset <= '0';
			q_run <= '1';
			q_pause <= '0';
			q_lap <= '0';
		-----------------------------------------------------------------------------------------------------------------------------------------------		  
		when sw_pause=> --Stopwatch Pause
			if en_vector = "11" then --if the stopwatch is active
				if key_action = '1' then --resume the stopwatch with action
					next_s <= sw_running;
				elsif key_plus = '1' then --Stopwatch reset
					next_s <= sw_reset;	
				elsif key_reset = '1'  then --System Reset
					next_s <= sys_reset;
				else
					next_s<=sw_pause;					
				end if;
			else
				next_s<=sw_pause;				
			end if;
			--Output Assignment
			q_reset <= '0';
			q_pause <= '1';
			q_run <= '1';
			q_lap <= '0';
		-----------------------------------------------------------------------------------------------------------------------------------------------		 
		when sw_lap=> --Stopwatch in lap mode
			if en_vector = "11" then --if the stopwatch is active
				if key_minus = '1' then --move to stopwatch running display with minus
					next_s <= sw_running;
				elsif key_plus = '1' then --Stopwatch reset
					next_s <= sw_reset;
				elsif key_reset = '1'  then --System Reset
					next_s <= sys_reset;
				else
					next_s<=sw_lap;					
				end if;
			else
				next_s<=sw_lap;				
			end if;
			--Output Assignment
			q_reset <= '0';
			q_lap <= '1';
			q_run <= '1';
			q_pause <= '0';
		-----------------------------------------------------------------------------------------------------------------------------------------------		 
		when sw_reset=> --Stopwatch reset with + key
			if en_vector = "11" then --if the stopwatch is active
				if key_action = '1' then --start the stopwatch with action
					next_s <= sw_running;
				elsif key_reset = '1'  then --System Reset
					next_s <= sys_reset;
				else
					next_s <= sw_reset;
				end if;
			else
				next_s <= sw_reset;
			end if;
			--Output Assignment
			q_pause <= '0';
			q_lap <= '0';
			q_run <= '0';
			q_reset <= '1';
		-----------------------------------------------------------------------------------------------------------------------------------------------	
		when sys_reset=> --System Reset
			if key_plus = '1' or key_minus = '1' then -- start the sw again
				next_s <= sw_active;
			else
				next_s <= sys_reset;
			end if;
			--Output Assignment
			q_pause <= '0';
			q_lap <= '0';
			q_run <= '0';
			q_reset <= '1';
		when others=>
			next_s<=sw_active;
			--Output Assignment
			q_pause <= '0';
			q_lap <= '0';
			q_run <= '0';
			q_reset <= '0';
	end case;
	end process;	


end fsm;

