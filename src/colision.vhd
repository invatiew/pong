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
    Port ( clk : in  STD_LOGIC;
           rst_n : in  STD_LOGIC;
           posx_ball : in  STD_LOGIC_VECTOR (15 downto 0);
           posy_ball : in  STD_LOGIC_VECTOR (15 downto 0);
           posx_s1 : in  STD_LOGIC_VECTOR (15 downto 0);
           posy_s1 : in  STD_LOGIC_VECTOR (15 downto 0);
           posx_s2 : in  STD_LOGIC_VECTOR (15 downto 0);
           posy_s2 : in  STD_LOGIC_VECTOR (15 downto 0);
           collision_s1 : out  STD_LOGIC;
           collision_s2 : out  STD_LOGIC;
           collision_r1 : inout  STD_LOGIC;
           collision_r2 : inout  STD_LOGIC;
           collision_ro : out  STD_LOGIC;
           collision_ru : out  STD_LOGIC;
           start_round : out STD_LOGIC);
end colision;

architecture Behavioral of colision is

begin

col_s1 : process(clk,rst_n)
  begin
    if rst_n = '0' then
      collision_s1 <= '0';
    elsif rising_edge(clk) then
      if (unsigned(posx_ball) - 10) = unsigned(posx_s1) and unsigned(posy_ball) < (unsigned(posy_s1)+20) and unsigned(posy_ball) > (unsigned(posy_s1)-20) then
        collision_s1 <= '1';
      else 
        collision_s1 <= '0';
      end if;
    end if;
  end process;

col_s2 : process(clk,rst_n)
  begin
    if rst_n = '0' then
      collision_s2 <= '0';
    elsif rising_edge(clk) then
      if (unsigned(posx_ball) + 10) = unsigned(posx_s2) and unsigned(posy_ball) < (unsigned(posy_s2)+20) and unsigned(posy_ball) > (unsigned(posy_s2)-20) then
        collision_s2 <= '1';
      else 
        collision_s2 <= '0';
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
      if signed(posx_ball) >= 800 then
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
      if signed(posy_ball) >= 590 then
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

