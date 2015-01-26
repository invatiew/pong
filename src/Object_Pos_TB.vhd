-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 

  -- Component Declaration
          COMPONENT Object_Pos
			 GENERiC (	
						def_x: INTEGER := 0;
						def_y: INTEGER := 0
						);
          PORT(
					  Vx_in : in  STD_LOGIC;
					  Vy_in : in  STD_LOGIC;
					  Vx_out : out  STD_LOGIC;
					  Vy_out : out  STD_LOGIC;
					  Px : out  STD_LOGIC;
					  Py : out  STD_LOGIC;
					  Clk : in  STD_LOGIC;
					  rst_n : in  STD_LOGIC
                 );	
          END COMPONENT;

          SIGNAL Vx_in :  std_logic;
          SIGNAL Vy_in :  std_logic;
			 SIGNAL Vx_out :  std_logic;
          SIGNAL Vy_out :  std_logic;
			 SIGNAL Px :  std_logic;
          SIGNAL Py :  std_logic;
 			 SIGNAL Clk :  std_logic;
          SIGNAL rst_n :  std_logic;         

  BEGIN

  -- Component Instantiation
          uut: Object_Pos 
			 GENERIC MAP(
						def_x => def_x,
						def_y => def_y
						)
			 PORT MAP(
                  Vx_in => Vx_in,
                  Vy_in => Vy_in,      
						Vx_out => Vx_out,
						Vy_out => Vy_out, 
						Px => Px,
                  Py => Py, 
						Clk => Clk,
                  rst_n => rst_n						
						);


  --  Test Bench Statements
     tb : PROCESS
     BEGIN
		rst_n <=  '1';
        wait for 100 ns; -- wait until global set/reset completes
		
        -- Add user defined stimulus here

        wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;
