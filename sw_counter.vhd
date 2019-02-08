----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:35:30 01/23/2019 
-- Design Name: 
-- Module Name:    sw_counter - Behavioral 
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

entity sw_counter is
    Port ( clk : in  STD_LOGIC;
			  en : in STD_LOGIC;
           s_pause : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           q_time : out  STD_LOGIC_VECTOR (31 downto 0));
end sw_counter;

architecture Behavioral of sw_counter is
	component cnt_msec is 
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           en : in  STD_LOGIC;
			  pause : in STD_LOGIC;
           q_msec : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;

	component cnt_sec is 
    Port ( clk : in  STD_LOGIC;
           en : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  pause : in STD_LOGIC;
			  q_sec : out STD_LOGIC_VECTOR (7 downto 0));
	end component;

	component cnt_min is 
    Port ( clk : in  STD_LOGIC;
           en : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  pause : in STD_LOGIC;
           q_min : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;

	component cnt_hour is
    Port ( clk : in  STD_LOGIC;
           en : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  pause : in STD_LOGIC;
           q_hour : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	signal s_hour,s_min,s_sec,s_msec : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
begin
	
	msec_counter: cnt_msec PORT MAP 
			( clk => clk,
           reset => reset,
           en => en ,
			  pause => s_pause,
           q_msec => s_msec
			);
	sec_counter: cnt_sec PORT MAP 
			( clk => clk,
           reset => reset,
           en => en,
			  pause => s_pause,
           q_sec => s_sec
			);
			
	min_counter: cnt_min PORT MAP 
			( clk => clk,
           reset => reset,
           en => en,
			  pause => s_pause,
           q_min => s_min
			);

	hour_counter: cnt_hour PORT MAP 
			( clk => clk,
           reset => reset,
           en => en,
			  pause => s_pause,
           q_hour => s_hour
			);
	
	--Encoder
	q_time <= s_hour & s_min & s_sec & s_msec;


end Behavioral;

