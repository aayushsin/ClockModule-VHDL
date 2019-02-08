--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:18:45 01/24/2019
-- Design Name:   
-- Module Name:   /nas/ei/home/ga53bog/Desktop/projlab/stop_watch/control_logic_tb.vhd
-- Project Name:  stop_watch
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: control_logic
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY control_logic_tb IS
END control_logic_tb;
 
ARCHITECTURE behavior OF control_logic_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT control_logic
    PORT(
         clk : IN  std_logic;
         key_plus : IN  std_logic;
         key_minus : IN  std_logic;
         en_vector 	: in STD_LOGIC_VECTOR (1 downto 0);
         key_action : IN  std_logic;
         key_reset : IN  std_logic;
         q_pause : OUT  std_logic;
         q_run : OUT  std_logic;
         q_lap : OUT  std_logic;
		 q_reset : OUT std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal key_plus : std_logic := '0';
   signal key_minus : std_logic := '0';
   signal key_action : std_logic := '0';
   signal key_reset : std_logic := '0';
   signal en_vector :  STD_LOGIC_VECTOR (1 downto 0) := "00";

 	--Outputs
   signal q_pause : std_logic;
   signal q_run : std_logic;
   signal q_lap : std_logic;
   signal q_reset : std_logic;

   -- Clock period definitions
   constant clk_period : time := 2 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: control_logic PORT MAP (
          clk => clk,
          key_plus => key_plus,
          key_minus => key_minus,
          en_vector => en_vector,
          key_action => key_action,
          key_reset => key_reset,
          q_pause => q_pause,
          q_run => q_run,
          q_lap => q_lap,
		  q_reset => q_reset
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		wait for 100 ns;	
			key_reset <='1';
		wait for 800 ns; --sw active
			key_reset <='0';
			key_plus <='1';
			en_vector <= "11";
		wait for 2 ns;
			key_plus <= '0';
		wait for 500 ns; --sw_run
			key_action <='1';
		wait for 2 ns; 
			key_action <='0';
		wait for 1100 ns;  --sw_pause
			key_action <='1';
		wait for 2 ns;
			key_action <='0';
		wait for 2000 ns;  --sw_unpause
			key_action <='1';
		wait for 2 ns;
			key_action <='0';
		wait for 2000 ns;  --sw_reset
			key_plus <='1';
		wait for 2 ns;
			key_plus <='0';
		wait for 200 ns;  --do nothing
			key_minus <='1';
		wait for 2 ns;
			key_minus <='0';
		wait for 2000 ns;  --sw_run
			key_action <='1';
		wait for 2 ns;
			key_action <='0';
		wait for 2000 ns;  --sw_lap
			key_minus <='1';
		wait for 2 ns;
			key_minus <='0';
		wait for 2000 ns;  --sw_unlap
			key_minus <='1';
		wait for 2 ns;
			key_minus <='0';

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
