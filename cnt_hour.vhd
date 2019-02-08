----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:15:49 01/23/2019 
-- Design Name: 
-- Module Name:    cnt_hour - Behavioral 
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


entity cnt_hour is
    Port ( clk : in  STD_LOGIC;
           en : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  pause : in STD_LOGIC;
           q_hour : out  STD_LOGIC_VECTOR (7 downto 0)
			  );
end cnt_hour;

architecture Behavioral of cnt_hour is
	signal p_ones, p_tens: std_logic_vector(3 downto 0);
	signal p_cnt: std_logic_vector(25 downto 0) := (others=> '0');	
begin
	
	process(clk)
	begin
	if clk'EVENT and clk='1' then
		if (reset = '1') then --if rst=1 set all values back to zero...
			p_ones <= (others=> '0');
			p_tens <= (others=> '0');
			p_cnt <= (others=> '0');
		elsif (en = '1') then
			if pause = '1' then
				p_ones <= p_ones;
				p_tens <= p_tens;
				p_cnt <= p_cnt;
			else
				p_cnt <= p_cnt + 1;
				if p_cnt = "10001001010101000100000000" then
					if p_ones="1001" then
						p_ones<="0000";
						if p_tens="1001" then
							p_tens <="0000";
						else p_tens <= p_tens + 1;
						end if;
					else p_ones <= p_ones +1; 
					end if;
					p_cnt<= (others=> '0');
				end if;
			end if; 
		end if;
	end if;	
	end process;
	
	q_hour <= p_tens & p_ones; 

end Behavioral;

