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
           col_s1 : in  STD_LOGIC;
           col_s2 : in  STD_LOGIC;
           ball_vx_in : in  STD_LOGIC_VECTOR (15 downto 0);
           ball_vy_in : in  STD_LOGIC_VECTOR (15 downto 0);
           ball_vx_out : out  STD_LOGIC_VECTOR (15 downto 0);
           ball_vy_out : out  STD_LOGIC_VECTOR (15 downto 0));
end ball_speed;

architecture Behavioral of ball_speed is

begin

ball_vx : process (clk,rst_n)
  begin
    if rst_n = '0' then
      ball_vx_out <= x"0004";
      ball_vy_out <= x"0000";
    elsif rising_edge(clk) then
      if col_s1 = '1' or col_s2 = '1' then
        ball_vx_out(15) <= not ball_vx_in(15);
      end if;
    end if;
  end process;

end Behavioral;

