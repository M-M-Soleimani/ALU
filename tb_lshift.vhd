library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Left_Shift is
end tb_Left_Shift;

architecture Behavioral of tb_Left_Shift is
    signal A             : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal Shift         : STD_LOGIC;
    signal Zero_flag     : STD_LOGIC;
    signal Carry_flag    : STD_LOGIC;
    signal Borrow_flag   : STD_LOGIC;
    signal Overflow_flag : STD_LOGIC;
    signal Greater_flag  : STD_LOGIC;
    signal Equal_flag    : STD_LOGIC;
    signal Result        : STD_LOGIC_VECTOR(3 DOWNTO 0);

    component Left_Shift is
        Generic (
            size : integer := 4
        );
        Port (
            A             : IN  STD_LOGIC_VECTOR (size-1 DOWNTO 0);
            Shift         : IN  STD_LOGIC;
            Zero_flag     : OUT std_logic;
            Carry_flag    : OUT std_logic;
            Borrow_flag   : OUT std_logic;
            Overflow_flag : OUT std_logic;
            Greater_flag  : OUT std_logic;
            Equal_flag    : OUT std_logic;
            Result        : OUT  STD_LOGIC_VECTOR (size-1 DOWNTO 0)
        );
    end component;

begin

    uut: Left_Shift
        port map (
            A => A,
            Shift => Shift,
            Zero_flag => Zero_flag,
            Carry_flag => Carry_flag,
            Borrow_flag => Borrow_flag,
            Overflow_flag => Overflow_flag,
            Greater_flag => Greater_flag,
            Equal_flag => Equal_flag,
            Result => Result
        );

    process
    begin

        A <= "0001";
        Shift <= '1';
        wait for 10 ns;  

        A <= "1001";
        Shift <= '1';
        wait for 10 ns;

        A <= "0110";
        Shift <= '0';
        wait for 10 ns;  

        A <= "1111";
        Shift <= '1';
        wait for 10 ns;  
        
        A <= "1100";
        Shift <= '1';
        wait for 10 ns;  

        wait;
    end process;

end Behavioral;
