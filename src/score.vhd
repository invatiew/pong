----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:39:47 01/25/2015 
-- Design Name: 
-- Module Name:    score - Behavioral 
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

entity score is
    Port ( clk : in  STD_LOGIC;
           rst_n : in  STD_LOGIC;
           col_r1 : in  STD_LOGIC;
           col_r2 : in  STD_LOGIC;
           score_s1 : out  STD_LOGIC_VECTOR (7 downto 0);
           score_s2 : out  STD_LOGIC_VECTOR (7 downto 0));
end score;

architecture Behavioral of score is

signal score_s1_intern : STD_LOGIC_VECTOR (7 downto 0);
signal score_s2_intern : STD_LOGIC_VECTOR (7 downto 0);


begin

score_s1_proc: process (clk,rst_n)
  begin
    if rst_n = '0' then
      score_s1_intern <= x"00";
    elsif rising_edge(clk) then
      if col_r2 = '1' then
        score_s1_intern <= std_logic_vector(unsigned(score_s1_intern) + 1);
      end if;
    end if;
  end process;

score_s1 <= score_s1_intern;

score_s2_proc: process (clk,rst_n)
  begin
    if rst_n = '0' then
      score_s2_intern <= x"00";
    elsif rising_edge(clk) then
      if col_r1 = '1' then
        score_s2_intern <= std_logic_vector(unsigned(score_s2_intern) + 1);
      end if;
    end if;
  end process;

score_s2 <= score_s2_intern;
  
end Behavioral;

