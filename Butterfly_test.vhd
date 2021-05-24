
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Butterfly_test IS
END Butterfly_test;
 
ARCHITECTURE behavior OF Butterfly_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Butterfly
    PORT(
         reset : IN  std_logic;
         clk : IN  std_logic;
         x1_r : IN  std_logic_vector(24 downto 0);
         x1_i : IN  std_logic_vector(24 downto 0);
         x2_r : IN  std_logic_vector(24 downto 0);
         x2_i : IN  std_logic_vector(24 downto 0);
         w_r : IN  std_logic_vector(17 downto 0);
         w_i : IN  std_logic_vector(17 downto 0);
         y1_r : OUT  std_logic_vector(24 downto 0);
         y1_i : OUT  std_logic_vector(24 downto 0);
         y2_r : OUT  std_logic_vector(24 downto 0);
         y2_i : OUT  std_logic_vector(24 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';
   signal x1_r : std_logic_vector(24 downto 0) := (others => '0');
   signal x1_i : std_logic_vector(24 downto 0) := (others => '0');
   signal x2_r : std_logic_vector(24 downto 0) := (others => '0');
   signal x2_i : std_logic_vector(24 downto 0) := (others => '0');
   signal w_r : std_logic_vector(17 downto 0) := (others => '0');
   signal w_i : std_logic_vector(17 downto 0) := (others => '0');

 	--Outputs
   signal y1_r : std_logic_vector(24 downto 0);
   signal y1_i : std_logic_vector(24 downto 0);
   signal y2_r : std_logic_vector(24 downto 0);
   signal y2_i : std_logic_vector(24 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Butterfly PORT MAP (
          reset => reset,
          clk => clk,
          x1_r => x1_r,
          x1_i => x1_i,
          x2_r => x2_r,
          x2_i => x2_i,
          w_r => w_r,
          w_i => w_i,
          y1_r => y1_r,
          y1_i => y1_i,
          y2_r => y2_r,
          y2_i => y2_i
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
		x1_r <= "0000100000000000000000000";
		x2_r <= "0000100000000000000000000";
		w_r <=  "101000000000000000";
		x1_i <= "0000100000000000000000000";
		x2_i <= "0000100000000000000000000";
		w_i <=  "101000000000000000"; wait for 8*clk_period;
		x1_r <= "0100000000000000000000000";
		x2_r <= "0100000000000000000000000";
		w_r <=  "110000000000000000";
		x1_i <= "0100100000000000000000000";
		x2_i <= "0100100000000000000000000";
		w_i <=  "010000000000000000"; wait for 6*clk_period;
		reset<= '0';  wait for clk_period;
		reset <= '1'; wait for 6*clk_period;

      assert false severity failure;

   end process;

END;
