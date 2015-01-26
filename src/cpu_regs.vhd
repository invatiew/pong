----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:22:51 01/25/2015 
-- Design Name: 
-- Module Name:    cpu_regs - Behavioral 
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

entity cpu_regs is
    Port ( clk : in  STD_LOGIC;
           rst_n : in  STD_LOGIC;
           
           -- AHB-Lite signals
           HADDR : in  STD_LOGIC_VECTOR (31 downto 0);
           HWRITE : in  STD_LOGIC;
           HWDATA : in  STD_LOGIC_VECTOR (31 downto 0);
           HTRANS : in  STD_LOGIC_VECTOR (1 downto 0);
           HSEL : in  STD_LOGIC;
           HREADY : in  STD_LOGIC;
           HRDATA : out  STD_LOGIC_VECTOR (31 downto 0);
           HREADYOUT : out STD_LOGIC;
           
           -- input from logic
           posx_ball : in  STD_LOGIC_VECTOR (15 downto 0);
           posy_ball : in  STD_LOGIC_VECTOR (15 downto 0);
           posx_s1 : in  STD_LOGIC_VECTOR (15 downto 0);
           posy_s1 : in  STD_LOGIC_VECTOR (15 downto 0);
           posx_s2 : in  STD_LOGIC_VECTOR (15 downto 0);
           posy_s2 : in  STD_LOGIC_VECTOR (15 downto 0);
           
           score_s1 : in STD_LOGIC_VECTOR (7 downto 0);
           score_s2 : in STD_LOGIC_VECTOR (7 downto 0)
           );
           
end cpu_regs;

architecture Behavioral of cpu_regs is

  --AHB Registers
  signal last_HWRITE  : std_logic;
  signal last_HADDR   : std_logic_vector(31 downto 0);
  signal last_HSEL    : std_logic;
  signal last_HTRANS  : std_logic_vector(1 downto 0);

  begin

  HREADYOUT <= '1';

  AHBINPROC:process (clk,rst_n)
    begin
      if rst_n = '0' then
        last_HWRITE  <= '0';
        last_HADDR   <= X"00000000";
        last_HSEL    <= '0';
        last_HTRANS  <= b"00";
      elsif rising_edge(clk) then
        last_HWRITE  <= HWRITE;
        last_HADDR   <= HADDR;
        last_HSEL    <= HSEL;
        last_HTRANS  <= HTRANS;
      end if;
    end process;

  AHBOUTPROC: process (clk,rst_n)
    begin
      if rst_n = '0' then
        HRDATA <= X"00000000";
      elsif rising_edge(clk) then
        if last_HWRITE = '0' and last_HSEL = '1' and last_HTRANS(1) = '1' then
          case (last_HADDR(1 downto 0)) is 
            when b"00" =>
              HRDATA <= posy_ball & posx_ball;
            when b"01" =>
              HRDATA <= posy_s1 & posx_s1;
            when b"10" =>
              HRDATA <= posy_s2 & posx_s2;
            when b"11" =>
              HRDATA <= X"00" & score_s1 & X"00" & score_s2;
            when others =>
              HRDATA <= x"00000000";
          end case;
        end if;
      end if;
    end process;

end Behavioral;

