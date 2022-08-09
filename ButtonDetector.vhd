----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Matthew Gilpin
-- 
-- Create Date: 09.08.2022 23:14:19
-- Design Name: 
-- Module Name: ButtonDetector - Behavioral
-- 
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ButtonDetector is
    Port ( clk : in STD_LOGIC;
           input : in STD_LOGIC;
           output : out STD_LOGIC);
end ButtonDetector;

architecture Behavioral of ButtonDetector is

signal ffOne : std_logic;
signal ffTwo : std_logic;

begin

detect: process(clk) is

    begin
    
        if rising_edge(clk) then
            ffOne <= input;
            ffTwo <= ffOne;
        end if;
        
end process detect;

output <= (not ffTwo) and ffOne;


end Behavioral;
