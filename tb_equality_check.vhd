library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Equality_Check_tb is
end Equality_Check_tb;

architecture Behavioral of Equality_Check_tb is
    signal A : STD_LOGIC_VECTOR (3 downto 0);
    signal B : STD_LOGIC_VECTOR (3 downto 0);
    signal Result : STD_LOGIC;

    component Equality_Check
        Generic ( size : INTEGER := 4 );
        Port (
            A : in  STD_LOGIC_VECTOR (size-1 downto 0);
            B : in  STD_LOGIC_VECTOR (size-1 downto 0);
            Result : out STD_LOGIC
        );
    end component;

begin
    uut: Equality_Check
        port map (
            A => A,
            B => B,
            Result => Result
        );

    stim_proc: process
    begin
        A <= "0100";
        B <= "0100";
        wait for 10 ns;

        A <= "0010";
        B <= "0100";
        wait for 10 ns;

        A <= "0011";
        B <= "0011";
        wait for 10 ns;

        A <= "0001";
        B <= "0001";
        wait for 10 ns;

        A <= "0101";
        B <= "0011";
        wait for 10 ns;

        wait;
    end process;

end Behavioral;
