----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:04:00 01/17/2019 
-- Design Name: 
-- Module Name:    and_gate - Behavioral 
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

entity and_gate is
    Port ( inp_1 : in  STD_LOGIC;
           inp_2 : in  STD_LOGIC;
           f : out  STD_LOGIC);
end and_gate;

architecture Behavioral of and_gate is

begin
	f<=	inp_1 and inp_2;
end Behavioral;

