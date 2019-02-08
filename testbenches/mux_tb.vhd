--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:56:31 01/11/2019
-- Design Name:   
-- Module Name:   /nas/ei/home/ga53bog/Desktop/projlab/stop_watch/mux_tb.vhd
-- Project Name:  stop_watch
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: two_to_one_mux
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
 
ENTITY mux_tb IS
END mux_tb;
 
ARCHITECTURE behavior OF mux_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT two_to_one_mux
    PORT(
         x0 : IN  std_logic_vector(31 downto 0);
         x1 : IN  std_logic_vector(31 downto 0);
         s_active : IN  std_logic;
         f : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal x0 : std_logic_vector(31 downto 0) := (others => '0');
   signal x1 : std_logic_vector(31 downto 0) := (others => '0');
   --signal active : std_logic := '0';
	signal s_active : std_logic;

 	--Outputs
   signal f : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
--   uut: two_to_one_mux PORT MAP (
--          x0 => x0,
--          x1 => x1,
--          active => active,
--          f => f
--        );
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
--   stim_proc: process
--   begin		
--      -- hold reset state for 100 ns.
--      wait for 100 ns;	
--
--      wait for <clock>_period*10;
--
--      -- insert stimulus here 
--
--      wait;
--   end process;
mapping: two_to_one_mux port map(x0, x1, s_active, f);

   --Concurrent processes: using concurrency usually reduce 
	--the length of a test bench.
   process
   begin
      s_active <= '1';
      wait for 10 ns;
      s_active <= '0'; 
      wait for 10 ns;
   end process;

   process
      variable errCnt : integer := 0;
   begin
   --The "assert" keyword allows you to test certain 
   --conditions. In other words, the point of assertion is
   --to allow you to inspect what you expect.

   --TEST 1
      x0 <= "01010101010101010101010101010101";
      x1 <= "10000000100000001000000010000000";
      wait for 15 ns;
      if(s_active = '0') then 
         assert(f = "01010101010101010101010101010101") report "Error 2" severity error;
      else 
         assert(f = "10000000100000001000000010000000") report "Error 2" severity error;
      end if;

   --TEST 2
      x0 <= "10101010101010101010101010101010";
      x1 <= "10000000100000001000000010000000";
      wait for 10 ns;
      if(s_active = '0') then 
         assert(f = "10101010101010101010101010101010") report "Error 2" severity error;
      else 
         assert(f = "10000000100000001000000010000000") report "Error 2" severity error;
      end if;
      --------------------------------------------------
   end process;

END;
