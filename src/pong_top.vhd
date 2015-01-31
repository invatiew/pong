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
           HTRANS : in  STD_LOGIC_VECTOR (1 downto 0);
           HWDATA : in  STD_LOGIC_VECTOR (31 downto 0);
           HRDATA : out  STD_LOGIC_VECTOR (31 downto 0);
           HREADYOUT : out  STD_LOGIC;
           switch_s1 : in  STD_LOGIC_VECTOR (1 downto 0);
           switch_s2 : in  STD_LOGIC_VECTOR (1 downto 0)
         );
end pong_top;

architecture Behavioral of pong_top is

	COMPONENT ball_speed
	PORT(
		clk : IN std_logic;
		rst_n : IN std_logic;
		col_s1 : IN std_logic_vector(4 downto 0);
		col_s2 : IN std_logic_vector(4 downto 0);
		col_ro : IN std_logic;
		col_ru : IN std_logic;
		ball_vx_in : IN std_logic_vector(15 downto 0);
		ball_vy_in : IN std_logic_vector(15 downto 0);          
		ball_vx_out : OUT std_logic_vector(15 downto 0);
		ball_vy_out : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;

	COMPONENT colision
  generic (
    max_x : INTEGER := 640;
    max_y : integer := 360
  );
	PORT(
		clk : IN std_logic;
		rst_n : IN std_logic;
		posx_ball : IN std_logic_vector(15 downto 0);
		posy_ball : IN std_logic_vector(15 downto 0);
		posx_s1 : IN std_logic_vector(15 downto 0);
		posy_s1 : IN std_logic_vector(15 downto 0);
		posx_s2 : IN std_logic_vector(15 downto 0);
		posy_s2 : IN std_logic_vector(15 downto 0);          
		collision_s1 : OUT std_logic_vector(4 downto 0);
		collision_s2 : OUT std_logic_vector(4 downto 0);
		collision_r1 : INOUT std_logic;
		collision_r2 : INOUT std_logic;
		collision_ro : OUT std_logic;
		collision_ru : OUT std_logic;
    start_round : out std_logic
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

	COMPONENT score
	PORT(
		clk : IN std_logic;
		rst_n : IN std_logic;
		col_r1 : IN std_logic;
		col_r2 : IN std_logic;          
		score_s1 : OUT std_logic_vector(7 downto 0);
		score_s2 : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	COMPONENT Object_Pos
	GENERiC (	
		def_x: INTEGER := 0;
		def_y: INTEGER := 0;
	  def_vx : INTEGER := 0;
    def_vy : INTEGER := 0;
    max_x : INTEGER := 640;
    max_y : integer := 360
  );
  PORT(
		Vx_in : in  STD_LOGIC_vector (15 downto 0);
    Vy_in : in  STD_LOGIC_vector (15 downto 0);
    Vx_out : out  STD_LOGIC_vector (15 downto 0);
    Vy_out : out  STD_LOGIC_vector (15 downto 0);
    Px : out  STD_LOGIC_vector (15 downto 0);
    Py : out  STD_LOGIC_vector (15 downto 0);
		Clk : in  STD_LOGIC;
    rst_n : in  STD_LOGIC
  );
	END COMPONENT;

  -- resolution constants
  constant X_RESOLUTION: integer := 640;
  constant Y_RESOLUTION: integer := 360;

  -- internal collision signals
  signal col_s1 : std_logic_vector(4 downto 0);
  signal col_s2 : std_logic_vector(4 downto 0);
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
  signal s1_vy : std_logic_vector (15 downto 0);
  signal s2_vy : std_logic_vector (15 downto 0);
  
  -- signal for the score
  signal score_s1 : std_logic_vector (7 downto 0);
  signal score_s2 : std_logic_vector (7 downto 0);
  
  -- restart for a new round
  signal start_round : std_logic;
  
  -- input sync for switches
  signal switch_s1_step : std_logic_vector(3 downto 0);
  signal switch_s2_step : std_logic_vector(3 downto 0);
  signal switch_s1_sync : std_logic_vector(1 downto 0);
  signal switch_s2_sync : std_logic_vector(1 downto 0);

begin

  switch_sync_proc: process (HCLK)
    begin
      if rising_edge (HCLK) then
        switch_s1_step <= switch_s1_step(1 downto 0) & switch_s1;
        switch_s2_step <= switch_s2_step(1 downto 0) & switch_s2;
      end if;
    end process;
 
  switch_s1_sync <= (switch_s1_step(3) and switch_s1_step(1)) & (switch_s1_step(2) and switch_s1_step(0));
  switch_s2_sync <= (switch_s2_step(3) and switch_s2_step(1)) & (switch_s2_step(2) and switch_s2_step(0));

	Inst_ball_speed: ball_speed 
  PORT MAP(
		clk => HCLK,
		rst_n => HRESETn,
		col_s1 => col_s1,
		col_s2 => col_s2,
		col_ro => col_ro,
		col_ru => col_ru,
		ball_vx_in => ball_vx_cur,
		ball_vy_in => ball_vy_cur,
		ball_vx_out => ball_vx_next,
		ball_vy_out => ball_vy_next
	);

	Inst_colision: colision 
  PORT MAP(
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
		collision_ru => col_ru,
    start_round => start_round
	);
 
	Inst_cpu_regs: cpu_regs 
  PORT MAP(
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
 
	Inst_score: score 
  PORT MAP(
		clk => HCLK,
		rst_n => HRESETn,
		col_r1 => col_r1,
		col_r2 => col_r2,
		score_s1 => score_s1,
		score_s2 => score_s2
	);
  
  Inst_Ball_Pos: Object_Pos 
  generic map(
    def_x => 320,
		def_y => 170,
    def_vx => 64,
    def_vy => 0
	)
  PORT MAP(
		Vx_in => ball_vx_next,
		Vy_in => ball_vy_next,
		Vx_out => ball_vx_cur,
		Vy_out => ball_vy_cur,
		Px => posx_ball,
		Py => posy_ball,
		Clk => HCLK,
		rst_n => HRESETn and not start_round
	);
  
  s1_vy_proc: process(HCLK,HRESETn)
    begin
      if HRESETn = '0' then
        s1_vy <= X"0000";
      elsif rising_edge(HCLK) then
        if switch_s1_sync = b"11"  then
          s1_vy <= X"0000";
        elsif switch_s1_sync = b"10" and unsigned(posy_s1) > 0 then
          s1_vy <= X"8001";
        elsif switch_s1_sync = b"01" and unsigned(posy_s1) < (Y_RESOLUTION - 40) then
          s1_vy <= X"0001";
        else 
          s1_vy <= X"0000";
        end if;
      end if;
    end process;
  
  Inst_s1_Pos: Object_Pos 
  generic map(
    def_x => 10,
		def_y => 160
	)
  PORT MAP(
		Vx_in => X"0000",
		Vy_in => s1_vy,
		Px => posx_s1,
		Py => posy_s1,
		Clk => HCLK,
		rst_n => HRESETn and not start_round
	);

  s2_vy_proc: process(HCLK,HRESETn)
    begin
      if HRESETn = '0' then
        s2_vy <= X"0000";
      elsif rising_edge(HCLK) then
        if switch_s2_sync = b"11" then
          s2_vy <= X"0000";
        elsif switch_s2_sync = b"10" and unsigned(posy_s2) > 0 then
          s2_vy <= X"80B0";
        elsif switch_s2_sync = b"01" and unsigned(posy_s2) < (Y_RESOLUTION - 40) then
          s2_vy <= X"00B0";
        else 
          s2_vy <= X"0000";
        end if;
      end if;
    end process;
  
  Inst_S2_Pos: Object_Pos 
  generic map(
    def_x => 620,
		def_y => 160
	)
  PORT MAP(
		Vx_in => X"0000",
		Vy_in => s2_vy,
		Px => posx_s2,
		Py => posy_s2,
		Clk => HCLK,
		rst_n => HRESETn and not start_round
	);

end Behavioral;

