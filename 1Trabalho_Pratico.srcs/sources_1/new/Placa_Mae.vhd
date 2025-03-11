-- Biblioteca IEEE
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade da Placa-Mãe
entity Placa_Mae is
    Port (
        reset : in STD_LOGIC;
        clk   : in STD_LOGIC;
        PIN   : in STD_LOGIC_VECTOR (7 downto 0);
        POUT  : out STD_LOGIC_VECTOR (7 downto 0)
    );
end Placa_Mae;

architecture Struct of Placa_Mae is
    
   -- Instância do Processador
   component Processador is
    Port (
        reset         : in STD_LOGIC;
        clk           : in STD_LOGIC;
        Operando1     : out STD_LOGIC_VECTOR (7 downto 0);
        Constante  : in STD_LOGIC_VECTOR (7 downto 0); 
        Constante_out : out STD_LOGIC_VECTOR (7 downto 0); 
        Dados_M       : in STD_LOGIC_VECTOR (7 downto 0); 
        SEL_REG1      : in STD_LOGIC_VECTOR (2 downto 0);  
        SEL_REG2      : in STD_LOGIC_VECTOR (2 downto 0); 
        Endereco      : out STD_LOGIC_VECTOR (7 downto 0); 
        Opcode        : in STD_LOGIC_VECTOR (4 downto 0);  
        PIN           : in STD_LOGIC_VECTOR (7 downto 0);
        POUT          : out STD_LOGIC_VECTOR (7 downto 0); 
        WR            : out STD_LOGIC
    );
   end component;

    -- Instância da Memória de Dados
    component MemoriaDados is
        Port (
            CLK             : in  STD_LOGIC;                      
            WR              : in  STD_LOGIC;                                    
            Constante       : in  STD_LOGIC_VECTOR(7 downto 0);
            Operando1       : in  STD_LOGIC_VECTOR(7 downto 0);    
            Dados_M         : out STD_LOGIC_VECTOR(7 downto 0)  
        );
    end component;

    -- Instância da Memória de Instruções
    component Memoria_de_Instrucoes is
        Port (
            Endereco  : in  STD_LOGIC_VECTOR (7 downto 0);
            opcode    : out STD_LOGIC_VECTOR (4 downto 0);
            Constante : out STD_LOGIC_VECTOR (7 downto 0);
            SEL_REG1  : out STD_LOGIC_VECTOR (2 downto 0);  
            SEL_REG2  : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;

    -- Declaração de sinais internos
    signal S_WR            : STD_LOGIC;
    signal S_opcode        : STD_LOGIC_VECTOR (4 downto 0);
    signal S_SEL_REG1_internal      : STD_LOGIC_VECTOR (2 downto 0);  
    signal S_SEL_REG2_internal      : STD_LOGIC_VECTOR (2 downto 0);
    signal S_Endereco      : STD_LOGIC_VECTOR (7 downto 0);
    signal S_Constante_out     : STD_LOGIC_VECTOR (7 downto 0);
    signal S_Dados_M       : STD_LOGIC_VECTOR (7 downto 0);
    signal S_Operando1     : STD_LOGIC_VECTOR (7 downto 0);
    signal S_Constante  : STD_LOGIC_VECTOR (7 downto 0);

begin
    -- Instância do Processador
    Processador_PM : Processador port map (
        reset     => reset, 
        clk       => clk, 
        Operando1 => S_Operando1, 
        Constante  => S_Constante,  -- Corrigido para Constante_in
        Constante_out => S_Constante_out, 
        Dados_M   => S_Dados_M, 
        SEL_REG1  => S_SEL_REG1_internal,  
        SEL_REG2  => S_SEL_REG2_internal, 
        Endereco  => S_Endereco, 
        Opcode    => S_opcode, 
        PIN       => PIN, 
        POUT      => POUT, 
        WR        => S_WR
    );
    
   -- Instância da Memória de Dados
    Memoria_de_Dados_PM : MemoriaDados port map (
        CLK            => clk,
        WR             => S_WR, 
        Constante      => S_Constante_out, 
        Operando1      => S_Operando1, 
        Dados_M        => S_Dados_M
    );

    -- Instância da Memória de Instruções
    Memoria_de_Instrucoes_PM : Memoria_de_Instrucoes port map (
        Endereco  => S_Endereco, 
        opcode    => S_opcode, 
        Constante => S_Constante, 
        SEL_REG1  => S_SEL_REG1_internal,  
        SEL_REG2  => S_SEL_REG2_internal
    );

end Struct;
