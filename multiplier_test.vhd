--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:31:38 05/19/2021
-- Design Name:   
-- Module Name:   C:/studia/Vlsi_projekty/Fast_Fourier_Transfirm/multiplier_test.vhd
-- Project Name:  Fast_Fourier_Transfirm
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: multiplier
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY multiplier_test IS
END multiplier_test;
 
ARCHITECTURE behavior OF multiplier_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT multiplier
    PORT(
         reset : IN  std_logic;
         clk : IN  std_logic;
         a_r : IN  std_logic_vector(33 downto 0);
         a_i : IN  std_logic_vector(33 downto 0);
         b_r : IN  std_logic_vector(17 downto 0);
         b_i : IN  std_logic_vector(17 downto 0);
         y_rr : OUT  std_logic_vector(33 downto 0);
         y_ii : OUT  std_logic_vector(33 downto 0);
         y_ri : OUT  std_logic_vector(33 downto 0);
         y_ir : OUT  std_logic_vector(33 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';
   signal a_r : std_logic_vector(33 downto 0) := (others => '0');
   signal a_i : std_logic_vector(33 downto 0) := (others => '0');
   signal b_r : std_logic_vector(17 downto 0) := (others => '0');
   signal b_i : std_logic_vector(17 downto 0) := (others => '0');

 	--Outputs
   signal y_rr : std_logic_vector(33 downto 0);
   signal y_ii : std_logic_vector(33 downto 0);
   signal y_ri : std_logic_vector(33 downto 0);
   signal y_ir : std_logic_vector(33 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: multiplier PORT MAP (
          reset => reset,
          clk => clk,
          a_r => a_r,
          a_i => a_i,
          b_r => b_r,
          b_i => b_i,
          y_rr => y_rr,
          y_ii => y_ii,
          y_ri => y_ri,
          y_ir => y_ir
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
		a_r <= "0000110000000000000000000000000000";
		b_r <= "101111111111111111";
		a_i <= "0000100000000000000000000000000000";
		b_i <= "111000000000000000"; wait for 2*clk_period;
		a_r <= "0000100001001001000000000000000000";
		b_r <= "110000000000000000"; wait for 2*clk_period;
		reset<= '0';  wait for clk_period;
		reset <= '1'; wait for 2*clk_period;

      assert false severity failure;

   end process;

END;
