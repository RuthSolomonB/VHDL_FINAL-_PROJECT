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
           switch_to_enable : in std_logic;
           light : out std_logic);

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
            anodes <="1110";
            segpos <= "01";  
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
if (switch_to_enable = '1') then
        light <='1';
    whole_4_digit_display <= ( segO_signal & whole_4_digit_display(31 downto 8));
    
    elsif (switch_to_enable = '0') then
    light <='0';
    whole_4_digit_display<= "11111111111111111111111111111111";
end if ;
    
end if;

end process;

BDS1: BCD_Segment_decoder port map( segments_for_digit => segO_signal, Digit => display_A );


end Behavioral;
