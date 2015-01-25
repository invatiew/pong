--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:54:39 01/12/2015
-- Design Name:   
-- Module Name:   /home/fel/Dokumente/pong/src/colision_tb.vhd
-- Project Name:  pong
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: colision
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY colision_tb IS
END colision_tb;
 
ARCHITECTURE behavior OF colision_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT colision
    PORT(
         clk : IN  std_logic;
         rst_n : IN  std_logic;
         posx_ball : IN  std_logic_vector(15 downto 0);
         posy_ball : IN  std_logic_vector(15 downto 0);
         posx_s1 : IN  std_logic_vector(15 downto 0);
         posy_s1 : IN  std_logic_vector(15 downto 0);
         posx_s2 : IN  std_logic_vector(15 downto 0);
         posy_s2 : IN  std_logic_vector(15 downto 0);
         collision_s1 : OUT  std_logic;
         collision_s2 : OUT  std_logic;
         collision_r1 : OUT  std_logic;
         collision_r2 : OUT  std_logic;
         collision_ro : out  STD_LOGIC;
         collision_ru : out  STD_LOGIC
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst_n : std_logic := '0';
   signal posx_ball : std_logic_vector(15 downto 0) := (others => '0');
   signal posy_ball : std_logic_vector(15 downto 0) := (others => '0');
   signal posx_s1 : std_logic_vector(15 downto 0) := (others => '0');
   signal posy_s1 : std_logic_vector(15 downto 0) := (others => '0');
   signal posx_s2 : std_logic_vector(15 downto 0) := (others => '0');
   signal posy_s2 : std_logic_vector(15 downto 0) := (others => '0');
   
 	--Outputs
   signal collision_s1 : std_logic;
   signal collision_s2 : std_logic;
   signal collision_r1 : std_logic;
   signal collision_r2 : std_logic;
   signal collision_ro : std_logic;
   signal collision_ru : std_logic;
   
   -- Clock period definitions
   constant clk_period : time := 10 ns;
  
   
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: colision PORT MAP (
          clk => clk,
          rst_n => rst_n,
          posx_ball => posx_ball,
          posy_ball => posy_ball,
          posy_s1 => posy_s1,
          posx_s1 => X"000A",--posy_s1,
          posy_s2 => posy_s2,
          posx_s2 => X"0316",--posy_s2,
          collision_s1 => collision_s1,
          collision_s2 => collision_s2,
          collision_r1 => collision_r1,
          collision_r2 => collision_r2,
          collision_ro => collision_ro,
          collision_ru => collision_ru
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      posy_ball <= X"0080";
      posy_s1 <= X"0080";
      posy_s2 <= X"0080";

      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
      rst_n <= '1';


      wait;
   end process;

test_proc: process (clk,rst_n)
      begin
        if rst_n = '0' then
          posx_ball <= X"0000";
        elsif rising_edge(clk) then
          posx_ball <= std_logic_vector(unsigned(posx_ball) + 1,16);
        end if;
      end process;
   

END;
