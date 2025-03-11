----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.03.2025 18:37:15
-- Design Name: 
-- Module Name: NOR_Operando - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity NOR_Operando is
 Port ( O0 : in STD_LOGIC;
           O1 : in STD_LOGIC;
           O2 : in STD_LOGIC;
           O3 : in STD_LOGIC;
           O4 : in STD_LOGIC;
           O5 : in STD_LOGIC;
           O6 : in STD_LOGIC;
           O7 : in STD_LOGIC;
           NOR_Operando1 : out STD_LOGIC);
end NOR_Operando;

architecture Behavioral of NOR_Operando is

begin
process
(o0,o1,o2,o3,o4,o5,o6,o7)
begin
    NOR_Operando1 <= not(o0 or o1 or o2 or o3 or o4 or o5 or o6 or o7);
end process;

end Behavioral;
