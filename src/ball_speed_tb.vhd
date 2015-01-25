--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:51:33 01/12/2015
-- Design Name:   
-- Module Name:   /home/fel/Dokumente/pong/src/ball_speed_tb.vhd
-- Project Name:  pong
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ball_speed
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
--USE ieee.numeric_std.ALL;
 
ENTITY ball_speed_tb IS
END ball_speed_tb;
 
ARCHITECTURE behavior OF ball_speed_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ball_speed
    PORT(
         clk : IN  std_logic;
         rst_n : IN  std_logic;
         col_s1 : IN  std_logic;
         col_s2 : IN  std_logic;
         col_ro : in std_logic;
         col_ru : in std_logic;
         ball_vx_in : IN  std_logic_vector(15 downto 0);
         ball_vy_in : IN  std_logic_vector(15 downto 0);
         ball_vx_out : OUT  std_logic_vector(15 downto 0);
         ball_vy_out : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst_n : std_logic := '0';
   signal col_s1 : std_logic := '0';
   signal col_s2 : std_logic := '0';
   signal col_ro : std_logic := '0';
   signal col_ru : std_logic := '0';
   signal ball_vx_in : std_logic_vector(15 downto 0) := (others => '0');
   signal ball_vy_in : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal ball_vx_out : std_logic_vector(15 downto 0);
   signal ball_vy_out : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ball_speed PORT MAP (
          clk => clk,
          rst_n => rst_n,
          col_s1 => col_s1,
          col_s2 => col_s2,
          col_ro => col_ro,
          col_ru => col_ru,
          ball_vx_in => ball_vx_in,
          ball_vy_in => ball_vy_in,
          ball_vx_out => ball_vx_out,
          ball_vy_out => ball_vy_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   spd_proc: process (clk,rst_n)
   begin
    if rst_n = '0' then
      ball_vx_in <= x"0100";
      ball_vy_in <= x"0010";
    elsif rising_edge(clk) then
      ball_vx_in <= ball_vx_out;
      ball_vy_in <= ball_vy_out;
    end if;
   end process;

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      rst_n <= '0';
      col_s1 <= '0';
      col_s2 <= '0';
      wait for 100 ns;	
      rst_n <= '1';
      
      wait for clk_period*10;

      -- insert stimulus here 
      col_s1 <= '1';
      
      wait for clk_period;
      
      col_s1 <= '0';
      
      wait for clk_period * 10;
      col_s2 <= '1';
      
      wait for clk_period;
      
      col_s2 <= '0';
      
      wait for clk_period * 10;
      wait;
   end process;

END;
