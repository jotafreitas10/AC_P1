library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Processador is
    Port (
        reset, clk : in STD_LOGIC;
        Operando1 : out STD_LOGIC_VECTOR (7 downto 0);
        Constante : in STD_LOGIC_VECTOR (7 downto 0); 
        Constante_out : out STD_LOGIC_VECTOR (7 downto 0); 
        Dados_M : in STD_LOGIC_VECTOR (7 downto 0); 
        SEL_REG1     : in STD_LOGIC_VECTOR (2 downto 0);  
        SEL_REG2     : in STD_LOGIC_VECTOR (2 downto 0);  
        Endereco : out STD_LOGIC_VECTOR (7 downto 0); 
        Opcode : in STD_LOGIC_VECTOR (4 downto 0);  
        PIN : in STD_LOGIC_VECTOR(7 downto 0);
        POUT : out STD_LOGIC_VECTOR(7 downto 0); 
        WR : out STD_LOGIC 
    );
end Processador;

architecture Struct of Processador is

    component Mux_PC
    Port (
        SEL_PC     : in  STD_LOGIC_VECTOR(2 downto 0);
        S_FLAG     : in  STD_LOGIC; 
        Operando1  : in  STD_LOGIC_VECTOR(7 downto 0); 
        NOR_Operando : in STD_LOGIC;
        bit_maior_Peso : in STD_LOGIC;
        ESCR_PC    : out STD_LOGIC 
    );
    end component;
    
    component PC
    Port (
        CLK      : in  STD_LOGIC;
        Reset    : in  STD_LOGIC; 
        ESCR_PC  : in  STD_LOGIC; 
        Constante : in  STD_LOGIC_VECTOR(7 downto 0); 
        Endereco : out STD_LOGIC_VECTOR(7 downto 0)
    );
    end component;
    
    component ROM_Decod
    Port (
        opcode   : in  STD_LOGIC_VECTOR(4 downto 0); 
        SEL_PC  : out STD_LOGIC_VECTOR(2 downto 0);
        SEL_F   : out STD_LOGIC_VECTOR(2 downto 0);
        ESCR_F  : out STD_LOGIC;
        SEL_ALU : out STD_LOGIC_VECTOR(3 downto 0);
        ESCR_R  : out STD_LOGIC;
        SEL_R   : out STD_LOGIC_VECTOR(1 downto 0);
        ESCR_P  : out STD_LOGIC;
        WR      : out STD_LOGIC
    );
    end component;
    
    component RegistoFlags
    Port (
        CLK        : in  std_logic;                   
        ESCR_F     : in  std_logic;                   
        COMP_FLAG  : in  std_logic_vector(4 downto 0); 
        SEL_F      : in  std_logic_vector(2 downto 0); 
        S_FLAG     : out std_logic                     
    );
    end component;
    
    component ALU
    Port (
        Operando1  : in  std_logic_vector(7 downto 0); 
        Operando2  : in  std_logic_vector(7 downto 0);  
        SEL_ALU    : in  std_logic_vector(3 downto 0);  
        Resultado  : out std_logic_vector(7 downto 0);  
        COMP_FLAG  : out std_logic_vector(4 downto 0)  
    );
    end component;
    
    component Gestor_Perifericos
    Port (
        CLK       : in  std_logic;                       
        ESCR_P    : in  std_logic;                       
        PIN       : in  std_logic_vector(7 downto 0);   
        Operando1 : in  std_logic_vector(7 downto 0);   
        Dados_IN  : out std_logic_vector(7 downto 0);   
        POUT      : out std_logic_vector(7 downto 0)    
    );
    end component;
    
    component MUX_Registos
    Port (
        SEL_R     : in  std_logic_vector(1 downto 0);  
        Resultado : in  std_logic_vector(7 downto 0); 
        Dados_IN  : in  std_logic_vector(7 downto 0);  
        Dados_M   : in  std_logic_vector(7 downto 0);  
        Constante : in  std_logic_vector(7 downto 0); 
        Dados_R   : out std_logic_vector(7 downto 0)   
    );
    end component;
    
    component Banco_Registos
    Port (
        CLK       : in  std_logic;                       
        ESCR_R    : in  std_logic;                       
        SEL_REG1  : in  std_logic_vector(2 downto 0);   
        SEL_REG2  : in  std_logic_vector(2 downto 0);  
        Dados_R   : in  std_logic_vector(7 downto 0);   
        Operando1 : out std_logic_vector(7 downto 0);   
        Operando2 : out std_logic_vector(7 downto 0) 
    );
    end component;

    component NOR_Operando is
    Port ( O0 : in STD_LOGIC;
           O1 : in STD_LOGIC;
           O2 : in STD_LOGIC;
           O3 : in STD_LOGIC;
           O4 : in STD_LOGIC;
           O5 : in STD_LOGIC;
           O6 : in STD_LOGIC;
           O7 : in STD_LOGIC;
           NOR_Operando1 : out STD_LOGIC);
    end component;

    -- Sinais internos
    signal S_ESCR_PC, S_S_FLAG, S_ESCR_F, S_ESCR_R, S_ESCR_P, S_NOR_Operando1 : STD_LOGIC;
    signal S_SEL_PC, S_SEL_F : STD_LOGIC_VECTOR(2 downto 0);
    signal S_SEL_ALU : STD_LOGIC_VECTOR(3 downto 0);
    signal S_SEL_R : STD_LOGIC_VECTOR(1 downto 0);
    signal S_COMP_FLAG : STD_LOGIC_VECTOR(4 downto 0);
    signal S_Resultado, S_Dados_R, S_Dados_IN, S_Operando2_int : STD_LOGIC_VECTOR(7 downto 0);
    signal S_Operando1_int : STD_LOGIC_VECTOR(7 downto 0); -- Sinal intermediário
    signal S_SEL_REG1_internal, S_SEL_REG2_internal : STD_LOGIC_VECTOR(2 downto 0); -- Usar variáveis internas
    signal S_Sinal_Operando1 : STD_LOGIC_VECTOR(7 downto 0); -- Vetor de 9 bits para o NOR_Operando
    signal S_bit_maior_Peso : STD_LOGIC;
begin

    S_SEL_REG1_internal <= SEL_REG1;
    S_SEL_REG2_internal <= SEL_REG2;
    -- Mapeamento de portas
    PC1: PC port map (
        CLK => clk,
        Reset => reset,
        ESCR_PC => S_ESCR_PC,
        Constante => Constante,
        Endereco => Endereco
    );

    Mux_PC1: Mux_PC port map (
        SEL_PC => S_SEL_PC,
        S_FLAG => S_S_FLAG,
        Operando1 => S_Operando1_int,
        NOR_Operando => S_NOR_Operando1,
        bit_maior_Peso => S_bit_maior_Peso,
        ESCR_PC => S_ESCR_PC
    );

    ROM_Decod1: ROM_Decod port map (
        opcode => Opcode,
        SEL_PC => S_SEL_PC,
        SEL_F => S_SEL_F,
        ESCR_F => S_ESCR_F,
        SEL_ALU => S_SEL_ALU,
        ESCR_R => S_ESCR_R,
        SEL_R => S_SEL_R,
        ESCR_P => S_ESCR_P,
        WR => WR
    );

    RegistoFlags1: RegistoFlags port map (
        CLK => clk,
        ESCR_F => S_ESCR_F,
        COMP_FLAG => S_COMP_FLAG,
        SEL_F => S_SEL_F,
        S_FLAG => S_S_FLAG
    );

    ALU1: ALU port map (
        Operando1 => S_Operando1_int,
        Operando2 => S_Operando2_int,
        SEL_ALU => S_SEL_ALU,
        Resultado => S_Resultado,
        COMP_FLAG => S_COMP_FLAG
    );

    Gestor_Perifericos1: Gestor_Perifericos port map (
        CLK => clk,
        ESCR_P => S_ESCR_P,
        PIN => PIN,
        Operando1 => S_Operando1_int,
        Dados_IN => S_Dados_IN,
        POUT => POUT
    );

    MUX_Registos1: MUX_Registos port map (
        SEL_R => S_SEL_R,
        Resultado => S_Resultado,
        Dados_IN => S_Dados_IN,
        Dados_M => Dados_M,
        Constante => Constante,
        Dados_R => S_Dados_R
    );

    Banco_Registos1: Banco_Registos port map (
        CLK => clk,
        ESCR_R => S_ESCR_R,
        SEL_REG1 => S_SEL_REG1_internal,
        SEL_REG2 => S_SEL_REG2_internal,
        Dados_R => S_Dados_R,
        Operando1 => S_Operando1_int,
        Operando2 => S_Operando2_int
    );

    -- Mapeamento do NOR_Operando
    NOR_Operando_P : NOR_Operando
        port map (
            O0 => S_Sinal_Operando1(0),
            O1 => S_Sinal_Operando1(1),
            O2 => S_Sinal_Operando1(2),
            O3 => S_Sinal_Operando1(3),
            O4 => S_Sinal_Operando1(4),
            O5 => S_Sinal_Operando1(5),
            O6 => S_Sinal_Operando1(6),
            O7 => S_Sinal_Operando1(7),
            NOR_Operando1 => S_NOR_Operando1
        );

    -- Atribuições diretas
    Constante_out <= Constante;
    Operando1 <= S_Operando1_int;

end Struct;
