LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY placa_mae_tb IS
END placa_mae_tb;

ARCHITECTURE Behavioral OF placa_mae_tb IS

    COMPONENT placa_mae PORT(
         PIN : IN  std_logic_vector(7 downto 0);
         clk : IN  std_logic;
         reset : IN  std_logic;
         POUT : OUT  std_logic_vector(7 downto 0)
    );
    END COMPONENT;

   SIGNAL PIN : std_logic_vector(7 downto 0) := (others => '0');
   SIGNAL clk : std_logic := '0';
   SIGNAL reset : std_logic := '0';

   SIGNAL POUT : std_logic_vector(7 downto 0);

BEGIN

   uut: placa_mae PORT MAP (
          PIN => PIN,
          clk => clk,
          reset => reset,
          POUT => POUT
      );

   Clk_process : PROCESS
   BEGIN
        clk <= '0';
        WAIT FOR 10 ns;
        clk <= '1';
        WAIT FOR 10 ns;
   END PROCESS;

    Rst_process : PROCESS
    BEGIN
        reset <= '1';
        WAIT FOR 35 ns;
        reset <= '0';
        WAIT;
    END PROCESS;

    simulation_process: PROCESS
    BEGIN
        PIN <= "00000001";
        WAIT FOR 20 ns;
        WAIT;
        END PROCESS;
        END;