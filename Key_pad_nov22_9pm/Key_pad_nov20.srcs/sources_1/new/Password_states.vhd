library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Password_states is
    Port ( key_press_state : in STD_LOGIC;
           --password_individual : out STD_LOGIC;
            num_to_be_checked : in STD_LOGIC_VECTOR (3 downto 0);
           light_switch_state : in std_logic;
           correct_or_no: out std_logic);
end Password_states;

architecture Behavioral of Password_states is

    type passwors_state is (pw0, pw1, pw2, pw3);
    signal Present_password, Next_password, Output : passwors_state;
    
    signal correct_password: std_logic_vector (31 downto 0):="00000000000000000000000000000000"; -- correct password is 0000----------------------
    signal is_correct: std_logic_vector (3 downto 0);
    --signal correct_or_no: std_logic;
    
begin

process(key_press_state)
begin

IF rising_edge(key_press_state) THEN
	IF light_switch_state = '0' THEN
		Present_password <= pw1;

	ELSE
		Present_password <= Next_password;

	END IF;

END IF;

end process;

process(Present_password,key_press_state, num_to_be_checked)
begin

--password_individual <= '0'; num_to_be_checked

is_correct <= "0000";
case (Present_password) is 

when pw0 =>
IF (num_to_be_checked = "0000") THEN
Next_password <= pw1;
is_correct(0) <= '1';
end if;

when pw1=>
IF (num_to_be_checked = "0000") THEN
Next_password <= pw2;
is_correct(1) <= '1';
end if;

when pw2=>
IF (num_to_be_checked = "0000") THEN
Next_password <= pw3;
is_correct(2) <= '1';
end if;

when pw3=>
IF (num_to_be_checked = "0000") THEN
is_correct(3) <= '1';

end if;

end case;

if (is_correct = "1111") then
correct_or_no <= '1';
else 
correct_or_no <= '0';
end if;

end process;




end Behavioral;
