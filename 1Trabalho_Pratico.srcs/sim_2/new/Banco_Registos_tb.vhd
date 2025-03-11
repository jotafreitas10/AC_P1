library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Banco_Registos_tb is
end Banco_Registos_tb;

architecture tb of Banco_Registos_tb is

  component Banco_Registos is
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

  signal clk      : std_logic := '0';
  signal escr_r   : std_logic := '0';
  signal sel_reg1 : std_logic_vector(2 downto 0) := "000";
  signal sel_reg2 : std_logic_vector(2 downto 0) := "001";
  signal dados_r  : std_logic_vector(7 downto 0) := (others => '0');
  signal operando1, operando2 : std_logic_vector(7 downto 0);

begin

  UUT: Banco_Registos port map(
    CLK       => clk,
    ESCR_R    => escr_r,
    SEL_REG1  => sel_reg1,
    SEL_REG2  => sel_reg2,
    Dados_R   => dados_r,
    Operando1 => operando1,
    Operando2 => operando2
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
    -- Inicialmente, os registradores já estão em zero (graças à inicialização)
    wait for 20 ns;
    
    -- Escrita: escrever "10101010" no registrador selecionado por sel_reg1
    escr_r <= '1';
    sel_reg1 <= "010";  -- Seleciona o reg 2 (índice 2)
    dados_r  <= "10101010";
    wait for 20 ns;
    escr_r <= '0';  -- Para a escrita

    wait for 20 ns;
    
    -- Leitura: alterar a seleção para verificar o conteúdo
    sel_reg1 <= "010";  -- Deve ler "10101010" em operando1
    sel_reg2 <= "001";  -- Como não foi escrita, deve ser "00000000"
    wait for 40 ns;
    
    wait;
  end process;

end tb;
