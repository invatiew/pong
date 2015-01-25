----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:11:55 01/25/2015 
-- Design Name: 
-- Module Name:    pong_top - Behavioral 
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

entity pong_top is
    Port ( HCLK : in  STD_LOGIC;
           HRESETn : in  STD_LOGIC;
           HADDR : in  STD_LOGIC_VECTOR (31 downto 0);
           HWRITE : in  STD_LOGIC;
           HSEL : in  STD_LOGIC;
           HREADY : in  STD_LOGIC;
           HTRANS : in  STD_LOGIC;
           HWDATA : in  STD_LOGIC_VECTOR (31 downto 0);
           HRDATA : out  STD_LOGIC_VECTOR (31 downto 0);
           HREADYOUT : in  STD_LOGIC;
           switch_s1 : in  STD_LOGIC;
           switch_s2 : in  STD_LOGIC);
end pong_top;

architecture Behavioral of pong_top is

	COMPONENT ball_speed
	PORT(
		clk : IN std_logic;
		rst_n : IN std_logic;
		col_s1 : IN std_logic;
		col_s2 : IN std_logic;
		col_ro : IN std_logic;
		col_ru : IN std_logic;
		ball_vx_in : IN std_logic_vector(15 downto 0);
		ball_vy_in : IN std_logic_vector(15 downto 0);          
		ball_vx_out : OUT std_logic_vector(15 downto 0);
		ball_vy_out : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;

	COMPONENT colision
	PORT(
		clk : IN std_logic;
		rst_n : IN std_logic;
		posx_ball : IN std_logic_vector(15 downto 0);
		posy_ball : IN std_logic_vector(15 downto 0);
		posx_s1 : IN std_logic_vector(15 downto 0);
		posy_s1 : IN std_logic_vector(15 downto 0);
		posx_s2 : IN std_logic_vector(15 downto 0);
		posy_s2 : IN std_logic_vector(15 downto 0);          
		collision_s1 : OUT std_logic;
		collision_s2 : OUT std_logic;
		collision_r1 : OUT std_logic;
		collision_r2 : OUT std_logic;
		collision_ro : OUT std_logic;
		collision_ru : OUT std_logic
		);
	END COMPONENT;

	COMPONENT cpu_regs
	PORT(
		clk : IN std_logic;
		rst_n : IN std_logic;
		HADDR : IN std_logic_vector(31 downto 0);
		HWRITE : IN std_logic;
		HWDATA : IN std_logic_vector(31 downto 0);
		HTRANS : IN std_logic_vector(1 downto 0);
		HSEL : IN std_logic;
		HREADY : IN std_logic;
		posx_ball : IN std_logic_vector(15 downto 0);
		posy_ball : IN std_logic_vector(15 downto 0);
		posx_s1 : IN std_logic_vector(15 downto 0);
		posy_s1 : IN std_logic_vector(15 downto 0);
		posx_s2 : IN std_logic_vector(15 downto 0);
		posy_s2 : IN std_logic_vector(15 downto 0);
		score_s1 : IN std_logic_vector(7 downto 0);
		score_s2 : IN std_logic_vector(7 downto 0);          
		HRDATA : OUT std_logic_vector(31 downto 0);
		HREADYOUT : OUT std_logic
		);
	END COMPONENT;

  -- internal collision signals
  signal col_s1 : std_logic;
  signal col_s2 : std_logic;
  signal col_r1 : std_logic;
  signal col_r2 : std_logic;
  signal col_ro : std_logic;
  signal col_ru : std_logic;
  
  -- internal position signals
  signal posx_ball : std_logic_vector (15 downto 0);
  signal posy_ball : std_logic_vector (15 downto 0);
  signal posx_s1 : std_logic_vector (15 downto 0);
  signal posy_s1 : std_logic_vector (15 downto 0);
  signal posx_s2 : std_logic_vector (15 downto 0);
  signal posy_s2 : std_logic_vector (15 downto 0);
  
  -- speed vector
  signal ball_vx_cur : std_logic_vector (15 downto 0);
  signal ball_vy_cur : std_logic_vector (15 downto 0);
  signal ball_vx_next : std_logic_vector (15 downto 0);
  signal ball_vy_next : std_logic_vector (15 downto 0); 
  
  -- signal for the score
  signal score_s1 : std_logic_vector (7 downto 0);
  signal score_s2 : std_logic_vector (7 downto 0);

begin

	Inst_ball_speed: ball_speed PORT MAP(
		clk => HCLK,
		rst_n => HRESETn,
		col_s1 => col_s1,
		col_s2 => col_s2,
		col_ro => col_ro,
		col_ru => col_ru,
		ball_vx_in => ball_vx_cur,
		ball_vy_in => ball_vy_cur,
		ball_vx_out => ball_vx_next,
		ball_vy_out => ball_vx_next
	);

	Inst_colision: colision PORT MAP(
		clk => HCLK,
		rst_n => HRESETn,
		posx_ball => posx_ball,
		posy_ball => posy_ball,
		posx_s1 => posx_s1,
		posy_s1 => posy_s1,
		posx_s2 => posx_s2,
		posy_s2 => posy_s2,
		collision_s1 => col_s1,
		collision_s2 => col_s2,
		collision_r1 => col_r1,
		collision_r2 => col_r2,
		collision_ro => col_ro,
		collision_ru => col_ru
	);
 
	Inst_cpu_regs: cpu_regs PORT MAP(
		clk => HCLK,
		rst_n => HRESETn,
		HADDR => HADDR,
		HWRITE => HWRITE,
		HWDATA => HWDATA,
		HTRANS => HTRANS,
		HSEL => HSEL,
		HREADY => HREADY,
		HRDATA => HRDATA,
		HREADYOUT => HREADYOUT,
		posx_ball => posx_ball,
		posy_ball => posy_ball,
		posx_s1 => posx_s1,
		posy_s1 => posy_s1,
		posx_s2 => posx_s2,
		posy_s2 => posy_s2,
		score_s1 => score_s1,
		score_s2 => score_s2
	);
 
  
end Behavioral;

