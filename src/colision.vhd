----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:29:08 01/12/2015 
-- Design Name: 
-- Module Name:    colision - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity colision is
    generic (
          max_x : INTEGER := 640;
          max_y : integer := 360
    );
    Port ( clk : in  STD_LOGIC;
           rst_n : in  STD_LOGIC;
           posx_ball : in  STD_LOGIC_VECTOR (15 downto 0);
           posy_ball : in  STD_LOGIC_VECTOR (15 downto 0);
           posx_s1 : in  STD_LOGIC_VECTOR (15 downto 0);
           posy_s1 : in  STD_LOGIC_VECTOR (15 downto 0);
           posx_s2 : in  STD_LOGIC_VECTOR (15 downto 0);
           posy_s2 : in  STD_LOGIC_VECTOR (15 downto 0);
           collision_s1 : out  STD_LOGIC_vector(4 downto 0);
           collision_s2 : out  STD_LOGIC_vector(4 downto 0);
           collision_r1 : inout  STD_LOGIC;
           collision_r2 : inout  STD_LOGIC;
           collision_ro : out  STD_LOGIC;
           collision_ru : out  STD_LOGIC;
           start_round : out STD_LOGIC);
end colision;

architecture Behavioral of colision is

signal s1_x_hit : std_logic;
signal s2_x_hit : std_logic;
signal s1_y_hit : std_logic_vector(4 downto 0);
signal s2_y_hit : std_logic_vector(4 downto 0);

begin

s1_x_hit <= '1' when ((unsigned(posx_ball) - 10) = unsigned(posx_s1)) else '0';
s1_y_hit(0) <= '1' when (unsigned(posy_ball) < (unsigned(posy_s1)+40) and unsigned(posy_ball) >= (unsigned(posy_s1) + 32)) else '0';
s1_y_hit(1) <= '1' when (unsigned(posy_ball) < (unsigned(posy_s1)+32) and unsigned(posy_ball) >= (unsigned(posy_s1) + 24)) else '0';
s1_y_hit(2) <= '1' when (unsigned(posy_ball) < (unsigned(posy_s1)+24) and unsigned(posy_ball) >= (unsigned(posy_s1) + 16)) else '0';
s1_y_hit(3) <= '1' when (unsigned(posy_ball) < (unsigned(posy_s1)+16) and unsigned(posy_ball) >= (unsigned(posy_s1) + 8)) else '0';
s1_y_hit(4) <= '1' when (unsigned(posy_ball) < (unsigned(posy_s1)+8)  and unsigned(posy_ball) >= unsigned(posy_s1)) else '0';

col_s1 : process(clk,rst_n)
  begin
    if rst_n = '0' then
      collision_s1 <= b"00000";
    elsif rising_edge(clk) then
      if s1_x_hit = '1' and s1_y_hit(0) = '1' then
        collision_s1(0) <= '1';
      elsif s1_x_hit = '1' and s1_y_hit(1) = '1' then
        collision_s1(1) <= '1';
      elsif s1_x_hit = '1' and s1_y_hit(2) = '1' then
        collision_s1(2) <= '1';
      elsif s1_x_hit = '1' and s1_y_hit(3) = '1' then
        collision_s1(3) <= '1';
      elsif s1_x_hit = '1' and s1_y_hit(4) = '1' then
        collision_s1(4) <= '1';
      else 
        collision_s1 <= b"00000";
      end if;
    end if;
  end process;

s2_x_hit <= '1' when ((unsigned(posx_ball) + 10) = unsigned(posx_s2)) else '0';
s2_y_hit(0) <= '1' when (unsigned(posy_ball) < (unsigned(posy_s2)+40) and unsigned(posy_ball) >= (unsigned(posy_s2) + 32)) else '0';
s2_y_hit(1) <= '1' when (unsigned(posy_ball) < (unsigned(posy_s2)+32) and unsigned(posy_ball) >= (unsigned(posy_s2) + 24)) else '0';
s2_y_hit(2) <= '1' when (unsigned(posy_ball) < (unsigned(posy_s2)+24) and unsigned(posy_ball) >= (unsigned(posy_s2) + 16)) else '0';
s2_y_hit(3) <= '1' when (unsigned(posy_ball) < (unsigned(posy_s2)+16) and unsigned(posy_ball) >= (unsigned(posy_s2) + 8)) else '0';
s2_y_hit(4) <= '1' when (unsigned(posy_ball) < (unsigned(posy_s2)+8)  and unsigned(posy_ball) >= unsigned(posy_s2)) else '0';

col_s2 : process(clk,rst_n)
  begin
    if rst_n = '0' then
      collision_s2 <= b"00000";
    elsif rising_edge(clk) then
      if s2_x_hit = '1' and s2_y_hit(0) = '1' then
        collision_s2(0) <= '1';
      elsif s2_x_hit = '1' and s2_y_hit(1) = '1' then
        collision_s2(1) <= '1';
      elsif s2_x_hit = '1' and s2_y_hit(2) = '1' then
        collision_s2(2) <= '1';
      elsif s2_x_hit = '1' and s2_y_hit(3) = '1' then
        collision_s2(3) <= '1';
      elsif s2_x_hit = '1' and s2_y_hit(4) = '1' then
        collision_s2(4) <= '1';
      else 
        collision_s2 <= b"00000";
      end if;
    end if;
  end process;

col_r1 : process(clk,rst_n)
  begin
    if rst_n = '0' then
      collision_r1 <= '0';
    elsif rising_edge(clk) then
      if signed(posx_ball) <= 0 then
        collision_r1 <= '1';
      else 
        collision_r1 <= '0';
      end if;
    end if;
  end process;

col_r2 : process(clk,rst_n)
  begin
    if rst_n = '0' then
      collision_r2 <= '0';
    elsif rising_edge(clk) then
      if signed(posx_ball) >= max_x then
        collision_r2 <= '1';
      else 
        collision_r2 <= '0';
      end if;
    end if;
  end process;

start_round <= '1' when collision_r1 = '1' or collision_r2 = '1' else '0';


col_ro : process(clk,rst_n)
  begin
    if rst_n = '0' then
      collision_ro <= '0';
    elsif rising_edge(clk) then
      if signed(posy_ball) >= (max_y - 10) then
        collision_ro <= '1';
      else 
        collision_ro <= '0';
      end if;
    end if;
  end process;
  
col_ru : process(clk,rst_n)
  begin
    if rst_n = '0' then
      collision_ru <= '0';
    elsif rising_edge(clk) then
      if signed(posy_ball) <= 10 then
        collision_ru <= '1';
      else 
        collision_ru <= '0';
      end if;
    end if;
  end process;


end Behavioral;

