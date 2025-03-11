library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port (
        Operando1  : in  std_logic_vector(7 downto 0);  -- Primeiro operando (8 bits)
        Operando2  : in  std_logic_vector(7 downto 0);  -- Segundo operando (8 bits)
        SEL_ALU    : in  std_logic_vector(3 downto 0);  -- Seletor da operação (4 bits)
        Resultado  : out std_logic_vector(7 downto 0);  -- Saída do resultado (8 bits)
        COMP_FLAG  : out std_logic_vector(4 downto 0)   -- Sinal de comparação (5 bits)
    );
end ALU;

architecture Behavioral of ALU is
begin
    process (Operando1, Operando2, SEL_ALU)
    begin
        -- Valor padrão para COMP_FLAG (0 quando não há comparação)
        COMP_FLAG <= "00000"; 
        
        case SEL_ALU is
            -- Soma
            when "0000" => 
                Resultado <= std_logic_vector(signed(Operando1) + signed(Operando2));

            -- Subtração
            when "0001" => 
                Resultado <= std_logic_vector(signed(Operando1) - signed(Operando2));

            -- AND lógico
            when "0010" => 
                Resultado <= Operando1 and Operando2;

            -- NAND lógico
            when "0011" => 
                Resultado <= not (Operando1 and Operando2);

            -- OR lógico
            when "0100" => 
                Resultado <= Operando1 or Operando2;

            -- NOR lógico
            when "0101" => 
                Resultado <= not (Operando1 or Operando2);

            -- XOR lógico
            when "0110" => 
                Resultado <= Operando1 xor Operando2;

            -- XNOR lógico
            when "0111" => 
                Resultado <= not (Operando1 xor Operando2);

            -- Comparações (Afetam apenas COMP_FLAG)
            when "1000" =>  
                -- Todos os bits de COMP_FLAG ficam a 0 no início
                COMP_FLAG <= (others => '0');
                if (signed(Operando1) < signed(Operando2)) then
                    COMP_FLAG(0) <= '1';
                end if;
                if (signed(Operando1) <= signed(Operando2)) then
                    COMP_FLAG(1) <= '1';
                end if;
                if (Operando1 = Operando2) then
                    COMP_FLAG(2) <= '1';
                end if;
                if (signed(Operando1) >= signed(Operando2)) then
                    COMP_FLAG(3) <= '1';
                end if;
                if (signed(Operando1) > signed(Operando2)) then
                    COMP_FLAG(4) <= '1';
                end if;
                -- Deixar o Resultado como "00000000" quando houver comparação
                Resultado <= (others => '0');

            when others => 
                COMP_FLAG <= (others => 'X'); 
                Resultado <= (others => 'X');
        end case;
    end process;
end Behavioral;
