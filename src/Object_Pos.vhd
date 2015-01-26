----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:09:13 01/12/2015 
-- Design Name: 
-- Module Name:    Object_Pos - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Object_Pos is

	generic (	def_x: INTEGER;
						def_y: INTEGER);
    Port ( Vx_in : in  STD_LOGIC;
           Vy_in : in  STD_LOGIC;
           Vx_out : out  STD_LOGIC;
           Vy_out : out  STD_LOGIC;
           Px : out  STD_LOGIC;
           Py : out  STD_LOGIC;
			  Clk : in  STD_LOGIC;
           rst_n : in  STD_LOGIC);
end Object_Pos;

architecture Behavioral of Object_Pos is

begin
--Start des Spiels
	init_proc : process(rst_n)
	begin
		if rst_n = '0' then
			Px <= def_x;
			Py <= def_y;
			end if;
	end process;
	
--Positionsänderung in X-Richtung
	x_proc : process(clk)
	begin
		if Vx_in /= '0' then
			Px <= std_logic_vector(unsigned(Px(14 downto 0)) + unsigned(Vx_in(14 downto 0)));
		end if;
	end process;
	
--Positionsänderung in Y-Richtung
	y_proc : process(clk)
	begin
		if Vy_in /= '0' then
			Py <= std_logic_vector(unsigned(Py(14 downto 0)) + unsigned(Vy_in(14 downto 0)));
		end if;
	end process;
	
--Ausgabe Geschwindigkeit
	outgabe : process(clk)
	begin
		if rising_edge (clk) then
			Vx_out <= Vx_in;
			Vy_out <= Vy_in;
		end if;
	end process;

end Behavioral;

