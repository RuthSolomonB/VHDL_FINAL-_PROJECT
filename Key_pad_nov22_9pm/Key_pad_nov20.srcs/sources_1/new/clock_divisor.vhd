----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2023 07:18:58 PM
-- Design Name: 
-- Module Name: clock_divisor - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_divisor is
    port (
        clkin: in std_logic;
        period: in integer;
        clkout: out std_logic
    );
end clock_divisor;

architecture Behavioral of clock_divisor is

--    process (clk, reset) -- 
--     variable count: std_logic_vector (15 downto 0):= (others =>'0');
--     begin
--        if(reset ='1') then
--        count := (others =>'0');
--        elsif enable ='1' and clk'event and clk='1' then
--        count := count +1;
--        end if;
        
--     d_clk <= count;
--     end process;
     
     
--     process(clk)
--     variable d_clk: natural range 0 TO 100000000;
begin
--if rising_edge (clk) then
--    d_clk := d_clk+1;
--    if d_clk = 25000000 then
--    anode <= "1110";
--    elsif d_clk = 50000000 then
--    anode <= "1101";
--    elsif d_clk = 75000000 then
--    anode <= "1011";
--    else
--    anode <= "0111";
--    end if;
--    end if;
--end process;

--process (clk, reset) -- 
--     variable count: numeric range ;
--     begin
--        if(reset ='1') then
--        count := (others =>'0');
--        elsif enable ='1' and clk'event and clk='1' then
--        count := count +1;
--        end if;
        
--     d_clk <= count;
--     end process;

-- signal count: integer;
--    signal clkint: std_logic;
--begin
--    process(clkin)
--    begin
--        count <= count + 1;
--        if clkin'event and clkin = '1' then
--            if count = period then
--                count <= 0;
--                clkint <= not clkint;
--            end if;
--        end if;
--    end process;
--    clkout <= clkint;
     
     
     
     
     
end Behavioral;
