library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Arithmetic_Right_Shift_tb is
end Arithmetic_Right_Shift_tb;

architecture Behavioral of Arithmetic_Right_Shift_tb is
    component Arithmetic_Right_Shift
        Generic (
            size : integer := 4
        );
        Port (
            Shift           : IN  STD_LOGIC; 
            A               : IN  STD_LOGIC_VECTOR (size - 1 DOWNTO 0);
            Result          : OUT STD_LOGIC_VECTOR (size - 1 DOWNTO 0);
            Zero_flag       : OUT std_logic;
            Carry_flag      : OUT std_logic;
            Borrow_flag     : OUT std_logic;
            Overflow_flag   : OUT std_logic;
            Greater_flag    : OUT std_logic;
            Equal_flag      : OUT std_logic 
        );
    end component;

    signal Shift           : STD_LOGIC:='0';
    signal A               : STD_LOGIC_VECTOR (3 DOWNTO 0):= (others => '0');
    signal Result          : STD_LOGIC_VECTOR (3 DOWNTO 0):= (others => '0');
    signal Zero_flag       : std_logic:='0';
    signal Carry_flag      : std_logic:='0';
    signal Borrow_flag     : std_logic:='0';
    signal Overflow_flag   : std_logic:='0';
    signal Greater_flag    : std_logic:='0';
    signal Equal_flag      : std_logic:='0';

begin
    uut: Arithmetic_Right_Shift
        port map (
            Shift => Shift,
            A => A,
            Result => Result,
            Zero_flag => Zero_flag,
            Carry_flag => Carry_flag,
            Borrow_flag => Borrow_flag,
            Overflow_flag => Overflow_flag,
            Greater_flag => Greater_flag,
            Equal_flag => Equal_flag
        );

    process
    begin
        A <= "1101"; Shift <= '1';
        wait for 10 ns;

        A <= "1010"; Shift <= '1';
        wait for 10 ns;

        A <= "0001"; Shift <= '1';
        wait for 10 ns;

        A <= "1111"; Shift <= '0';
        wait for 10 ns;

        A <= "0000"; Shift <= '1';
        wait for 10 ns;

        A <= "1101"; Shift <= '1';
        wait for 10 ns;

        wait;
    end process;

end Behavioral;
