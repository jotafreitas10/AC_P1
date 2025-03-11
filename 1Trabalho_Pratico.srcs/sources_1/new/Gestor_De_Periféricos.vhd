library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Gestor_Perifericos is
    Port (
        CLK       : in  std_logic;                      -- Relógio
        ESCR_P    : in  std_logic;                      -- Sinal de controlo (Escrita/Leitura)
        PIN       : in  std_logic_vector(7 downto 0);   -- Entrada de dados externa
        Operando1 : in  std_logic_vector(7 downto 0);   -- Dado a ser escrito na saída
        Dados_IN  : out std_logic_vector(7 downto 0);   -- Dados lidos de entrada
        POUT      : out std_logic_vector(7 downto 0)    -- Saída de dados para o exterior
    );
end Gestor_Perifericos;

architecture Behavioral of Gestor_Perifericos is
    signal POUT_reg : std_logic_vector(7 downto 0) := (others => '0');
begin
    process (CLK)
    begin
        if rising_edge(CLK) then
            if ESCR_P = '1' then
                POUT_reg <= Operando1;  -- Atualiza POUT_reg com o valor de Operando1
            else
                -- Mantém o valor anterior (não lê a porta POUT)
                POUT_reg <= POUT_reg;
            end if;
        end if;
    end process;
    
    -- Atribui o sinal interno à porta de saída
    POUT <= POUT_reg;
    
    process (ESCR_P, PIN)
    begin
        if ESCR_P = '0' then
            Dados_IN <= PIN;  -- Lê os dados de entrada quando ESCR_P é '0'
        else
            Dados_IN <= (others => '0');  -- Ou atribui um valor default
        end if;
    end process;
end Behavioral;