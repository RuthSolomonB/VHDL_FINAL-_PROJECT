library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity segment_driver is
    Port ( display_A : in STD_LOGIC_VECTOR (3 downto 0);-- 4 bit input signals BCDs to be displayed
           segO : out STD_LOGIC_VECTOR (7 downto 0); -- segments
           anodes : out STD_LOGIC_VECTOR (3 downto 0); -- which of the 4 display to use
           clk : in STD_LOGIC;
           keypress_div: in std_logic;
           switch_for_display: in std_logic);

end segment_driver;

architecture Behavioral of segment_driver is

component BCD_Segment_decoder 
    Port ( segments_for_digit : out STD_LOGIC_VECTOR (7 downto 0); -- gives the lighting
           Digit : in STD_LOGIC_VECTOR (3 downto 0));
end component;

component bclk is
    port (
        clkin: in std_logic;
        period: in integer;
        clkout: out std_logic
    );
end component;

signal temp_data : std_logic_vector (3 downto 0);
signal clk_word : std_logic_vector (15 downto 0);
signal slow_clk: std_logic;
signal d_clk: natural range 0 to 100000000;
signal Decode_data: std_logic_vector (6 downto 0);
signal clk40ms: std_logic;
signal segpos: std_logic_vector (1 downto 0);
signal whole_4_digit_display: std_logic_vector (31 downto 0):= "11111111111111111111111111111111";
signal segO_signal: STD_LOGIC_VECTOR (7 downto 0); 

begin

C: bclk port map(clkin=>clk, period => 4000, clkout => clk40ms);

   process(clk40ms)
   begin   
    if rising_edge (clk40ms) then

    case segpos is
        when "00" =>
            anodes <="1110"; -- anode to turn on
            segpos <= "01";  -- 
            segO <= whole_4_digit_display(31 downto 24);
        when "01" =>
            anodes <="1101";     
            segpos <= "10";  
            segO <= whole_4_digit_display(23 downto 16);
        when "10" =>
             anodes <="1011";     
             segpos <= "11";  
             segO <= whole_4_digit_display(15 downto 8);
        when "11" =>
            anodes <="0111";  
            segpos <= "00";     
            segO <= whole_4_digit_display(7 downto 0);
        end case;


        end if;
end process;

process (keypress_div)
begin
if rising_edge (keypress_div) then
    whole_4_digit_display <= ( segO_signal & whole_4_digit_display(31 downto 8) );

end if;

end process;

BDS1: BCD_Segment_decoder port map( segments_for_digit => segO_signal, Digit => display_A );

--segO <= segO_signal;

--d_clk <= 0 when d_clk = 100000000; -- reset the clock

-- process(clk)
--begin

--if rising_edge (clk) then
-- d_clk <= d_clk+1;
 
-- if (d_clk = 100000000) then
-- d_clk <= 0;
-- end if;
--end if;
--end process;
--uut1: clock_divisor PORT MAP ( 
--           clk =>clk,
--           enable=>'1', -- hardcoded b/c we want it to run all the time, to slow down clk of fpga
--           reset =>'0'
--           --d_clk =>clk_word
--                   );

--slow_clk <= clk_word(15); -- slow clk for later use in multiplexer


--process (slow_clk)
--variable dislay_selection : std_logic_vector (1 downto 0); 

--begin

--if  slow_clk'event and slow_clk='1' then

--case dislay_selection is

--when "00" => temp_data <= display_A; -- THE ANODEM, POSITION WHERE NUMBER IS TO DISPLAYED ON
--    select_dis_A <= '0';
--    select_dis_B <= '1';
--    select_dis_C <= '1';
--    select_dis_D <= '1';   
--    dislay_selection := dislay_selection+1;
    
--    when "01" => temp_data <= display_B; -- THE ANODEM, POSITION WHERE NUMBER IS TO DISPLAYED ON
--    select_dis_A <= '1';
--    select_dis_B <= '0';
--    select_dis_C <= '1';
--    select_dis_D <= '1';   
--    dislay_selection := dislay_selection+1;
    
--    when "10" => temp_data <= display_C; -- THE ANODEM, POSITION WHERE NUMBER IS TO DISPLAYED ON
--    select_dis_A <= '1';
--    select_dis_B <= '1';
--    select_dis_C <= '0';
--    select_dis_D <= '1';   
--    dislay_selection := dislay_selection+1;
    
--    when others => temp_data <= display_D; -- THE ANODEM, POSITION WHERE NUMBER IS TO DISPLAYED ON
--    select_dis_A <= '1';
--    select_dis_B <= '1';
--    select_dis_C <= '1';
--    select_dis_D <= '0';   
--    dislay_selection := dislay_selection+1;

--end case;

--end if;

--end process;

--process (slow_clk)
--variable Decode_data: std_logic_vector (6 downto 0);
--begin

--    with display_A  select --------------------------------------------------------
--    Decode_data <= "1111110" when "0000", --0
--     "0110000" when "0001", --1
--     "1101101" when "0010", --2
--     "1111001" when  "0011",--3
--     "0110011" when "0100",--4
--     "1011011" when "0101",--5
--     "1011111" when "0110",--6
--     "1110000" when "0111",--7
--       "1111111" when "1000",--8
--      "1111011" when "1001" ,--9
--      "1110111" when "1010" ,--a
--     "0011111" when "1011" ,--b
--      "1001110" when "1100" ,--c
--       "0111101" when "1101" ,--d
--        "1001111" when "1110",--e
--       "1000111" when "1111" ;--f
    --when "others => Decode_data := "0111110";--error 'H'
   --end case;

   --segA <= not Decode_data; -- FOR ALL THE 7 PARTS OF THE SEGMENT

--end process;



  

end Behavioral;
