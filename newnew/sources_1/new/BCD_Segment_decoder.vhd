library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity BCD_Segment_decoder is
    Port ( segments_for_digit : out STD_LOGIC_VECTOR (7 downto 0);
           Digit : in STD_LOGIC_VECTOR (3 downto 0));
end BCD_Segment_decoder;

architecture Behavioral of BCD_Segment_decoder is

begin

process(Digit)
    variable Decode_data: std_logic_vector (6 downto 0);
begin
 case Digit is -- DIGIT IS THE MATRIX POSITION OF THE NUMBER ON THE KEYPAD, THE NUMBER LOCATED AT 0000->1, AT 0001->4..... 
    when "1111" => Decode_data := "0110000";--1
    when "1110" => Decode_data := "0110011";--4
    when "1101" => Decode_data := "1110000";--7
    when "1100" => Decode_data := "1111110";--0
    when "1011" => Decode_data := "1101101";--2
    when "1010" => Decode_data := "1011011";--5
    when "1001" => Decode_data := "1111111";--8
    when "1000" => Decode_data := "1000111";--f
    when "0111" => Decode_data := "1111001";--3
    when "0110" => Decode_data := "1011111";--6
    when "0101" => Decode_data := "1111011";--9
    when "0100" => Decode_data := "1001111";--e
    when "0011" => Decode_data := "1110111";--a
    when "0010" => Decode_data := "0011111";--b
    when "0001" => Decode_data := "1001110";--c
    when "0000" => Decode_data := "0111101";--d
    --when "others => Decode_data := "0111110";--error 'H'
   end case;
  
   
   
   segments_for_digit(0) <= not Decode_data(6); -- FOR ALL THE 7 PARTS OF THE SEGMENT
   segments_for_digit(1) <= not Decode_data(5);
   segments_for_digit(2) <= not Decode_data(4);
   segments_for_digit(3) <= not Decode_data(3);
   segments_for_digit(4) <= not Decode_data(2);
   segments_for_digit(5) <= not Decode_data(1);
   segments_for_digit(6) <= not Decode_data(0);
   segments_for_digit(7) <= '1';
   
   
end process;

end Behavioral;









