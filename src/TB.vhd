--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:40:15 01/19/2015
-- Design Name:   
-- Module Name:   /home/fel/Dokumente/RES/PONG/Pong/TB.vhd
-- Project Name:  Pong
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Object_Pos
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
 
ENTITY TB IS
END TB;
 
ARCHITECTURE behavior OF TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Object_Pos
    PORT(
         Vx_in : IN  std_logic;
         Vy_in : IN  std_logic;
         Vx_out : OUT  std_logic;
         Vy_out : OUT  std_logic;
         Px : OUT  std_logic;
         Py : OUT  std_logic;
         Clk : IN  std_logic;
         rst_n : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Vx_in : std_logic := '0';
   signal Vy_in : std_logic := '0';
   signal Clk : std_logic := '0';
   signal rst_n : std_logic := '0';

 	--Outputs
   signal Vx_out : std_logic;
   signal Vy_out : std_logic;
   signal Px : std_logic;
   signal Py : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Object_Pos PORT MAP (
          Vx_in => Vx_in,
          Vy_in => Vy_in,
          Vx_out => Vx_out,
          Vy_out => Vy_out,
          Px => Px,
          Py => Py,
          Clk => Clk,
          rst_n => rst_n
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for Clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
