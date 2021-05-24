library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
 
entity FFT is
	port( reset, clk : in std_logic;
			x0_r, x1_r,  x2_r,  x3_r,  x4_r,  x5_r,  x6_r,  x7_r: in std_logic_vector(24 downto 0);
			x0_i, x1_i,  x2_i,  x3_i,  x4_i,  x5_i,  x6_i,  x7_i: in std_logic_vector(24 downto 0);
			y0_r, y1_r,  y2_r,  y3_r,  y4_r,  y5_r,  y6_r,  y7_r: out std_logic_vector(24 downto 0);
			y0_i, y1_i,  y2_i,  y3_i,  y4_i,  y5_i,  y6_i,  y7_i: out std_logic_vector(24 downto 0));
end FFT;

architecture FFT_arch of FFT is

component butterfly is
		port( reset, clk : in std_logic;
				x1_r, x1_i, x2_r, x2_i: in std_logic_vector(24 downto 0);
				w_r, w_i : in std_logic_vector(17 downto 0);
				y1_r, y1_i, y2_r, y2_i : out std_logic_vector(24 downto 0));
	end component butterfly;
	-- wspólczynniki uzywane w algorytmie FFT
	constant w0: std_logic_vector(17 downto 0) := "000000000000000000"; -- 0
	constant w1: std_logic_vector(17 downto 0) := "010000000000000000"; -- 1
	constant w2: std_logic_vector(17 downto 0) := "110000000000000000"; -- -1
	constant w3: std_logic_vector(17 downto 0) := "001011010100000100"; -- 0.707
	constant w4: std_logic_vector(17 downto 0) := "101011010100000100"; -- -0.707 
	-- rejestry przechowujace wyniki pierwszego i  drugiego stopnia i przekazujace je do kolejnego stopnia
	signal b10_r, b11_r, b12_r, b13_r, b14_r, b15_r, b16_r, b17_r: std_logic_vector(24 downto 0); 
	signal b10_i, b11_i, b12_i, b13_i, b14_i, b15_i, b16_i, b17_i: std_logic_vector(24 downto 0);
	signal b20_r, b21_r, b22_r, b23_r, b24_r, b25_r, b26_r, b27_r: std_logic_vector(24 downto 0);
	signal b20_i, b21_i, b22_i, b23_i, b24_i, b25_i, b26_i, b27_i: std_logic_vector(24 downto 0);

begin
	--Pierwszy stopien
	b11 : butterfly port map (reset, clk, x0_r, x0_i, x4_r, x4_i, w1, w0, b10_r, b10_i, b11_r, b11_i);
	b12 : butterfly port map (reset, clk, x2_r, x2_i, x6_r, x6_i, w1, w0, b12_r, b12_i, b13_r, b13_i);
	b13 : butterfly port map (reset, clk, x1_r, x5_i, x1_r, x5_i, w1, w0, b14_r, b14_i, b15_r, b15_i);
	b14 : butterfly port map (reset, clk, x3_r, x3_i, x7_r, x7_i, w1, w0, b16_r, b16_i, b17_r, b17_i);
	
	--Drugi stopien
	b21 : butterfly port map (reset, clk, b10_r, b10_i, b12_r, b12_i, w1, w0, b20_r, b20_i, b21_r, b21_i);
	b22 : butterfly port map (reset, clk, b11_r, b11_i, b13_r, b13_i, w0, w2, b22_r, b22_i, b23_r, b23_i);
	b23 : butterfly port map (reset, clk, b14_r, b14_i, b16_r, b16_i, w1, w0, b24_r, b24_i, b25_r, b25_i);
	b24 : butterfly port map (reset, clk, b15_r, b15_i, b17_r, b17_i, w0, w2, b26_r, b26_i, b27_r, b27_i);
	
	--Trzeci stopien
	b31 : butterfly port map (reset, clk, b20_r, b20_i, b24_r, b24_i, w1, w0, y0_r, y0_i, y4_r, y4_i);
	b32 : butterfly port map (reset, clk, b22_r, b22_i, b26_r, b26_i, w3, w4, y1_r, y1_i, y5_r, y5_i);
	b33 : butterfly port map (reset, clk, b21_r, b21_i, b25_r, b25_i, w0, w2, y2_r, y2_i, y6_r, y6_i);
	b34 : butterfly port map (reset, clk, b23_r, b23_i, b27_r, b27_i, w4, w3, y3_r, y3_i, y7_r, y7_i);

end FFT_arch;

