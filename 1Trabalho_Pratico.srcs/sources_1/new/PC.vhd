library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC is
    Port (
        CLK      : in  STD_LOGIC;
        Reset    : in  STD_LOGIC; -- Reset síncrono
        ESCR_PC  : in  STD_LOGIC; -- Controle de salto (1: salta, 0: incrementa)
        Constante : in  STD_LOGIC_VECTOR(7 downto 0); -- Endereço de salto
        Endereco : out STD_LOGIC_VECTOR(7 downto 0) -- Saída do PC
    );
end PC;

architecture Behavioral of PC is
    signal contador : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if Reset = '1' then
                contador <= (others => '0'); -- Reset para 0
            else
                if ESCR_PC = '1' then
                    contador <= Constante; -- Salta para o endereço da constante
                else
                    contador <= STD_LOGIC_VECTOR(unsigned(contador) + 1); -- Incrementa
                end if;
            end if;
        end if;
    end process;

    Endereco <= contador;
end Behavioral;