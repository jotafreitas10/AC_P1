library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ROM_Decod is
    Port (
        opcode   : in  STD_LOGIC_VECTOR(4 downto 0); -- 5 bits de entrada
        SEL_PC  : out STD_LOGIC_VECTOR(2 downto 0);
        SEL_F   : out STD_LOGIC_VECTOR(2 downto 0);
        ESCR_F  : out STD_LOGIC;
        SEL_ALU : out STD_LOGIC_VECTOR(3 downto 0);
        ESCR_R  : out STD_LOGIC;
        SEL_R   : out STD_LOGIC_VECTOR(1 downto 0);
        ESCR_P  : out STD_LOGIC;
        WR      : out STD_LOGIC
    );
end ROM_Decod;

architecture Behavioral of ROM_Decod is
begin
    process(opcode)
    begin
        -- Valores padrão (evitar latch)
        SEL_PC  <= "000";
        SEL_F   <= "000";
        ESCR_F  <= '0';
        SEL_ALU <= "0000";
        ESCR_R  <= '0';
        SEL_R   <= "00";
        ESCR_P  <= '0';
        WR      <= '0';

        case opcode is
            -- Periféricos
            when "00000" => -- LDP Ri
                SEL_PC  <= "000";
                SEL_F   <= "XXX";
                ESCR_F  <= '0';
                SEL_ALU <= "XXXX";
                SEL_R   <= "01";
                ESCR_R  <= '1';
                ESCR_P  <= '0';
                WR      <= '0';
            when "00001" => -- STP Ri
                SEL_PC  <= "000";
                SEL_F   <= "XXX";
                ESCR_F  <= '0';
                SEL_ALU <= "XXXX";
                SEL_R   <= "XX";
                ESCR_R  <= '0';
                ESCR_P  <= '1';
                WR      <= '0';

            -- Leitura/Escrita
            when "00010" => -- LD Ri, constante
                SEL_PC  <= "000";
                SEL_F   <= "XXX";
                ESCR_F  <= '0';
                SEL_ALU <= "XXXX";
                SEL_R   <= "11";
                ESCR_R  <= '1';
                ESCR_P  <= '0';
                WR      <= '0';
            when "00011" => -- LD Ri, [constante]
                SEL_PC  <= "000";
                SEL_F   <= "XXX";
                ESCR_F  <= '0';
                SEL_ALU <= "XXXX";
                SEL_R   <= "10";
                ESCR_R  <= '1';
                ESCR_P  <= '0';
                WR      <= '0';
            when "00100" => -- ST [constante], Ri
                SEL_PC  <= "000";
                SEL_F   <= "XXX";
                ESCR_F  <= '0';
                SEL_ALU <= "XXXX";
                SEL_R   <= "XX";
                ESCR_R  <= '0';
                ESCR_P  <= '0';
                WR      <= '1';

            -- Lógica/Aritmética
            when "00101" => -- ADD Ri, Rj
                SEL_PC  <= "000";
                SEL_F   <= "XXX";
                ESCR_F  <= '0';
                SEL_ALU <= "0000";
                SEL_R   <= "00";
                ESCR_R  <= '1';
                ESCR_P  <= '0';
                WR      <= '0';
            when "00110" => -- SUB Ri, Rj
                SEL_PC  <= "000";
                SEL_F   <= "XXX";
                ESCR_F  <= '0';
                SEL_ALU <= "0001";
                SEL_R   <= "00";
                ESCR_R  <= '1';
                ESCR_P  <= '0';
                WR      <= '0';
            when "00111" => -- AND Ri, Rj
                SEL_PC  <= "000";
                SEL_F   <= "XXX";
                ESCR_F  <= '0';
                SEL_ALU <= "0010";
                SEL_R   <= "00";
                ESCR_R  <= '1';
                ESCR_P  <= '0';
                WR      <= '0';
            when "01000" => -- NAND Ri, Rj
                SEL_PC  <= "000";
                SEL_F   <= "XXX";
                ESCR_F  <= '0';
                SEL_ALU <= "0011";
                SEL_R   <= "00";
                ESCR_R  <= '1';
                ESCR_P  <= '0';
                WR      <= '0';
            when "01001" => -- OR Ri, Rj
                SEL_PC  <= "000";
                SEL_F   <= "XXX";
                ESCR_F  <= '0';
                SEL_ALU <= "0100";
                SEL_R   <= "00";
                ESCR_R  <= '1';
                ESCR_P  <= '0';
                WR      <= '0';
            when "01010" => -- NOR Ri, Rj
                SEL_PC  <= "000";
                SEL_F   <= "XXX";
                ESCR_F  <= '0';
                SEL_ALU <= "0101";
                SEL_R   <= "00";
                ESCR_R  <= '1';
                ESCR_P  <= '0';
                WR      <= '0';
            when "01011" => -- XOR Ri, Rj
                SEL_PC  <= "000";
                SEL_F   <= "XXX";
                ESCR_F  <= '0';
                SEL_ALU <= "0110";
                SEL_R   <= "00";
                ESCR_R  <= '1';
                ESCR_P  <= '0';
                WR      <= '0';
            when "01100" => -- XNOR Ri, Rj
                SEL_PC  <= "000";
                SEL_F   <= "XXX";
                ESCR_F  <= '0';
                SEL_ALU <= "0111";
                SEL_R   <= "00";
                ESCR_R  <= '1';
                ESCR_P  <= '0';
                WR      <= '0';

            -- Comparação
            when "01101" => -- CMP Ri, Rj
                SEL_PC  <= "000";
                SEL_F   <= "XXX";
                ESCR_F  <= '1';
                SEL_ALU <= "1000";
                SEL_R   <= "XX";
                ESCR_R  <= '0';
                ESCR_P  <= '0';
                WR      <= '0';

            -- Saltos
            when "01110" => -- JE constante
                SEL_PC  <= "010";
                SEL_F   <= "010";
                ESCR_F  <= '0';
                SEL_ALU <= "XXXX";
                SEL_R   <= "XX";
                ESCR_R  <= '0';
                ESCR_P  <= '0';
                WR      <= '0';
            when "01111" => -- JL constante
                SEL_PC  <= "010";
                SEL_F   <= "000";
                ESCR_F  <= '0';
                SEL_ALU <= "XXXX";
                SEL_R   <= "XX";
                ESCR_R  <= '0';
                ESCR_P  <= '0';
                WR      <= '0';
            when "10000" => -- JLE constante
                SEL_PC  <= "010";
                SEL_F   <= "001";
                ESCR_F  <= '0';
                SEL_ALU <= "XXXX";
                SEL_R   <= "XX";
                ESCR_R  <= '0';
                ESCR_P  <= '0';
                WR      <= '0';
            when "10001" => -- JGE constante
                SEL_PC  <= "010";
                SEL_F   <= "011";
                ESCR_F  <= '0';
                SEL_ALU <= "XXXX";
                SEL_R   <= "XX";
                ESCR_R  <= '0';
                ESCR_P  <= '0';
                WR      <= '0';
            when "10010" => -- JG constante
                SEL_PC  <= "010";
                SEL_F   <= "100";
                ESCR_F  <= '0';
                SEL_ALU <= "XXXX";
                SEL_R   <= "XX";
                ESCR_R  <= '0';
                ESCR_P  <= '0';
                WR      <= '0';
            when "10011" => -- JMP constante
                SEL_PC  <= "001";
                SEL_F   <= "XXX";
                ESCR_F  <= '0';
                SEL_ALU <= "XXXX";
                SEL_R   <= "XX";
                ESCR_R  <= '0';
                ESCR_P  <= '0';
                WR      <= '0';
            when "10100" => -- JZ Ri, constante
                SEL_PC  <= "011";
                SEL_F   <= "XXX";
                ESCR_F  <= '0';
                SEL_ALU <= "XXXX";
                SEL_R   <= "XX";
                ESCR_R  <= '0';
                ESCR_P  <= '0';
                WR      <= '0';
            when "10101" => -- JN Ri, constante
                SEL_PC  <= "100";
                SEL_F   <= "XXX";
                ESCR_F  <= '0';
                SEL_ALU <= "XXXX";
                SEL_R   <= "XX";
                ESCR_R  <= '0';
                ESCR_P  <= '0';
                WR      <= '0';

            when others => -- NOP e instruções não definidas
                SEL_PC  <= "000";
                SEL_F   <= "XXX";
                ESCR_F  <= '0';
                SEL_ALU <= "XXXX";
                SEL_R   <= "XX";
                ESCR_R  <= '0';
                ESCR_P  <= '0';
                WR      <= '0';
        end case;
    end process;
end Behavioral;