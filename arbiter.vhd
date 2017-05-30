library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

entity arbiter is
  Port (
    clock: in std_logic;
    reset: in std_logic;
    
    din1: 	in STD_LOGIC_VECTOR(53 downto 0);
    ack1: 	out STD_LOGIC;
    
    din2:	in std_logic_vector(53 downto 0);
    ack2:	out std_logic;
    
    dout:	out std_logic_vector(53 downto 0)
    );
end arbiter;

-- version 1
architecture Behavioral of arbiter is
  signal s_ack1, s_ack2 : std_logic;
  
begin  

  process (reset, clock)
    variable nilreq : std_logic_vector(50 downto 0):=(others => '0');
    variable cmd: std_logic_vector( 1 downto 0);
  begin
    if reset = '1' then
      s_ack1 <= '0';
      s_ack2 <= '0';
      dout <= (others => '0');
    elsif rising_edge(clock) then
      cmd:= din1(50 downto 50) & din2(50 downto 50);
      case cmd is      
        when "00" =>
          dout <= (others => '0');
          s_ack1 <= '0';
          s_ack2 <= '0';          
        when "01" =>
          if s_ack2 = '0' then
            dout <=  din2;
            s_ack2 <= '1';
          else
            dout <= (others => '0');
          end if;
        when "10" =>
          if s_ack1 = '0' then
            dout <=  din1;
            s_ack1 <= '1';
          else
            dout <= (others => '0');
          end if;
        when "11" =>
          if s_ack2 ='0' then
            dout <=  din2;
            s_ack2 <= '1';
          elsif s_ack1 ='0' then
            dout <=  din1;
            s_ack1 <= '1';
          else
            dout <= (others => '0');
          end if;
        when others =>
      end case;
    end if;
    ack1 <= s_ack1;
    ack2 <= s_ack2;
  end process;
end architecture Behavioral;   

