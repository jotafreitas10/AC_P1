library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Certifique-se de incluir esta linha

entity Banco_Registos is
    Port (
        CLK       : in  std_logic;                       -- Relógio
        ESCR_R    : in  std_logic;                       -- Sinal de controlo de escrita
        SEL_REG1  : in  std_logic_vector(2 downto 0);   -- Seleção do registo para escrita e leitura (Operando1)
        SEL_REG2  : in  std_logic_vector(2 downto 0);   -- Seleção do registo para leitura (Operando2)
        Dados_R   : in  std_logic_vector(7 downto 0);   -- Dados a serem escritos no registo 
        Operando1 : out std_logic_vector(7 downto 0);   -- Saída do primeiro operando
        Operando2 : out std_logic_vector(7 downto 0)    -- Saída do segundo operando
    );
end Banco_Registos;

architecture Behavioral of Banco_Registos is
    type reg_array is array (0 to 5) of std_logic_vector(7 downto 0);
    signal Registos : reg_array := (others => (others => '0'));

begin
    process (CLK)
    begin
        if rising_edge(CLK) then
            if ESCR_R = '1' then
                Registos(to_integer(unsigned(SEL_REG1))) <= Dados_R;  -- Escreve no registo selecionado
            end if;
        end if;
    end process;
    
    -- Leitura contínua dos registos
    Operando1 <= Registos(to_integer(unsigned(SEL_REG1)));
    Operando2 <= Registos(to_integer(unsigned(SEL_REG2)));

end Behavioral;
