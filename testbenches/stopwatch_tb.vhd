--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:12:26 01/31/2019
-- Design Name:   
-- Module Name:   /nas/ei/home/ga53bog/Desktop/projlab/stop_watch/stopwatch_tb.vhd
-- Project Name:  stop_watch
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: stopwatch
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
 
ENTITY stopwatch_tb IS
END stopwatch_tb;
 
ARCHITECTURE behavior OF stopwatch_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT stopwatch
    PORT(
         clk_10k : IN  std_logic;
         --clk_100 : IN  std_logic;
         --clk_1 : IN  std_logic;
         key_plus : IN  std_logic;
         key_minus : IN  std_logic;
         en_vector : IN  std_logic_vector(1 downto 0);
         key_action : IN  std_logic;
         key_reset : IN  std_logic;
         lap_active : OUT  std_logic;
         sw_time : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_10k : std_logic := '0';
   --signal clk_100 : std_logic := '0';
   --signal clk_1 : std_logic := '0';
   signal key_plus : std_logic := '0';
   signal key_minus : std_logic := '0';
   signal en_vector : std_logic_vector(1 downto 0) := (others => '0');
   signal key_action : std_logic := '0';
   signal key_reset : std_logic := '0';

 	--Outputs
   signal lap_active : std_logic;
   signal sw_time : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_10k_period : time := 100 us;
   --constant clk_100_period : time := 10000 us;
   --constant clk_1_period : time := 1000000 us;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: stopwatch PORT MAP (
          clk_10k => clk_10k,
          --clk_100 => clk_100,
          --clk_1 => clk_1,
          key_plus => key_plus,
          key_minus => key_minus,
          en_vector => en_vector,
          key_action => key_action,
          key_reset => key_reset,
          lap_active => lap_active,
          sw_time => sw_time
        );

   -- Clock process definitions
   clk_10k_process :process
   begin
		clk_10k <= '0';
		wait for clk_10k_period/2;
		clk_10k <= '1';
		wait for clk_10k_period/2;
   end process;
 
--   clk_100_process :process
--   begin
--		clk_100 <= '0';
--		wait for clk_100_period/2;
--		clk_100 <= '1';
--		wait for clk_100_period/2;
--   end process;
-- 
--   clk_1_process :process
--   begin
--		clk_1 <= '0';
--		wait for clk_1_period/2;
--		clk_1 <= '1';
--		wait for clk_1_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 1000 ms;	
			key_reset <='1';
		wait for 8000 ms; --sw active
			key_reset <='0';
			key_plus <='1';
			en_vector <= "11";
		wait for 100 us;
			key_plus <= '0';
		wait for 5000 ms; --sw_on
			key_action <='1';
		wait for 100 us; 
			key_action <='0';
		wait for 11000 ms;  --sw_pause
			key_action <='1';
		wait for 100 us;
			key_action <='0';
		wait for 20000 ms;  --sw_unpause
			key_action <='1';
		wait for 100 us;
			key_action <='0';
		wait for 20000 ms;  --sw_reset
			key_plus <='1';
		wait for 100 us;
			key_plus <='0';
		wait for 20000 ms;  --sw_on
			key_minus <='1';
		wait for 100 us;
			key_minus <='0';
		wait for 20000 ms;  --sw_run
			key_action <='1';
		wait for 100 us;
			key_action <='0';
		wait for 20000 ms;  --sw_lap
			key_minus <='1';
		wait for 100 us;
			key_minus <='0';
		wait for 20000 ms;  --sw_unlap
			key_minus <='1';
		wait for 100 us;
			key_minus <='0';

      wait for clk_10k_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
