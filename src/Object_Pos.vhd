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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Object_Pos is

	generic (	def_x: INTEGER := 0;
						def_y: INTEGER := 0;
            def_vx : INTEGER := 0;
            def_vy : INTEGER := 0;
            max_x : INTEGER := 640;
            max_y : integer := 360
          );
    Port ( Vx_in : in  STD_LOGIC_vector (15 downto 0);
           Vy_in : in  STD_LOGIC_vector (15 downto 0);
           Vx_out : out  STD_LOGIC_vector (15 downto 0);
           Vy_out : out  STD_LOGIC_vector (15 downto 0);
           Px : out  STD_LOGIC_vector (15 downto 0);
           Py : out  STD_LOGIC_vector (15 downto 0);
           Clk : in  STD_LOGIC;
           rst_n : in  STD_LOGIC);
end Object_Pos;

architecture Behavioral of Object_Pos is

signal Px_val : std_logic_vector (23 downto 0);
signal Py_val : std_logic_vector (23 downto 0);

signal Py_max : integer := 800;
signal Py_min : integer := 40;

signal clk_en : std_logic;
signal clk_scale : std_logic_vector (23 downto 0);

begin
	
-- clock scale
  clk_proc:process(clk,rst_n)
  begin
    if rst_n = '0' then
      clk_scale <= X"000000";
    elsif rising_edge(clk) then
      if clk_scale = X"000002" then --X"27ffd8" then
        clk_en <= '1';
        clk_scale <= X"000000";
      else
        clk_scale <= std_logic_vector(unsigned(clk_scale) + 1);
        clk_en <= '0';
      end if;
    end if;
  end process;
  
--Positionsänderung in X-Richtung
	x_proc : process(clk,rst_n)
	begin
		if rst_n = '0' then
			Px_val <= std_logic_vector(to_unsigned(def_x,16))& X"00";
		elsif rising_edge(clk) and clk_en = '1' then
      if Vx_in(15) = '1' then --and unsigned(Px_val(23 downto 8)) > 0 then
        Px_val <= std_logic_vector(unsigned('0' & Px_val(22 downto 0)) - unsigned('0' & X"00" & Vx_in(14 downto 0)));
      elsif Vx_in(15) = '0' then -- and unsigned(Px_val(23 downto 8)) < max_x then
        Px_val <= std_logic_vector(unsigned('0' & Px_val(22 downto 0)) + unsigned('0' & Vx_in(14 downto 0)));
      end if;
		end if;
	end process;
  
  Px <= Px_val(23 downto 8);
	
--Positionsänderung in Y-Richtung
	y_proc : process(clk,rst_n)
	begin
    if rst_n = '0' then
      Py_val <= std_logic_vector(to_unsigned(def_y,16))& X"00";
    elsif rising_edge(clk) and clk_en = '1' then
        if Vy_in(15) = '1' THEN -- and unsigned(Py_val(23 downto 8)) > 0 then
          Py_val <= std_logic_vector(unsigned('0' & Py_val(22 downto 0)) - unsigned('0' & X"00" & Vy_in(14 downto 0)));
        elsif Vy_in(15) = '0' then -- and unsigned(Py_val(23 downto 8)) < (max_y - 40) then
			    Py_val <= std_logic_vector(unsigned('0' & Py_val(22 downto 0)) + unsigned('0' & X"00" & Vy_in(14 downto 0)));
        end if;
		  
    end if;
	end process;
	
  Py <= Py_val(23 downto 8);
  
--Ausgabe Geschwindigkeit
	outgabe : process(clk,rst_n)
	begin
    if rst_n = '0' then
      Vx_out <= std_logic_vector(to_unsigned(def_vx,16));
      Vy_out <= std_logic_vector(to_unsigned(def_vy,16));
		elsif rising_edge (clk)  and clk_en = '1' then
			Vx_out <= Vx_in;
			Vy_out <= Vy_in;
		end if;
	end process;

end Behavioral;

