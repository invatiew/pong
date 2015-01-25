--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:48:04 01/25/2015
-- Design Name:   
-- Module Name:   /home/fel/Dokumente/pong/src/score_tb.vhd
-- Project Name:  pong
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: score
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
 
ENTITY score_tb IS
END score_tb;
 
ARCHITECTURE behavior OF score_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT score
    PORT(
         clk : IN  std_logic;
         rst_n : IN  std_logic;
         col_r1 : IN  std_logic;
         col_r2 : IN  std_logic;
         score_s1 : OUT  std_logic_vector(7 downto 0);
         score_s2 : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst_n : std_logic := '0';
   signal col_r1 : std_logic := '0';
   signal col_r2 : std_logic := '0';

 	--Outputs
   signal score_s1 : std_logic_vector(7 downto 0);
   signal score_s2 : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: score PORT MAP (
          clk => clk,
          rst_n => rst_n,
          col_r1 => col_r1,
          col_r2 => col_r2,
          score_s1 => score_s1,
          score_s2 => score_s2
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
      rst_n <= '0';
      wait for 100 ns;	
      col_r1 <= '0';
      col_r2 <= '0';
      rst_n <= '1';
      wait for clk_period*10;

      -- insert stimulus here 
      col_r1 <= '1';
      wait for clk_period;
      col_r2 <= '0';
      col_r1 <= '0';
      wait for clk_period;
      col_r2 <= '1';
      col_r1 <= '1';
      wait for clk_period;
      col_r2 <= '0';
      col_r1 <= '0';
      
      wait;
   end process;

END;
