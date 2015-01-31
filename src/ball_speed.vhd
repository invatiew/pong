----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:38:07 01/12/2015 
-- Design Name: 
-- Module Name:    ball_speed - Behavioral 
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

entity ball_speed is
    Port ( clk : in  STD_LOGIC;
           rst_n : in  STD_LOGIC;
           col_s1 : in  STD_LOGIC_vector(4 downto 0);
           col_s2 : in  STD_LOGIC_vector(4 downto 0);
           col_ro : in std_logic;
           col_ru : in std_logic;
           ball_vx_in : in  STD_LOGIC_VECTOR (15 downto 0);
           ball_vy_in : in  STD_LOGIC_VECTOR (15 downto 0);
           ball_vx_out : out  STD_LOGIC_VECTOR (15 downto 0);
           ball_vy_out : out  STD_LOGIC_VECTOR (15 downto 0));
end ball_speed;

architecture Behavioral of ball_speed is

signal col_x_s1 : std_logic;
signal col_x_s2 : std_logic;

begin
  
col_x_s1 <= '1' when (col_s1(0) = '1' or col_s1(1) = '1' or col_s1(2) = '1' or col_s1(3) = '1' or col_s1(4) = '1') else '0';
col_x_s2 <= '1' when (col_s2(0) = '1' or col_s2(1) = '1' or col_s2(2) = '1' or col_s2(3) = '1' or col_s2(4) = '1') else '0';

  
ball_vx_out <= not ball_vx_in(15) & ball_vx_in(14 downto 0) when col_x_s1 = '1' or col_x_s2 = '1' else ball_vx_in(15) & ball_vx_in(14 downto 0);

ball_vy_proc : process (col_ru ,col_ro ,ball_vy_in ,col_s2)
  begin
    if col_ru = '1' then
      ball_vy_out <= not ball_vy_in(15) & ball_vy_in(14 downto 0);
    elsif col_ro = '1' then
      ball_vy_out <= not ball_vy_in(15) & ball_vy_in(14 downto 0);
    elsif col_s2(0) = '1' then
      ball_vy_out <= X"8100";
    elsif col_s2(1) = '1' then
      ball_vy_out <= X"8080";
    elsif col_s2(2) = '1' then
      ball_vy_out <= X"0000";
    elsif col_s2(3) = '1' then
      ball_vy_out <= X"0080";
    elsif col_s2(4) = '1' then
      ball_vy_out <= X"0100";
    else
      ball_vy_out <= ball_vy_in;
    end if;
  end process;

end Behavioral;

