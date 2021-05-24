library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity subtractor is
	port( clk,reset : in std_logic;
			a_r,a_i,b_r,b_i : in  std_logic_vector(24 downto 0);
			y_r, y_i : out std_logic_vector(24 downto 0));
end subtractor;

architecture subtractor_arch of subtractor is

begin

subtract_real : process(reset,clk)
	begin
		if(reset = '0') then
			y_r <= (others => '0');
		elsif(clk'Event and clk = '1') then
			if( (a_r(24) XNOR b_r(24)) = '0')then -- gdy liczby maja rózne znaki to  je dodajemy 
				y_r(23 downto 0) <= a_r(23 downto 0) + b_r(23 downto 0);
				y_r(24) <= a_r(24); -- w tym przypadku sa dwa minusu jeden plus wiec znakiem wynikowym jest plus
			elsif( a_r(23 downto 0) > b_r(23 downto 0)) then -- gdy liczby maja takie same znaki  
				y_r(23 downto 0) <= a_r(23 downto 0) - b_r(23 downto 0); -- odejmujemy mniejsza od wiekszej
				y_r(24) <= a_r(24); -- i wstawiamy znak wiekszej
			elsif( a_r(23 downto 0) < b_r(23 downto 0)) then
				y_r(23 downto 0) <= b_r(23 downto 0) - a_r(23 downto 0); 
				y_r(24) <= b_r(24);
			else
				y_r <= (others => '0');
			end if;
		end if;
	
end process subtract_real;

subtract_imaginary : process(reset,clk) --  to samo tylko dla liczby urojonej
	begin
		if(reset = '0') then
			y_i <= (others => '0');
		elsif(clk'Event and clk = '1') then
			if( (a_i(24) XNOR b_i(24)) = '0')then 
				y_i(23 downto 0) <= a_i(23 downto 0) + b_i(23 downto 0);
				y_i(24) <= '0';
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
end process subtract_imaginary;

end subtractor_arch;

