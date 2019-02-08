--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:12:19 01/17/2019
-- Design Name:   
-- Module Name:   /nas/ei/home/ga53bog/Desktop/projlab/stop_watch/and_gate_tb.vhd
-- Project Name:  stop_watch
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: and_gate
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
 
ENTITY and_gate_tb IS
END and_gate_tb;
 
ARCHITECTURE behavior OF and_gate_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT and_gate
    PORT(
         inp_1 : IN  std_logic;
         inp_2 : IN  std_logic;
         f : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal inp_1 : std_logic := '0';
   signal inp_2 : std_logic := '0';

 	--Outputs
   signal f : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
 --Instantiate the Unit Under Test (UUT)
   uut: and_gate PORT MAP (
          inp_1 => inp_1,
          inp_2 => inp_2,
          f => f
        );
--
--   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
-- 
--
--   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      --wait for 100 ns;	

       inp_1 <= '0';
		inp_2 <= '0';
      wait for 2 ns;
			inp_1 <= '1';
			inp_2 <= '0'; 
      wait for 2 ns;
			inp_1 <= '0';
			inp_2 <= '1';
      wait for 2 ns;
			inp_1 <= '1';
			inp_2 <= '1';
      wait;
   end process;

--mapping: and_gate port map(inp_1, inp_2, f);

   --Concurrent processes: using concurrency usually reduce 
	--the length of a test bench.
   --process
   --begin
     
   --end process;

END;
