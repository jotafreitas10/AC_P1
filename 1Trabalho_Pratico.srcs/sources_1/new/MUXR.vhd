library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_Registos is
    Port (
        SEL_R     : in  std_logic_vector(1 downto 0);  -- Sinal de seleção (2 bits)
        Resultado : in  std_logic_vector(7 downto 0);  -- Entrada 00
        Dados_IN  : in  std_logic_vector(7 downto 0);  -- Entrada 01
        Dados_M   : in  std_logic_vector(7 downto 0);  -- Entrada 10
        Constante : in  std_logic_vector(7 downto 0);  -- Entrada 11
        Dados_R   : out std_logic_vector(7 downto 0)   -- Saída selecionada
    );
end MUX_Registos;

architecture Behavioral of MUX_Registos is
begin
    process (SEL_R, Resultado, Dados_IN, Dados_M, Constante)
    begin
        case SEL_R is
            when "00" => Dados_R <= Resultado;  -- Seleciona Resultado
            when "01" => Dados_R <= Dados_IN;   -- Seleciona Dados_IN
            when "10" => Dados_R <= Dados_M;    -- Seleciona Dados_M
            when "11" => Dados_R <= Constante;  -- Seleciona Constante
            when others => Dados_R <= (others => '0'); -- Caso padrão
        end case;
    end process;
end Behavioral;