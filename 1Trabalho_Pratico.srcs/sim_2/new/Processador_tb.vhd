library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Processador_tb is
end Processador_tb;

architecture Behavioral of Processador_tb is

  component Processador is
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
  end component;

  -- Sinais para conectar ao Processador
  signal reset         : std_logic := '1';
  signal clk           : std_logic := '0';
  signal Operando1     : std_logic_vector(7 downto 0);
  signal Constante     : std_logic_vector(7 downto 0) := (others => '0');
  signal Constante_out : std_logic_vector(7 downto 0);
  signal Dados_M       : std_logic_vector(7 downto 0) := (others => '0');
  signal SEL_REG1      : std_logic_vector(2 downto 0) := "000";
  signal SEL_REG2      : std_logic_vector(2 downto 0) := "001";
  signal Endereco      : std_logic_vector(7 downto 0);
  signal Opcode        : std_logic_vector(4 downto 0) := (others => '0');
  signal PIN           : std_logic_vector(7 downto 0) := (others => '0');
  signal POUT          : std_logic_vector(7 downto 0);
  signal WR            : std_logic;

begin

  UUT: Processador port map(
    reset         => reset,
    clk           => clk,
    Operando1     => Operando1,
    Constante     => Constante,
    Constante_out => Constante_out,
    Dados_M       => Dados_M,
    SEL_REG1      => SEL_REG1,
    SEL_REG2      => SEL_REG2,
    Endereco      => Endereco,
    Opcode        => Opcode,
    PIN           => PIN,
    POUT          => POUT,
    WR            => WR
  );

  -- Gerador de Clock
  clk_process: process
  begin
    while true loop
      clk <= '0';
      wait for 10 ns;
      clk <= '1';
      wait for 10 ns;
    end loop;
  end process;

  -- Estímulos
  stimulus: process
  begin
    -- Inicialmente, aplica reset
    reset <= '1';
    wait for 40 ns;
    reset <= '0';
    wait for 20 ns;
    
    -- Fornece estímulos para iniciar a operação
    -- Exemplo: simula um opcode que deveria ativar o Gestor_Perifericos
    Opcode <= "00010";        -- Ajusta conforme a codificação esperada
    Constante <= "00001111";   -- Exemplo de valor para o PC ou operação
    SEL_REG1 <= "001";         -- Seleciona registrador para escrita/leitura
    SEL_REG2 <= "010";         -- Seleciona outro registrador
    Dados_M <= "00010001";     -- Valor vindo da memória de dados
    PIN <= "10101010";         -- Valor de entrada para os periféricos
    
    -- Aguarda alguns ciclos para ver a propagação
    wait for 100 ns;
    
    -- Testa outra condição, por exemplo, uma operação de salto ou outra função
    Opcode <= "00100";        
    Constante <= "00010101";  
    wait for 100 ns;
    
    -- Mantém a simulação para observação dos sinais (principalmente POUT)
    wait;
  end process;

end Behavioral;
