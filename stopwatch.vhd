----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:34:17 01/17/2019 
-- Design Name: 
-- Module Name:    stopwatch - Behavioral 
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
use ieee.std_logic_unsigned.all;  
use IEEE.NUMERIC_STD.ALL;

entity stopwatch is
	Port (clk_10k 	: in  STD_LOGIC;
			key_plus 	: in  STD_LOGIC;
			key_minus 	: in  STD_LOGIC;
			en_vector	: in STD_LOGIC_VECTOR (1 downto 0);
			key_action 	: in  STD_LOGIC;
			key_reset 	: in  STD_LOGIC; 
			lap_active 	: out  STD_LOGIC;
			sw_time 	: out  STD_LOGIC_VECTOR (31 downto 0));
end stopwatch;

architecture structure of stopwatch is

-- Component Declaration
component sw_counter is
	 Port ( clk : in  STD_LOGIC;
		  en : in STD_LOGIC;
		  s_pause : in  STD_LOGIC;
		  reset : in  STD_LOGIC;
		  q_time : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component control_logic is 
    Port ( 	clk			: in STD_LOGIC;
				key_plus 	: in  STD_LOGIC;
				key_minus 	: in  STD_LOGIC;
				en_vector	: in STD_LOGIC_VECTOR (1 downto 0);
				key_action 	: in  STD_LOGIC;
				key_reset 	: in  STD_LOGIC; 
				q_pause 		: out STD_LOGIC;
				q_run 	: out STD_LOGIC; 
				q_lap 		: out  STD_LOGIC;
				q_reset 	: out STD_LOGIC );	
end component;

component and_gate 
    Port ( 	inp_1 	: in  STD_LOGIC;
			inp_2 	: in  STD_LOGIC;
			f 		: out  STD_LOGIC);
end component;

component D_FF 
	Port ( 	clk 	: in  STD_LOGIC;
				en 		: in  STD_LOGIC;
			reset 	: in  STD_LOGIC;
			d 		: in  STD_LOGIC_VECTOR (31 downto 0);
			q 		: out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component two_to_one_mux is 
	Port ( 	x0 			: in  STD_LOGIC_VECTOR (31 downto 0);
				x1 			: in  STD_LOGIC_VECTOR (31 downto 0);
				s_active 	: in  STD_LOGIC;
				f 				: out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal lap_time: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
signal data_time: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
signal s_sw_time: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
signal s_lap_active: std_logic := '0';
signal s_sw_run: std_logic := '0';
signal s_time_pause : std_logic := '0';
signal s_reset : std_logic := '0';
signal lap_switch : std_logic := '0';

begin
--FSM control logic
	fsm : control_logic PORT MAP (
          clk => clk_10k,
          key_plus => key_plus,
          key_minus => key_minus,
			 en_vector => en_vector,
          key_action => key_action,
          key_reset => key_reset,
          q_pause => s_time_pause,
          q_run => s_sw_run,
          q_lap => s_lap_active,
			 q_reset => s_reset);
		  
--lap gate toggle
	and_gate_lap : and_gate PORT MAP ( s_sw_run, key_minus, lap_switch );

--counter start, pause
	sw_timer : sw_counter PORT MAP 
			( clk => clk_10k,
           en => s_sw_run ,
			  s_pause => s_time_pause,
           reset => s_reset,
           q_time => data_time	);
			
-- stopwatch lap
	lap_store: D_FF PORT MAP (
          clk => clk_10k,
          en => lap_switch,
          reset => s_reset,
          d => data_time,
          q => lap_time );
	
--stopwatch mux between lap or timer
	mux1 : two_to_one_mux port map(data_time, lap_time , s_lap_active, s_sw_time);
	
--output assignment
	lap_active<=s_lap_active;
	sw_time<=s_sw_time;

end structure;