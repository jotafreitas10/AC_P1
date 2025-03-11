----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.03.2025 12:26:46
-- Design Name: 
-- Module Name: Memoria_De_Instrucoes - Behavioral
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

entity Memoria_De_Instrucoes is
  Port (
    Endereco  : in  std_logic_vector(7 downto 0);   -- Endereço de 8 bits
    Opcode    : out std_logic_vector(4 downto 0);   -- Opcode de 5 bits
    SEL_REG1  : out std_logic_vector(2 downto 0);   -- Seleção do registo 1 (3 bits)
    SEL_REG2  : out std_logic_vector(2 downto 0);   -- Seleção do registo 2 (3 bits)
    Constante : out std_logic_vector(7 downto 0)    -- Constante de 8 bits
  );
end Memoria_De_Instrucoes;

architecture Behavioral of Memoria_De_Instrucoes is

begin
process (Endereco)
    begin
        case Endereco is
            -- LDP R1
            when "00000000" => Opcode <= "00000"; SEL_REG1 <= "001"; SEL_REG2 <= "XXX"; Constante <= "XXXXXXXX";
            -- ST [0], R1
            when "00000001" => Opcode <= "00100"; SEL_REG1 <= "001"; SEL_REG2 <= "XXX"; Constante <= "00000000";
            -- LD R5, 0
            when "00000010" => Opcode <= "00010"; SEL_REG1 <= "101"; SEL_REG2 <= "XXX"; Constante <= "00000000";
            -- LD R4, 1
            when "00000011" => Opcode <= "00010"; SEL_REG1 <= "100"; SEL_REG2 <= "XXX"; Constante <= "00000001";
            -- CMP R1, R5
            when "00000100" => Opcode <= "01101"; SEL_REG1 <= "001"; SEL_REG2 <= "101"; Constante <= "XXXXXXXX";
            -- JL 21
            when "00000101" => Opcode <= "01111"; SEL_REG1 <= "XXX"; SEL_REG2 <= "XXX"; Constante <= "00010101";
            -- LD R2, 42
            when "00000110" => Opcode <= "00010"; SEL_REG1 <= "010"; SEL_REG2 <= "XXX"; Constante <= "00101010";
            -- LD R1, [0]
            when "00000111" => Opcode <= "00011"; SEL_REG1 <= "001"; SEL_REG2 <= "XXX"; Constante <= "00000000";
            -- CMP R1, R2
            when "00001000" => Opcode <= "01101"; SEL_REG1 <= "001"; SEL_REG2 <= "010"; Constante <= "XXXXXXXX";
            -- JG 18
            when "00001001" => Opcode <= "10010"; SEL_REG1 <= "XXX"; SEL_REG2 <= "XXX"; Constante <= "00010010";
            -- LD R3, [0]
            when "00001010" => Opcode <= "00011"; SEL_REG1 <= "011"; SEL_REG2 <= "XXX"; Constante <= "00000000";
            -- LD R1, [0]
            when "00001011" => Opcode <= "00011"; SEL_REG1 <= "001"; SEL_REG2 <= "XXX"; Constante <= "00000000";
            -- ADD R1, R3
            when "00001100" => Opcode <= "00101"; SEL_REG1 <= "001"; SEL_REG2 <= "011"; Constante <= "XXXXXXXX";
            -- ADD R1, R3
            when "00001101" => Opcode <= "00101"; SEL_REG1 <= "001"; SEL_REG2 <= "011"; Constante <= "XXXXXXXX";
            -- JZ R1, 16
            when "00001110" => Opcode <= "10100"; SEL_REG1 <= "001"; SEL_REG2 <= "XXX"; Constante <= "00010000";
            -- ADD R1, R4
            when "00001111" => Opcode <= "00101"; SEL_REG1 <= "001"; SEL_REG2 <= "100"; Constante <= "XXXXXXXX";
            -- STP R1
            when "00010000" => Opcode <= "00001"; SEL_REG1 <= "001"; SEL_REG2 <= "XXX"; Constante <= "XXXXXXXX";
            -- JMP 17
            when "00010001" => Opcode <= "10011"; SEL_REG1 <= "XXX"; SEL_REG2 <= "XXX"; Constante <= "00010001";
            -- LD R1, [0]
            when "00010010" => Opcode <= "00011"; SEL_REG1 <= "001"; SEL_REG2 <= "XXX"; Constante <= "00000000";
            -- SUB R1, R2
            when "00010011" => Opcode <= "00110"; SEL_REG1 <= "001"; SEL_REG2 <= "010"; Constante <= "XXXXXXXX";
            -- JMP 16
            when "00010100" => Opcode <= "10011"; SEL_REG1 <= "XXX"; SEL_REG2 <= "XXX"; Constante <= "00010000";
            -- LD R1, [0]
            when "00010101" => Opcode <= "00011"; SEL_REG1 <= "001"; SEL_REG2 <= "XXX"; Constante <= "00000000";
            -- LD R3, -1
            when "00010110" => Opcode <= "00010"; SEL_REG1 <= "011"; SEL_REG2 <= "XXX"; Constante <= "11111111";
            -- XOR R1, R3
            when "00010111" => Opcode <= "01011"; SEL_REG1 <= "001"; SEL_REG2 <= "011"; Constante <= "XXXXXXXX";
            -- JMP 15
            when "00011000" => Opcode <= "10011"; SEL_REG1 <= "XXX"; SEL_REG2 <= "XXX"; Constante <= "00001111";
            when others => Opcode <= "XXXXX"; SEL_REG1 <= "XXX"; SEL_REG2 <= "XXX"; Constante <= "XXXXXXXX";
        end case;
    end process;
end Behavioral;
