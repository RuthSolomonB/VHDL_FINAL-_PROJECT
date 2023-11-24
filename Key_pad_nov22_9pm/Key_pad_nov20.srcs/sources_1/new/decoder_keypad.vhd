LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_bit.all;

ENTITY decoder_keypad IS
	PORT (
        clk : in std_logic;
        ay : in std_logic_vector(0 to 3);
        ax : out std_logic_vector(0 to 3);
        pos : out std_logic_vector(0 to 3);
        keypress : out std_logic;
        switch_to_enable : in std_logic
	);
END decoder_keypad;

ARCHITECTURE Behavioral OF decoder_keypad IS

component bclk is
        port (
            clkin : in std_logic;
            period : in integer;
            clkout : out std_logic
        );
    end component;
 
    component pwm is
        port (
            clk : in std_logic;
            period : in integer;
            duty : in integer;
            sig : out std_logic
        );
    end component;
    


 
    signal clk10us : std_logic := '0';
    signal check, noinput : std_logic := '0';
    signal xcoord : std_logic_vector(0 to 3) := not "0001";
    signal last_pos, new_pos : std_logic_vector(0 to 3);
    signal xycase : std_logic_vector(0 to 7) := "00000000"; -- concatination of the x and y intersection to posiition which button is being presed.
    signal timer : integer := 0;
    signal state_input, state : natural range 0 to 3;

    
    

    
begin
 
 
    C : bclk port map (clkin=>clk, period=>1000, clkout=>clk10us);
    
    P : pwm port map (clk=>clk, period=>500, duty=>10, sig=>check);
 
    ax <= xcoord;
    xycase <=   xcoord & ay   ;
    pos <= new_pos;
    
 
    process(clk10us)
    begin
        
        if rising_edge(clk10us) then
        if (switch_to_enable ='1') then
            if check = '0' then
                xcoord <= xcoord(1 to 3) & xcoord(0);
                case state is
                    when 0 => state <= 1;
                    when 1 => state <= 2;
                    when 2 => state <= 3;
                    when 3 => state <= 0;
                end case;
            else
                case xycase is
                    when "11101110" => 
                        new_pos <=  "0000";
                        noinput <= '0';
                        state_input <= 0;
                    when "11101101" =>
                        new_pos <=  "0001";
                        noinput <= '0';
                        state_input <= 0;
                    when "11101011" =>
                        new_pos <=  "0010";
                        noinput <= '0';
                        state_input <= 0;
                    when "11100111" =>
                        new_pos <=  "0011";
                        noinput <= '0';
                        state_input <= 0;
                    when "11011110" =>
                        new_pos <=  "0100";
                        noinput <= '0';
                        state_input <= 1;
                    when "11011101" =>
                        new_pos <=  "0101";
                        noinput <= '0';
                        state_input <= 1;
                    when "11011011" =>
                        new_pos <=  "0110";
                        noinput <= '0';
                        state_input <= 1;
                    when "11010111" =>
                        new_pos <=  "0111";
                        noinput <= '0';
                        state_input <= 1;
                    when "10111110" =>
                        new_pos <=  "1000";
                        noinput <= '0';
                        state_input <= 2;
                    when "10111101" =>
                        new_pos <=  "1001";
                        noinput <= '0';
                        state_input <= 2;
                    when "10111011" =>
                        new_pos <=  "1010";
                        noinput <= '0';
                        state_input <= 2;
                    when "10110111" =>
                        new_pos <=  "1011";
                        noinput <= '0';
                        state_input <= 2;
                    when "01111110" =>
                        new_pos <=  "1100";
                        noinput <= '0';
                        state_input <= 3;
                    when "01111101" =>
                        new_pos <=  "1101";
                        noinput <= '0';
                        state_input <= 3;
                    when "01111011" =>
                        new_pos <=  "1110";
                        noinput <= '0';
                        state_input <= 3;
                    when "01110111" =>
                        new_pos <=  "1111";
                        noinput <= '0';
                        state_input <= 3;
                    when others =>
                        if state = state_input then
                            noinput <= '1';
                        end if;
                end case;
            end if;
 
            if last_pos = new_pos and noinput = '0' then
                timer <= timer + 1;
                if timer >= 10000 then
                    keypress <= '1';
                    timer <= 0;
                else
                    keypress <= '0';
                end if;
            else
                keypress <= '0';
                timer <= 0;
            end if;
            last_pos <= new_pos;
        end if;
        end if;
    end process;
    



END Behavioral;
