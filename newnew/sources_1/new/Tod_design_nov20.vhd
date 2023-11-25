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
           LED_disp_on: out std_logic;
           --pw_led: out std_logic;
           right: out std_logic:='0';
           wrong: out std_logic:='0';
           check_lihgts_lastfew: out std_logic_vector(3 downto 0));

end Tod_design_nov20;

architecture Behavioral of Tod_design_nov20 is
signal Decode: STD_LOGIC_VECTOR (3 downto 0);
signal Keypress_top: STD_LOGIC;
--signal Ai:  STD_LOGIC_VECTOR (3 downto 0);
--signal State, NextState: integer range 0 to 3;
--signal BCD3, BCD2, BCD1, BCD0: std_logic_vector(3 downto 0);
--signal multiplex_counter: integer range 0 to 3 := 0;
signal checked_pw_state: std_logic;
signal keypress_and_switch: std_logic;
signal red_green_light: std_logic;
signal final_light : std_logic_VECTOR (3 downto 0);

component segment_driver is
    Port ( display_A : in STD_LOGIC_VECTOR (3 downto 0);-- 4 bit input signals BCDs to be displayed -- disval
           segO : out STD_LOGIC_VECTOR (7 downto 0); -- segments -- segout
           anodes : out STD_LOGIC_VECTOR (3 downto 0); -- which of the 4 display to use -- anode
           clk : in STD_LOGIC;
           keypress_div: in STD_LOGIC;
           switch_to_enable : in std_logic;
		   light : out std_logic); -- clk
end component; -- digits_to_display ???

component decoder_keypad is
	port( 	clk : in std_logic ;
	      	ay : in std_logic_vector(0 to 3);
        ax : out std_logic_vector(0 to 3);
        pos : out std_logic_vector(0 to 3);
		keypress: out std_logic
		);
end component;

component Password_check is
    Port ( number_pw : in STD_LOGIC_VECTOR (3 downto 0);
           pressed_key: in std_logic;
           result: out std_logic;
           led_ckeck: out std_logic_vector(3 downto 0));
end component;

begin

-- get sinput from the key pad and gives it to be decoded into a 4 bit binary called "Decode"
C0: decoder_keypad port map (clk=>clk, ay =>JA(7 downto 4), ax =>JA(3 downto 0), pos=> Decode, keypress=>Keypress_top); 

-- The "Decode" value is given to this component at certain clock time so that the position and the segment displays are returned.
uut2: segment_driver PORT MAP( display_A => Decode, segO => topseg, anodes => topanodes , clk => clk, keypress_div=>Keypress_top,
                                switch_to_enable=>switch_top, light=>LED_disp_on);

pwc: Password_check port map(number_pw=> Decode, pressed_key=> keypress_and_switch,result=> red_green_light, led_ckeck => final_light);

keypress_and_switch <= Keypress_top and switch_top;


--final_light => check_lihgts_lastfew;



right <= '1' when final_light <= "1111"
          else '0';

wrong <= '1' when final_light <= NOT "1111"
            else '0';

--pw_led => red_green_light;


--right <= '1' when Decode <= "0000"
--            else '0';
            
--wrong <= '1' when red_green_light <= '0'
--            else '0';



end Behavioral;
