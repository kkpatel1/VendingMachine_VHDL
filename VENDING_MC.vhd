----------------------------------------------------------------------------------
-- Company: IIT ROORKEE
-- Engineer: Kartik Patel
-- 
-- Create Date:    10:18:30 03/21/2014 
-- Design Name: 	 Vending Machine
-- Module Name:    VENDING_MC - Behavioral 
-- Project Name: 	Vending Machine
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
----------------------------------------------------------------------------------
-- Question:
-- Vending m/c accepts 5 Rs. and 10 Rs. Coins. and will dispense the coke when >=15 Rs. are Deposited.
-- Assume that it don't give change.
	
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity VENDING_MC is
	port(F : in std_logic;									--5 Rs Coin Signal
		  T : in std_logic;									--10 Rs Coin Signal
		  CLK : in std_logic;
		  RESET : in std_logic;								--RESeT Button
		  output : out std_logic := '0');				--output = 1 for dispense of coke: signal to shutter to open
end VENDING_MC;

architecture Behavioral of VENDING_MC is
signal PS0, PS1 : std_logic :='0';						--Present State values: PS : "00" shows 0 Rs. and "11" shows >=15 Rs.
signal NS0, NS1 : std_logic;								--Next State : After clock'event will change PS
begin
	pmain: process(CLK, NS0, NS1, T, F, RESET)
		begin
			if RESET = '1' then
				PS1 <= '0';
				PS0 <= '0';
				output <='0';
			else
				NS1 <= (PS1 and (not PS0)) or (T and (not F) and (not PS1)) or ((not T) and F and (not PS1) and PS0);
				NS0 <= ((not PS1) and PS0 and (T or (not F))) or ((not PS1) and (not PS0) and (not T) and F) or (PS1 and (not PS0) and (T xor F));
				if CLK'event and CLK='1' then
					PS1 <= NS1;
					PS0 <= NS0;
					output <= PS1 and PS0;
					if PS1='1' and PS0='1' then
						PS1 <= '0';
						PS0 <= '0';
					end if;
				end if;
			end if;
	end process;
end Behavioral;