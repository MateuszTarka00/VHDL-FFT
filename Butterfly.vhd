library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Butterfly is

port(	reset, clk: in std_logic;
		x1_r, x1_i, x2_r, x2_i: in std_logic_vector(24 downto 0);
		w_r, w_i : in std_logic_vector(17 downto 0);
		y1_r, y1_i, y2_r, y2_i : out std_logic_vector(24 downto 0));
		
end entity Butterfly;

architecture Butterfly_arch of Butterfly is

	component multiplier is 
		port( reset, clk: in std_logic;
				a_r, a_i : in std_logic_vector(24 downto 0);
				b_r, b_i : in std_logic_vector(17 downto 0);
				y_rr, y_ii, y_ri, y_ir : out std_logic_vector(24 downto 0));
	end component multiplier;
	
	component adder is
	port( reset, clk: in std_logic;
			a_r,a_i,b_r,b_i : in  std_logic_vector(24 downto 0);
			y_r, y_i : out std_logic_vector(24 downto 0));
	end component adder;	
	
	component subtractor is
	port(	reset, clk: in std_logic;
			a_r,a_i,b_r,b_i : in  std_logic_vector(24 downto 0);
			y_r, y_i : out std_logic_vector(24 downto 0));
	end component subtractor;	
	
	signal start : std_logic;
	signal counter : std_logic_vector(1 downto 0);
	signal reg_x2r, reg_x2i : std_logic_vector(24 downto 0);
	signal reg_x1r, reg_x1i : std_logic_vector(24 downto 0);
	signal reg_y2r, reg_y2i : std_logic_vector(24 downto 0);
	signal reg_y1r, reg_y1i : std_logic_vector(24 downto 0);
	
	signal il_rr, il_ii, il_ri, il_ir : std_logic_vector(24 downto 0);
	signal  sum_il_r, sum_il_i : std_logic_vector(24 downto 0);

begin
	memory : process(reset, clk) -- aby wynik byl poprawny, trzeba opóznic sygnal wyjsciowy
		begin
		
			if( reset = '0' ) then
			
				counter <= (others => '0');
				reg_x2r <= (others => '0');
				reg_x2i <= (others => '0');
				reg_x1r <= (others => '0');
				reg_x1i <= (others => '0');
				
				y2_r <= (others => '0');
				y2_i <= (others => '0');
				y1_r <= (others => '0');
				y1_i <= (others => '0');
				
				start <= '0';
			-- w momencie gdy jest zmiana na wyjsciu rozpoczyna sie zlicznie
			elsif(clk'Event and clk = '1') then
				if( (reg_x1r /= x1_r or reg_x1i /= x1_i or reg_x2r /= x2_r or reg_x2i /= x2_i) and counter = "00" ) then
					start <= '1';
					reg_x1r <= x1_r; 
					reg_x1i <= x1_i;
					reg_x2r <= x2_r;
					reg_x2i <= x1_i;
				end if;
				
				if(start = '1') then
					counter <= counter + "01";
				end if;
				
				if(counter = "11") then -- mnozenie i dodanie wyników mnozenie zajmuje 2 cylke zegara, wiec dopiero 3 cykl daje poprawny wynik
					counter <= "00"; -- dlatego wynik podawany jest na wyjscie dopiero po 3 cyklach od zmiany któregos wejscia
					start <= '0';
					
					y2_r <= reg_y2r;
					y2_i <= reg_y2i;
					y1_r <= reg_y1r;
					y1_i <= reg_y1i;
					
				end if;
					
			end if;
	end process;
	
	Mul : multiplier port map (reset, clk, reg_x2r, reg_x2i, w_r, w_i, il_rr, il_ii, il_ri, il_ir); -- mnozenie
	Add_M1 : adder port map (reset, clk, il_rr, il_ri, il_ii, il_ir, sum_il_r, sum_il_i);  -- dodanie mnozenia
	Add_1 : adder port map (reset, clk, x1_r, x1_i, sum_il_r, sum_il_i, reg_y1r, reg_y1i); -- dodanie wyniku mnozenia i pierwszj liczby
	sub_1 : subtractor port map (reset, clk, x1_r, x1_i, sum_il_r, sum_il_i, reg_y2r, reg_y2i); -- odjecie od pierwszej liczby wyniku mnozenia
	
end Butterfly_arch;

