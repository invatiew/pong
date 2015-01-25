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
           col_ro : in std_logic;
           col_ru : in std_logic;
           ball_vx_in : in  STD_LOGIC_VECTOR (15 downto 0);
           ball_vy_in : in  STD_LOGIC_VECTOR (15 downto 0);
           ball_vx_out : out  STD_LOGIC_VECTOR (15 downto 0);
           ball_vy_out : out  STD_LOGIC_VECTOR (15 downto 0));
end ball_speed;

architecture Behavioral of ball_speed is

begin

ball_vx_out <= not ball_vx_in(15) & ball_vx_in(14 downto 0) when col_s1 = '1' or col_s2 = '1' else ball_vx_in(15) & ball_vx_in(14 downto 0);
ball_vy_out <= not ball_vy_in(15) & ball_vy_in(14 downto 0) when col_ru = '1' or col_ro = '1' else ball_vy_in(15) & ball_vy_in(14 downto 0);

end Behavioral;

