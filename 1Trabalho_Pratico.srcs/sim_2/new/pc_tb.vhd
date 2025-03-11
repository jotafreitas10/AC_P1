library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pc_tb is
end pc_tb;

architecture tb of pc_tb is

  component PC is
    Port (
      CLK      : in  STD_LOGIC;
      Reset    : in  STD_LOGIC;
      ESCR_PC  : in  STD_LOGIC;
      Constante : in  STD_LOGIC_VECTOR(7 downto 0);
      Endereco : out STD_LOGIC_VECTOR(7 downto 0)
    );
  end component;

  signal clk       : std_logic := '0';
  signal reset     : std_logic := '0';
  signal escr_pc   : std_logic := '0';
  signal constante : std_logic_vector(7 downto 0) := (others => '0');
  signal endereco  : std_logic_vector(7 downto 0);

begin

  UUT: PC port map(
    CLK      => clk,
    Reset    => reset,
    ESCR_PC  => escr_pc,
    Constante => constante,
    Endereco => endereco
  );

  -- Gerador de clock
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
    -- Aplica reset por 40 ns
    reset <= '1';
    escr_pc <= '0';
    wait for 40 ns;
    
    -- Tira reset para iniciar a contagem
    reset <= '0';
    wait for 20 ns;
    
    -- Testa o incremento (ESCR_PC = '0')
    wait for 100 ns;
    
    -- Testa o salto (ESCR_PC = '1'): carrega uma constante
    escr_pc <= '1';
    constante <= "00010101";  -- Exemplo de endereço para salto
    wait for 20 ns;
    escr_pc <= '0';  -- Depois volta ao incremento
    
    wait for 100 ns;
    wait;
  end process;

end tb;
