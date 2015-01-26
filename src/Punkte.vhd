----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:33:08 01/12/2015 
-- Design Name: 
-- Module Name:    Punkte - Behavioral 
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

entity Punkte is
    Port ( Ran1 : in  STD_LOGIC;
           Ran2 : in  STD_LOGIC;
           Pkt1 : inout  STD_LOGIC_VECTOR (11 downto 0);
           Pkt2 : inout  STD_LOGIC_VECTOR (11 downto 0);
			  clk : in STD_LOGIC;
			  rst_n : in STD_LOGIC);
end Punkte;

architecture Behavioral of Punkte is

begin

--Start des Spiels
	init_proc : process(clk, rst_n)
	begin
			if rst_n = '0' then
				Pkt1 <= x"000";
				Pkt2 <= x"000";
			elsif rising_edge (clk) then
			
--Spieler 2 macht einen Punkt
				if Ran1='1' then
					Pkt2 <= std_logic_vector(unsigned(Pkt2) + 1);
				elsif Ran2='1' then
--Spieler 1 macht einen Punkt
					Pkt1 <= std_logic_vector(unsigned(Pkt1) + 1);
				end if;
				
			end if;
	end process;

end Behavioral;

