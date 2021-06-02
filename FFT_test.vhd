library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

 
ENTITY FFT_test IS
END FFT_test;
 
ARCHITECTURE behavior OF FFT_test IS 
 
    COMPONENT FFT
    PORT(
			reset : IN std_logic;
			clk : IN std_logic;
			start_in : IN std_logic;
         x0_r : IN  std_logic_vector(24 downto 0);
         x1_r : IN  std_logic_vector(24 downto 0);
         x2_r : IN  std_logic_vector(24 downto 0);
         x3_r : IN  std_logic_vector(24 downto 0);
         x4_r : IN  std_logic_vector(24 downto 0);
         x5_r : IN  std_logic_vector(24 downto 0);
         x6_r : IN  std_logic_vector(24 downto 0);
         x7_r : IN  std_logic_vector(24 downto 0);
         x0_i : IN  std_logic_vector(24 downto 0);
         x1_i : IN  std_logic_vector(24 downto 0);
         x2_i : IN  std_logic_vector(24 downto 0);
         x3_i : IN  std_logic_vector(24 downto 0);
         x4_i : IN  std_logic_vector(24 downto 0);
         x5_i : IN  std_logic_vector(24 downto 0);
         x6_i : IN  std_logic_vector(24 downto 0);
         x7_i : IN  std_logic_vector(24 downto 0);
         y0_r : OUT  std_logic_vector(33 downto 0);
         y1_r : OUT  std_logic_vector(33 downto 0);
         y2_r : OUT  std_logic_vector(33 downto 0);
         y3_r : OUT  std_logic_vector(33 downto 0);
         y4_r : OUT  std_logic_vector(33 downto 0);
         y5_r : OUT  std_logic_vector(33 downto 0);
         y6_r : OUT  std_logic_vector(33 downto 0);
         y7_r : OUT  std_logic_vector(33 downto 0);
         y0_i : OUT  std_logic_vector(33 downto 0);
         y1_i : OUT  std_logic_vector(33 downto 0);
         y2_i : OUT  std_logic_vector(33 downto 0);
         y3_i : OUT  std_logic_vector(33 downto 0);
         y4_i : OUT  std_logic_vector(33 downto 0);
         y5_i : OUT  std_logic_vector(33 downto 0);
         y6_i : OUT  std_logic_vector(33 downto 0);
         y7_i : OUT  std_logic_vector(33 downto 0)
        );
    END COMPONENT;
    

   --Inputs
	signal reset :  std_logic := '0';
	signal clk : std_logic := '0';
	signal start_in : std_logic;
   signal x0_r : std_logic_vector(24 downto 0) := (others => '0');
   signal x1_r : std_logic_vector(24 downto 0) := (others => '0');
   signal x2_r : std_logic_vector(24 downto 0) := (others => '0');
   signal x3_r : std_logic_vector(24 downto 0) := (others => '0');
   signal x4_r : std_logic_vector(24 downto 0) := (others => '0');
   signal x5_r : std_logic_vector(24 downto 0) := (others => '0');
   signal x6_r : std_logic_vector(24 downto 0) := (others => '0');
   signal x7_r : std_logic_vector(24 downto 0) := (others => '0');
   signal x0_i : std_logic_vector(24 downto 0) := (others => '0');
   signal x1_i : std_logic_vector(24 downto 0) := (others => '0');
   signal x2_i : std_logic_vector(24 downto 0) := (others => '0');
   signal x3_i : std_logic_vector(24 downto 0) := (others => '0');
   signal x4_i : std_logic_vector(24 downto 0) := (others => '0');
   signal x5_i : std_logic_vector(24 downto 0) := (others => '0');
   signal x6_i : std_logic_vector(24 downto 0) := (others => '0');
   signal x7_i : std_logic_vector(24 downto 0) := (others => '0');

 	--Outputs
   signal y0_r : std_logic_vector(33 downto 0);
   signal y1_r : std_logic_vector(33 downto 0);
   signal y2_r : std_logic_vector(33 downto 0);
   signal y3_r : std_logic_vector(33 downto 0);
   signal y4_r : std_logic_vector(33 downto 0);
   signal y5_r : std_logic_vector(33 downto 0);
   signal y6_r : std_logic_vector(33 downto 0);
   signal y7_r : std_logic_vector(33 downto 0);
   signal y0_i : std_logic_vector(33 downto 0);
   signal y1_i : std_logic_vector(33 downto 0);
   signal y2_i : std_logic_vector(33 downto 0);
   signal y3_i : std_logic_vector(33 downto 0);
   signal y4_i : std_logic_vector(33 downto 0);
   signal y5_i : std_logic_vector(33 downto 0);
   signal y6_i : std_logic_vector(33 downto 0);
   signal y7_i : std_logic_vector(33 downto 0);
	
	   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN

   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FFT PORT MAP (
			 reset => reset,
			 clk => clk,
			 start_in => start_in,
          x0_r => x0_r,
          x1_r => x1_r,
          x2_r => x2_r,
          x3_r => x3_r,
          x4_r => x4_r,
          x5_r => x5_r,
          x6_r => x6_r,
          x7_r => x7_r,
          x0_i => x0_i,
          x1_i => x1_i,
          x2_i => x2_i,
          x3_i => x3_i,
          x4_i => x4_i,
          x5_i => x5_i,
          x6_i => x6_i,
          x7_i => x7_i,
          y0_r => y0_r,
          y1_r => y1_r,
          y2_r => y2_r,
          y3_r => y3_r,
          y4_r => y4_r,
          y5_r => y5_r,
          y6_r => y6_r,
          y7_r => y7_r,
          y0_i => y0_i,
          y1_i => y1_i,
          y2_i => y2_i,
          y3_i => y3_i,
          y4_i => y4_i,
          y5_i => y5_i,
          y6_i => y6_i,
          y7_i => y7_i
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
		reset <= '0'; wait for 2*clk_period;
		reset <= '1'; wait for 2*clk_period;
		x0_r <= "0000000010000000000000000";
		x0_i <= "0000000010000000000000000";
		x1_r <= "0000000010000000000000000";
		x1_i <= "0000000010000000000000000";
		x2_r <= "0000000010000000000000000";
		x2_i <= "0000000010000000000000000";
		x3_r <= "0000000010000000000000000";
		x3_i <= "0000000010000000000000000";
		x4_r <= "0000000010000000000000000";
		x4_i <= "0000000010000000000000000";
		x5_r <= "0000000010000000000000000";
		x5_i <= "0000000010000000000000000";
		x6_r <= "0000000010000000000000000";
		x6_i <= "0000000010000000000000000";
		x7_r <= "0000000010000000000000000";
		x7_i <= "0000000010000000000000000"; wait for 2*clk_period;
		start_in <= '1'; wait for 2*clk_period;
		start_in <= '0';
		wait for 18*clk_period;
		assert false severity failure;
   end process;

END;
