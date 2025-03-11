library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MemoriaDados is
    Port (
        CLK       : in  STD_LOGIC;                       -- Sinal de relógio
        WR        : in  STD_LOGIC;                       -- Controle de escrita (1: escreve, 0: lê)
                         
        Constante : in  STD_LOGIC_VECTOR(7 downto 0);     -- Endereço de memória
        Operando1 : in  STD_LOGIC_VECTOR(7 downto 0);     -- Dado a ser escrito
        Dados_M   : out STD_LOGIC_VECTOR(7 downto 0)      -- Dado lido
    );
end MemoriaDados;

architecture Behavioral of MemoriaDados is
    type RAM_T is array (0 to 255) of STD_LOGIC_VECTOR(7 downto 0); -- 256 posições de 8 bits
    signal RAM : RAM_T := (others => (others => '0'));             -- Inicialização com zeros
begin
    -- Processo de escrita síncrona
    process(CLK)
    begin
        if rising_edge(CLK) then
            if WR = '1' then
                RAM(to_integer(unsigned(Constante))) <= Operando1; -- Escreve na RAM
            end if;
        end if;
    end process;

    -- Leitura assíncrona (contínua)
    Dados_M <= RAM(to_integer(unsigned(Constante))) when WR = '0' else (others => '0'); -- Lê da RAM
end Behavioral;