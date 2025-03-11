library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegistoFlags is
    Port (
        CLK        : in  std_logic;                    -- Sinal de relógio
        ESCR_F     : in  std_logic;                    -- Sinal de escrita (1 bit)
        COMP_FLAG  : in  std_logic_vector(4 downto 0); -- Entrada de flags (5 bits)
        SEL_F      : in  std_logic_vector(2 downto 0); -- Seleção do flag (3 bits)
        S_FLAG     : out std_logic                     -- Saída do flag selecionado (1 bit)
    );
end RegistoFlags;

architecture Behavioral of RegistoFlags is
    signal RegistoFlags : std_logic_vector(4 downto 0) := (others => '0'); -- Registro interno
begin
    -- Processo para escrita síncrona
    process(CLK)
    begin
        if rising_edge(CLK) then
            if ESCR_F = '1' then
                RegistoFlags <= COMP_FLAG; -- Atualiza os flags na transição ascendente do CLK
            end if;
        end if;
   

    -- Multiplexador para seleção do flag de saída (assíncrono)
    case SEL_F is
            when "000" => S_FLAG<= RegistoFlags(0);
            when "001" => S_FLAG<= RegistoFlags(1);
            when "010" => S_FLAG<= RegistoFlags(2);
            when "011" => S_FLAG<= RegistoFlags(3);
            when "100" => S_FLAG<= RegistoFlags(4);
           
            when others => null; -- Valor padrão para SEL_F inválido
            end case;
            end process;
end Behavioral;