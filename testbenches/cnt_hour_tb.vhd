--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:22:23 01/24/2019
-- Design Name:   
-- Module Name:   /nas/ei/home/ga53bog/Desktop/projlab/stop_watch/cnt_hour_tb.vhd
-- Project Name:  stop_watch
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cnt_hour
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
 
ENTITY cnt_hour_tb IS
END cnt_hour_tb;
 
ARCHITECTURE behavior OF cnt_hour_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT cnt_hour
    PORT(
         clk : IN  std_logic;
         en : IN  std_logic;
         reset : IN  std_logic;
         pause : IN  std_logic;
         q_hour : OUT  std_logic_vector(7 downto 0)
         --q_rco : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal en : std_logic := '0';
   signal reset : std_logic := '0';
   signal pause : std_logic := '0';

 	--Outputs
   signal q_hour : std_logic_vector(7 downto 0);
   --signal q_rco : std_logic;

   -- Clock period definitions
   constant clk_period : time := 0.02	ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: cnt_hour PORT MAP (
          clk => clk,
          en => en,
          reset => reset,
          pause => pause,
          q_hour => q_hour
          --q_rco => q_rco
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
		reset <='1';
      wait for 200 ns;
			reset <='0';
		wait for 200 ns;
			en <='1';
		wait for 2 ms;
		 pause <= '1';
		wait for 3 ms;
			pause <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
