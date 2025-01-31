library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Comparator is
    Generic ( size : INTEGER := 4 );
    Port (
        A : in  STD_LOGIC_VECTOR (size-1 downto 0);
        B : in  STD_LOGIC_VECTOR (size-1 downto 0);
        Result : out STD_LOGIC
    );
end Comparator;

architecture Behavioral of Comparator is
begin
    process(A, B)
    begin
        if unsigned(A) > unsigned(B) then
            Result <= '1';
        else
            Result <= '0';
        end if;
    end process;
end Behavioral;
