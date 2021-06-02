library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Butterfly is

port(	reset, clk, start_in: in std_logic;
		x1_r, x1_i, x2_r, x2_i: in std_logic_vector(33 downto 0);
		w_r, w_i : in std_logic_vector(17 downto 0);
		y1_r, y1_i, y2_r, y2_i : out std_logic_vector(33 downto 0);
		start_out: out std_logic);
		
end entity Butterfly;

architecture Butterfly_arch of Butterfly is

	component multiplier is 
		port( reset, clk: in std_logic;
				a_r, a_i : in std_logic_vector(33 downto 0);
				b_r, b_i : in std_logic_vector(17 downto 0);
				y_rr, y_ii, y_ri, y_ir : out std_logic_vector(33 downto 0));
	end component multiplier;
	
	component adder is
	port( reset, clk: in std_logic;
			a_r,a_i,b_r,b_i : in  std_logic_vector(33 downto 0);
			y_r, y_i : out std_logic_vector(33 downto 0));
	end component adder;	
	
	component subtractor is
	port(	reset, clk: in std_logic;
			a_r,a_i,b_r,b_i : in  std_logic_vector(33 downto 0);
			y_r, y_i : out std_logic_vector(33 downto 0));
	end component subtractor;	
	
	signal il_rr, il_ii, il_ri, il_ir : std_logic_vector(33 downto 0);
	signal sum_il_r, sum_il_i : std_logic_vector(33 downto 0);
	signal reg_y1r, reg_y1i, reg_y2r, reg_y2i : std_logic_vector(33 downto 0);
	signal reg_x1r, reg_x1i, reg_x2r, reg_x2i : std_logic_vector(33 downto 0);
	
	type STANY is ( sleep, multiply, add_multiply, result);
	signal stan, stan_nast : STANY;

begin

reg : process(reset, clk)
	begin
		if( reset = '0' ) then
			stan <= sleep;
		elsif(clk'event and clk = '1') then
			stan <= stan_nast;
		end if;
end process;
	
komb : process(stan, start_in)
	begin
	
	stan_nast <= stan;
			
		case(stan) is	
			when sleep =>
				if( start_in = '1' ) then
					stan_nast <= multiply;
				end if;
					
			when multiply =>
				stan_nast <= add_multiply;
					
			when add_multiply =>
				stan_nast <= result;
				
			when result =>
				stan_nast <= sleep;
					
		end case;
	end process;
	
	Mul : multiplier port map (reset, clk, reg_x2r, reg_x2i, w_r, w_i, il_rr, il_ii, il_ri, il_ir); -- mnozenie
	Add_M1 : adder port map (reset, clk, il_rr, il_ri, il_ii, il_ir, sum_il_r, sum_il_i);  -- dodanie mnozenia
	Add_1 : adder port map (reset, clk, x1_r, x1_i, sum_il_r, sum_il_i, reg_y1r, reg_y1i); -- dodanie wyniku mnozenia i pierwszj liczby
	sub_1 : subtractor port map (reset, clk, x1_r, x1_i, sum_il_r, sum_il_i, reg_y2r, reg_y2i); -- odjecie od pierwszej liczby wyniku mnozenia
	
	y1_r <= (others => '0') when reset = '0' else reg_y1r when stan = result;
	y1_i <= (others => '0') when reset = '0' else reg_y1i when stan = result;
	y2_r <= (others => '0') when reset = '0' else reg_y2r when stan = result;
	y2_i <= (others => '0') when reset = '0' else reg_y2i when stan = result;
	
	reg_x1r <= (others => '0') when reset = '0' else x1_r when stan = sleep;
	reg_x1i <= (others => '0') when reset = '0' else x1_i when stan = sleep;
	reg_x2r <= (others => '0') when reset = '0' else x2_r when stan = sleep;
	reg_x2i <= (others => '0') when reset = '0' else x2_i when stan = sleep;
	
	start_out <= '1' when stan = result else '0';
	
end Butterfly_arch;

