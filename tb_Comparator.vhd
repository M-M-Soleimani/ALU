library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Comparison_tb is
end Comparison_tb;

architecture Behavioral of Comparison_tb is
    signal A : STD_LOGIC_VECTOR (3 downto 0);
    signal B : STD_LOGIC_VECTOR (3 downto 0);
    signal Result : STD_LOGIC;

    component Comparison
        Generic ( size : INTEGER := 4 );
        Port (
            A : in  STD_LOGIC_VECTOR (size-1 downto 0);
            B : in  STD_LOGIC_VECTOR (size-1 downto 0);
            Result : out STD_LOGIC
        );
    end component;

begin
    uut: Comparison
        port map (
            A => A,
            B => B,
            Result => Result
        );

    stim_proc: process
    begin
        A <= "0100";
        B <= "0010";
        wait for 10 ns;
        assert (Result = '1') report "Test case 1 failed" severity error;

        A <= "0010";
        B <= "0100";
        wait for 10 ns;
        assert (Result = '0') report "Test case 2 failed" severity error;

        A <= "0011";
        B <= "0011";
        wait for 10 ns;
        assert (Result = '0') report "Test case 3 failed" severity error;
        
        wait;
    end process;

end Behavioral;
