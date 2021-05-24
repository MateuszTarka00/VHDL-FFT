library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adder is
	port( reset, clk : in std_logic;
			a_r,a_i,b_r,b_i : in  std_logic_vector(24 downto 0); -- wejscia rzeczywiste i urojone
			y_r, y_i : out std_logic_vector(24 downto 0)); -- wyjscia rzeczywiste i urojone
end adder;

architecture adder_arch of adder is

begin

add_real : process(reset,clk)
	begin
		if(reset = '0') then
			y_r <= (others => '0');
		elsif(clk'Event and clk = '1') then
			if( (a_r(24) XNOR b_r(24)) = '1')then --Sprawdzane jest czy sa dwie liczby ujemne lub dodatnie
				y_r(23 downto 0) <= a_r(23 downto 0) + b_r(23 downto 0); -- jezeli sa dwie liczby o tym samym znaku to je dodajemy
				y_r(24) <= a_r(24); -- i  zostawiamy wspólny znak
			elsif( a_r(23 downto 0) > b_r(23 downto 0)) then -- jezeli nie to sprawdzamy która liczba jest wieksza
				y_r(23 downto 0) <= a_r(23 downto 0) - b_r(23 downto 0); -- odejmujemy mniejsza od wiekszej
				y_r(24) <= a_r(24); -- i wstawiamy znak wiekszej liczby
			elsif( a_r(23 downto 0) < b_r(23 downto 0)) then
				y_r(23 downto 0) <= b_r(23 downto 0) - a_r(23 downto 0); 
				y_r(24) <= b_r(24);
			else
				y_r <= (others => '0');
			end if;
		end if;
		
end process add_real;

add_imaginary : process(reset,clk) -- taki sam proces tylko dla czesci urojonej

	begin
		if(reset = '0') then
			y_i <= (others => '0');
		elsif(clk'Event and clk = '1') then
			if( (a_i(24) XNOR b_i(24)) = '1')then 
				y_i(23 downto 0) <= a_i(23 downto 0) + b_i(23 downto 0);
				y_i(24) <= a_i(24);
			elsif( a_i(23 downto 0) > b_i(23 downto 0)) then
				y_i(23 downto 0) <= a_i(23 downto 0) - b_i(23 downto 0);
				y_i(24) <= a_i(24);
			elsif( a_i(23 downto 0) < b_i(23 downto 0)) then
				y_i(23 downto 0) <= b_i(23 downto 0) - a_i(23 downto 0); 
				y_i(24) <= b_i(24);
			else
				y_i <= (others => '0');
			end if;
		end if;
		
end process add_imaginary;

end architecture adder_arch;

