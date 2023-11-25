----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/24/2023 01:45:21 AM
-- Design Name: 
-- Module Name: Password_check - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Password_check is
    Port ( number_pw : in STD_LOGIC_VECTOR (3 downto 0);
           pressed_key: in std_logic;
           result: out std_logic;
           led_ckeck: out std_logic_vector(3 downto 0));
end Password_check;

architecture Behavioral of Password_check is
    --type passwors_state is (pw0, pw1, pw2, pw3);
    --signal Present_password, Next_password, Output : passwors_state;
    signal is_correct: std_logic :='1'; 
    signal correct_pw: STD_LOGIC_VECTOR (3 downto 0):= "0000";
    signal counter: integer:=0;
begin

process (pressed_key)
begin
    if (counter =0) and (correct_pw = "0000") then
    counter <= counter +1;
    led_ckeck(0) <='1';
     else
     is_correct <= '0';
    end if;
    
    if (counter =1) and (correct_pw = "0000") then
    counter <= counter +1;
    led_ckeck(1) <='1';
     else
     is_correct <= '0';
    end if;
    
    if (counter =2) and (correct_pw = "0000") then
    counter <= counter +1;
    led_ckeck(2) <='1';
     else
     is_correct <= '0';
    end if;
    
    if (counter =3) and (correct_pw = "0000") then
    counter <= counter +1;
    led_ckeck(3) <='1';
     else
     is_correct <= '0';
    end if;
 
end process;


result <= is_correct when counter = 4
            else '0';




end Behavioral;
