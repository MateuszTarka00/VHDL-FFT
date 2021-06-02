library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multiplier is
	port( reset,clk: in std_logic; 
			a_r,a_i: in  std_logic_vector(33 downto 0);
			b_r,b_i: in	 std_logic_vector(17 downto 0);
			y_rr, y_ii, y_ri, y_ir : out std_logic_vector(33 downto 0));
end multiplier;

architecture multiplier_arch of multiplier is

signal x_rr, x_ii, x_ri, x_ir : std_logic_vector(33 downto 0);
 
begin
--Prz mnozeniu liczb zespolonych trzeba kazda czesc rzeczywista i urojona pomnozyc przez siebie
mult_x_rr : process(reset,clk) 

variable x : std_logic_vector(32 downto 0);

begin -- w algorytmie wartosci w beda wynosic 0, 1, -1, 0.7071 lub -0.7071, zatem w procesie zostaly uwzglednione tylko bity reprezentujace
-- te wartosci
	if(reset = '0') then
			x_rr <= (others => '0');
			x := (others => '0');
		elsif(clk'Event and clk = '1') then	
				x := (others => '0');
				for i in 0 to 16 loop
					if(b_r(i) = '1') then --jezeli na danym bicie jest wartosc jeden wykona sie dzialanie
						x := x + a_r(32 downto 16-i); -- do wyjscia dodawana jest przesunieta wartosc mnozonej liczby
					end if;
				end loop;	
				
				x_rr(32 downto 0) <= x;
				
				if((a_r(32 downto 0)> "00") and (b_r(16 downto 0) > "00")) then
					x_rr(33) <= (a_r(33) xor b_r(17)); -- na koncu jezeli znaki liczb byly takie same to znak na wyjsciu jest + (0), jezeli nie to jest - (1)
				else
					x_rr(33) <= '0';
				end if;
end if;

end process mult_x_rr;

mult_x_ii : process(reset,clk)

variable x : std_logic_vector(32 downto 0);

begin
	
	if(reset = '0') then
			x_ii <= (others => '0');
			x := (others => '0');
		elsif(clk'Event and clk = '1') then
				x := (others => '0');
				x_ii <= (others => '0');
				for i in 0 to 16 loop
					if(b_i(i) = '1') then
						x := x + a_i(32 downto 16-i);
					end if;
				end loop;
				
				x_ii(32 downto 0) <= x;
				
				if((a_i(32 downto 0)> "00") and (b_i(16 downto 0) > "00")) then
					x_ii(33) <= (a_i(33) xnor b_i(17)); -- w tym miejscu jest odwrotnie, poniewaz do iloczynu znaków dochodzi znak - wynikajacy z mnozenia j*j
				else
					x_ii(33) <= '0';
				end if;
		end if;
	
	
end process mult_x_ii;

mult_x_ri : process(reset,clk)

variable x : std_logic_vector(32 downto 0);

begin

	if(reset = '0') then
			x_ri <= (others => '0');
			x := (others => '0');
		elsif(clk'Event and clk = '1') then
				x_ri <= (others => '0');
				x := (others => '0');
				for i in 0 to 16 loop
					if(b_i(i) = '1') then
						x := x + a_r(32 downto 16-i);
					end if;
				end loop;
				
				x_ri(32 downto 0) <= x;
			
				if((a_r(32 downto 0)> "00") and (b_i(16 downto 0) > "00")) then
					x_ri(33) <= (a_r(33) xor b_i(17)); -- na koncu jezeli znaki liczb byly takie same to znak na wyjsciu jest + (0), jezeli nie to jest - (1)
				else
					x_ri(33) <= '0';
				end if;
		end if;

end process mult_x_ri;

mult_x_ir : process(reset,clk)

variable x : std_logic_vector(32 downto 0);

begin
	if(reset = '0') then
			x_ir <= (others => '0');
			x := (others => '0');
		elsif(clk'Event and clk = '1') then
				x := (others => '0');
				x_ir <= (others => '0');
				for i in 0 to 16 loop
					if(b_r(i) = '1') then
						x := x + a_i(32 downto 16-i);
					end if;
				end loop;	
				
				x_ir(32 downto 0) <= x;
				
				if((a_i(32 downto 0)> "00") and (b_r(16 downto 0) > "00")) then
					x_ir(33) <= (a_i(33) xor b_r(17)); -- na koncu jezeli znaki liczb byly takie same to znak na wyjsciu jest + (0), jezeli nie to jest - (1)
				else
					x_ir(33) <= '0';
				end if;
		end if;

end process mult_x_ir;

-- gdy start jest 0 to na wyjsciu jest wynik a gdy jest wlaczony reset to jest zerowane
	y_rr <= x_rr;
	y_ii <= x_ii;
	y_ri <= x_ri;
	y_ir <= x_ir;
	
end multiplier_arch;

