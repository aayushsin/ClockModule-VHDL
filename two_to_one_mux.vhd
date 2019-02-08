----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:51:06 01/11/2019 
-- Design Name: 
-- Module Name:    two_to_one_mux - Behavioral 
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

entity two_to_one_mux is
    Port ( x0 : in  STD_LOGIC_VECTOR (31 downto 0);
           x1 : in  STD_LOGIC_VECTOR (31 downto 0);
           s_active : in  STD_LOGIC;
           f : out  STD_LOGIC_VECTOR (31 downto 0));
end two_to_one_mux;

architecture Behavioral of two_to_one_mux is

begin
f<=	x1 when(s_active='1')else
		x0 when(s_active='0')else
		"00000000000000000000000000000000";

end Behavioral;

