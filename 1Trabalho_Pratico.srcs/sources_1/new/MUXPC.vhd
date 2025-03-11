library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_PC is
    Port (
        SEL_PC     : in  STD_LOGIC_VECTOR(2 downto 0); -- 3 bits de seleção
        S_FLAG     : in  STD_LOGIC; -- Flag de comparação
        Operando1  : in  STD_LOGIC_VECTOR(7 downto 0); -- Registro Ri
        NOR_Operando: in STD_LOGIC;
        bit_maior_Peso : in  STD_LOGIC;
        ESCR_PC    : out STD_LOGIC -- Saída de controle do PC
    );
end Mux_PC;

architecture Behavioral of Mux_PC is
begin
    process(SEL_PC, S_FLAG, Operando1,bit_maior_Peso,NOR_Operando)
    begin
        case SEL_PC is
            when "000" => ESCR_PC <= '0'; -- Incrementa PC
            when "001" => ESCR_PC <= '1'; -- Salto incondicional
            when "010" => ESCR_PC <= S_FLAG; -- Salto condicional (Flags)
            when "011" => ESCR_PC <= NOR_Operando; -- Salto se Ri = 0
            when "100" => ESCR_PC <= bit_maior_Peso; -- Salto se Ri é negativo (bit mais significativo)
            when others => ESCR_PC <= '0'; -- Default
        end case;
    end process;
end Behavioral;