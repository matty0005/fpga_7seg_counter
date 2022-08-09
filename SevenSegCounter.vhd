----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Matthew Gilpin
-- 
-- Create Date: 09.08.2022 22:32:00
-- Design Name: 
-- Module Name: SevenSegCounter - Behavioral
-- Project Name: 
-- Target Devices: Xilinx XC7S25
-- Tool Versions: 
-- Description: 
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity SevenSegCounter is
    Port ( 
        ja : out STD_LOGIC_VECTOR (6 downto 0);
        btn: in STD_LOGIC_VECTOR (0 downto 0);
        led: out std_logic_vector (1 downto 0);
        clk : in STD_LOGIC
    );
end SevenSegCounter;

architecture Behavioral of SevenSegCounter is

component ButtonDetector port (
    clk : in STD_LOGIC;
    input : in STD_LOGIC;
    output : out std_logic 
);
end component;

component sevenSegDisp port (
    value : in STD_LOGIC_VECTOR (3 downto 0);
    display : out STD_LOGIC_VECTOR (6 downto 0)
);


end component;

signal number : std_logic_vector(3 downto 0) := "0000";
signal buttonState : std_logic := '0';
signal ledState: std_logic := '0';

-- Debounce stuff
constant maxCounterValue : natural := 12000000 / 5; -- 5hz

signal counter : natural range 0 to maxCounterValue;

signal counterState : std_logic := '1';
signal led2State : std_logic := '0';


begin

    sevenSeg : sevenSegDisp
        port map (
            display => ja,
            value => number
        );
        
   buttonEdge: ButtonDetector
        port map (
            clk => clk,
            input => btn(0),
            output => buttonState
        );
        
    btnCounter: process(clk) is
    begin
            if rising_edge(clk) then
            
            if buttonState = '1' and counterState = '1' then
                number <= std_logic_vector( unsigned(number) + 1 );
                
                ledState <= not ledState;
                
                -- Set state to 0.
                counterState <= '0';
                    
                    
            end if;
        
            if counter = maxCounterValue then
                led2State <= not led2State;
                counterState <= '1'; 
                counter <= 0;
            else 
                counter <= counter + 1;
            end if;
        end if;
        
        
    end process btnCounter;
    
    led(0) <= ledState;
    led(1) <= led2State;


end Behavioral;
