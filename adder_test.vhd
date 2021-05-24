library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
 
ENTITY adder_test IS
END adder_test;
 
ARCHITECTURE behavior OF adder_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT adder
    PORT(
         reset : IN  std_logic;
         clk : IN  std_logic;
         a_r : IN  std_logic_vector(24 downto 0);
         a_i : IN  std_logic_vector(24 downto 0);
         b_r : IN  std_logic_vector(24 downto 0);
         b_i : IN  std_logic_vector(24 downto 0);
         y_r : OUT  std_logic_vector(24 downto 0);
         y_i : OUT  std_logic_vector(24 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';
   signal a_r : std_logic_vector(24 downto 0) := (others => '0');
   signal a_i : std_logic_vector(24 downto 0) := (others => '0');
   signal b_r : std_logic_vector(24 downto 0) := (others => '0');
   signal b_i : std_logic_vector(24 downto 0) := (others => '0');

 	--Outputs
   signal y_r : std_logic_vector(24 downto 0);
   signal y_i : std_logic_vector(24 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: adder PORT MAP (
          reset => reset,
          clk => clk,
          a_r => a_r,
          a_i => a_i,
          b_r => b_r,
          b_i => b_i,
          y_r => y_r,
          y_i => y_i
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		reset <= '0'; wait for 2*clk_period;
		reset <= '1'; wait for clk_period;
		a_r <= "0000100000000000000000000";
		b_r <= "1010000000000000000000001";
		a_i <= "0000100000000000000000000";
		b_i <= "1010000000000000000000001"; wait for 2*clk_period;
		a_r <= "0000100001001001000000000";
		b_r <= "1010000000000000010010101"; wait for 2*clk_period;
		reset<= '0';  wait for clk_period;
		reset <= '1'; wait for 2*clk_period;

      assert false severity failure;

   end process;

END;
