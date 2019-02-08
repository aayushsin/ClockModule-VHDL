--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:02:24 01/23/2019
-- Design Name:   
-- Module Name:   /nas/ei/home/ga53bog/Desktop/projlab/stop_watch/cnt_sec_tb.vhd
-- Project Name:  stop_watch
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cnt_sec
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
 
ENTITY cnt_sec_tb IS
END cnt_sec_tb;
 
ARCHITECTURE behavior OF cnt_sec_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT cnt_sec
    PORT(
         clk : IN  std_logic;
         en : IN  std_logic;
         reset : IN  std_logic;
			pause : in STD_LOGIC;
         --d_sec : IN  std_logic_vector(7 downto 0);
         q_sec : OUT  std_logic_vector(7 downto 0)
         --q_rco : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal en : std_logic := '0';
   signal reset : std_logic := '0';
	signal pause : std_logic := '0';
   --signal d_sec : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal q_sec : std_logic_vector(7 downto 0);
   --signal q_rco : std_logic;

   -- Clock period definitions
   constant clk_period : time := 0.02 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: cnt_sec PORT MAP (
          clk => clk,
          en => en,
          reset => reset,
          --d_sec => d_sec,
			 pause => pause,
          q_sec => q_sec
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
      wait for 20 ns;
			reset <='0';
		wait for 20 ns;
			en <='1';
		wait for 4000 ns;
		 pause <= '1';
		wait for 2000 ns;
			pause <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
