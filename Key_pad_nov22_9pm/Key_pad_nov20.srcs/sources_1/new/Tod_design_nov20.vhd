library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Tod_design_nov20 is
    Port (
           clk : in STD_LOGIC;
           --reset : in STD_LOGIC;
           topanodes: out STD_LOGIC_vector (3 downto 0);
           JA :inout STD_LOGIC_VECTOR (7 downto 0); -- input from the keypad
           topseg : out STD_LOGIC_VECTOR (7 downto 0);
           switch_top: in std_logic;
           LED_correct: out std_logic);

end Tod_design_nov20;

architecture Behavioral of Tod_design_nov20 is
signal Decode: STD_LOGIC_VECTOR (3 downto 0);
signal Keypress_top: STD_LOGIC;
signal Ai:  STD_LOGIC_VECTOR (3 downto 0);
--signal State, NextState: integer range 0 to 3;
--signal BCD3, BCD2, BCD1, BCD0: std_logic_vector(3 downto 0);
--signal multiplex_counter: integer range 0 to 3 := 0;
signal top_anode_signal: std_logic_vector (3 downto 0);
signal top_individual_pw_check: std_logic;

component segment_driver is
    Port ( display_A : in STD_LOGIC_VECTOR (3 downto 0);-- 4 bit input signals BCDs to be displayed -- disval
           segO : out STD_LOGIC_VECTOR (7 downto 0); -- segments -- segout
           anodes : out STD_LOGIC_VECTOR (3 downto 0); -- which of the 4 display to use -- anode
           clk : in STD_LOGIC;
           keypress_div: in STD_LOGIC;
           switch_for_display: in std_logic); 
end component; -- digits_to_display ???

component decoder_keypad is
	port( 	clk : in std_logic ;
	      	ay : in std_logic_vector(3 downto 0);
		ax : out std_logic_vector(3 downto 0);
		pos : out std_logic_vector(3 downto 0);
		keypress: out std_logic;
		switch_to_enable : in std_logic
		);
end component;

    component Password_states is
    Port ( key_press_state : in STD_LOGIC;
   -- password_individual :  STD_LOGIC;
           num_to_be_checked : in STD_LOGIC_vector(3 downto 0);
           light_switch_state : in std_logic;
           correct_or_no: out std_logic);
end component;

begin

-- get sinput from the key pad and gives it to be decoded into a 4 bit binary called "Decode"
C0: decoder_keypad port map (clk=>clk, ay =>JA(7 downto 4), ax =>JA(3 downto 0), pos=> Decode, keypress=>Keypress_top, switch_to_enable=>switch_top); 

-- The "Decode" value is given to this component at certain clock time so that the position and the segment displays are returned.
uut2: segment_driver PORT MAP( display_A => Decode, segO => topseg, anodes => top_anode_signal , clk => clk, keypress_div=>Keypress_top, switch_for_display=>switch_top);

-- this checks password insertion on each step and ultimately checks the sequence of passwords we entered
--psw1: Password_states port map( key_press_state => Keypress_top, num_to_be_checked =>Decode, light_switch_state=>switch_top, correct_or_no=>LED_correct);
--password_individual=>top_individual_pw_check ,

topanodes <= top_anode_signal when  switch_top = '1' else "1111"; -- when the enable switch is on, it transmitts the keypad signal, else it disconnects from the keypad

--process (Keypress_top)
--begin
--if rising_edge (Keypress_top) then
-- if switch_top = '0' then
--     topseg <= "11111111";

--end if ;
--end if;

--end process;

--Ai <= Decode;

--    process(clk, reset)
--    begin
--        if reset = '1' then
--            State <= 0;
--            --multiplex_counter <= 0;
--        elsif clk'event and clk = '1' then
--            State <= NextState;
--        end if;
--    end process;

--    process(State)
--    begin
--        --if clk'event and clk = '1' then
--            case State is
--                when 0 =>
--                    if Keypress_top = '1' then
--                        --anodes <= "0111";
--                        Ai <= Decode;
--                        State <= 1;
--                        --m <= 15; l <= 12;    
--                   end if;
               
--                when 1 =>    
--                   if Keypress_top = '1' then
--                       -- anodes <= "0011";
--                        Ai <= Decode;
--                        State <= 2; 
--                        --m <= 11; l <= 8;   
--                   end if;
               
--                when 2 =>     
--                   if Keypress_top = '1' then
--                        --anodes <= "0001";
--                        Ai <= Decode;
--                        State <= 3;
--                        --m <= 7; l <= 4;   
--                   end if;
               
--                when 3 =>     
--                   if Keypress_top = '1' then
--                        --anodes <= "0000";
--                        Ai <= Decode;
--                        --State <= 4;
--                        --m <= 3; l <= 0;  
--                   end if;
--                end case; 
--    end process;

end Behavioral;
