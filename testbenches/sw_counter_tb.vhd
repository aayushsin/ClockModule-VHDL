--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:37:45 01/24/2019
-- Design Name:   
-- Module Name:   /nas/ei/home/ga53bog/Desktop/projlab/stop_watch/sw_counter_tb.vhd
-- Project Name:  stop_watch
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sw_counter
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
 
ENTITY sw_counter_tb IS
END sw_counter_tb;
 
ARCHITECTURE behavior OF sw_counter_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sw_counter
    PORT(
         clk_100 : IN  std_logic;
         clk_1 : IN  std_logic;
         en : IN  std_logic;
         s_pause : IN  std_logic;
         reset : IN  std_logic;
         q_time : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_100 : std_logic := '0';
   signal clk_1 : std_logic := '0';
   signal en : std_logic := '0';
   signal s_pause : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal q_time : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_100_period : time := 0.02 ns;
   constant clk_1_period : time := 2 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sw_counter PORT MAP (
          clk_100 => clk_100,
          clk_1 => clk_1,
          en => en,
          s_pause => s_pause,
          reset => reset,
          q_time => q_time
        );

   -- Clock process definitions
   clk_100_process :process
   begin
		clk_100 <= '0';
		wait for clk_100_period/2;
		clk_100 <= '1';
		wait for clk_100_period/2;
   end process;
 
   clk_1_process :process
   begin
		clk_1 <= '0';
		wait for clk_1_period/2;
		clk_1 <= '1';
		wait for clk_1_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		reset <='1';
      wait for 100 ns;
			reset <='0';
		wait for 2 ns;
			en <='1';
		wait for 5000 ns;
			s_pause <= '1';
		wait for 8000 ns;
			s_pause <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
