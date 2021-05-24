library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multiplier is
	port( reset,clk: in std_logic; 
			a_r,a_i: in  std_logic_vector(24 downto 0);
			b_r,b_i: in	 std_logic_vector(17 downto 0);
			y_rr, y_ii, y_ri, y_ir : out std_logic_vector(24 downto 0));
end multiplier;

architecture multiplier_arch of multiplier is

signal x_rr, x_ii, x_ri, x_ir : std_logic_vector(24 downto 0);
signal start : std_logic;
 
begin
--Prz mnozeniu liczb zespolonych trzeba kazda czesc rzeczywista i urojona pomnozyc przez siebie
mult_x_rr : process(reset,clk) 

begin -- w algorytmie wartosci w beda wynosic 0, 1, -1, 0.7071 lub -0.7071, zatem w procesie zostaly uwzglednione tylko bity reprezentujace
-- te wartosci
	if(reset = '0') then
			x_rr <= (others => '0');
		elsif(clk'Event and clk = '1') then
			if(start = '1') then					
				for i in 0 to 16 loop
					if(b_r(i) = '1') then --jezeli na danym bicie jest wartosc jeden wykona sie dzialanie
						x_rr(23 downto 0) <= (x_rr(23 downto 0) + a_r(23 downto 16-i)); -- do wyjscia dodawana jest przesunieta wartosc mnozonej liczby
					end if;
				end loop;	
				
				if((a_r(23 downto 0)> "00") and (b_r(16 downto 0) > "00")) then
					x_rr(24) <= (a_r(24) xor b_r(17)); -- na koncu jezeli znaki liczb byly takie same to znak na wyjsciu jest + (0), jezeli nie to jest - (1)
				else
					x_rr(24) <= '0';
				end if;
			else
				x_rr <= (others => '0');
			end if;
end if;

end process mult_x_rr;

mult_x_ii : process(reset,clk)

begin
	
	if(reset = '0') then
			x_ii <= (others => '0');
		elsif(clk'Event and clk = '1') then
			if(start = '1') then
				for i in 0 to 16 loop
					if(b_i(i) = '1') then
						x_ii(23 downto 0) <= x_ii(23 downto 0) + a_i(23 downto 16-i);
					end if;
				end loop;
				if((a_i(23 downto 0)> "00") and (b_i(16 downto 0) > "00")) then
					x_ii(24) <= (a_i(24) xnor b_i(17)); -- w tym miejscu jest odwrotnie, poniewaz do iloczynu znaków dochodzi znak - wynikajacy z mnozenia j*j
				else
					x_ii(24) <= '0';
				end if;
			else
				x_ii <= (others => '0');
			end if;
		end if;
	
	
end process mult_x_ii;

mult_x_ri : process(reset,clk)

begin

	if(reset = '0') then
			x_ri <= (others => '0');
		elsif(clk'Event and clk = '1') then
			if(start = '1') then
				for i in 0 to 16 loop
					if(b_i(i) = '1') then
						x_ri(23 downto 0) <= x_ri(23 downto 0) + a_r(23 downto 16-i);
					end if;
				end loop;
			
				if((a_r(23 downto 0)> "00") and (b_i(16 downto 0) > "00")) then
					x_ri(24) <= (a_r(24) xor b_i(17)); -- na koncu jezeli znaki liczb byly takie same to znak na wyjsciu jest + (0), jezeli nie to jest - (1)
				else
					x_ri(24) <= '0';
				end if;
				
			else
				x_ri <= (others => '0');
			end if;
		end if;

end process mult_x_ri;

mult_x_ir : process(reset,clk)

begin
	if(reset = '0') then
			x_ir <= (others => '0');
		elsif(clk'Event and clk = '1') then
			if(start = '1') then			
				for i in 0 to 16 loop
					if(b_r(i) = '1') then
						x_ir(23 downto 0) <= x_ir(23 downto 0) + a_i(23 downto 16-i);
					end if;
				end loop;	
				
				if((a_i(23 downto 0)> "00") and (b_r(16 downto 0) > "00")) then
					x_ir(24) <= (a_i(24) xor b_r(17)); -- na koncu jezeli znaki liczb byly takie same to znak na wyjsciu jest + (0), jezeli nie to jest - (1)
				else
					x_ir(24) <= '0';
				end if;
			else
				x_ir <= (others => '0');
			end if;
		end if;

end process mult_x_ir;

start_proc : process(reset,a_r,a_i,b_r,b_i,x_rr,x_ri,x_ir,x_ii)
begin
	if(reset = '0') then -- zabezpieczenie, przy ciaglym liczeniu wartosci pojawialy sie bledy
		start <= '1'; -- teraz przy zmianie wejscia algorytm wykona sie tylko raz
	elsif(a_r'Event or a_i'Event or b_r'Event or b_i'Event) then 
		start <= '1';
	elsif(x_rr'Event or x_ii'Event or x_ri'Event or x_ir'Event) then
		start <= '0';
	end if;
end process start_proc;
-- gdy start jest 0 to na wyjsciu jest wynik a gdy jest wlaczony reset to jest zerowane
	y_rr <= x_rr when start = '0' and start'Event else (others => '0') when reset = '0';
	y_ii <= x_ii when start = '0' and start'Event else (others => '0') when reset = '0';
	y_ri <= x_ri when start = '0' and start'Event else (others => '0') when reset = '0';
	y_ir <= x_ir when start = '0' and start'Event else (others => '0') when reset = '0';
	
end multiplier_arch;

