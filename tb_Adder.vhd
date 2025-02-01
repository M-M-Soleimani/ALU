library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Generic_Adder is
end tb_Generic_Adder;

architecture Behavioral of tb_Generic_Adder is
    signal A              : std_logic_vector(3 downto 0);
    signal B              : std_logic_vector(3 downto 0);
    signal Cin            : std_logic;
    signal Sum            : std_logic_vector(3 downto 0);
    signal Zero_flag      : std_logic;
    signal Carry_flag     : std_logic;
    signal Borrow_flag    : std_logic;
    signal Overflow_flag  : std_logic;
    signal Greater_flag    : std_logic;
    signal Equal_flag     : std_logic;

    component Generic_Adder
        Generic (
            size : integer := 4
        );
        Port (
            A              : in  std_logic_vector(size-1 downto 0);
            B              : in  std_logic_vector(size-1 downto 0);
            Cin            : in  std_logic;
            Sum            : out std_logic_vector(size-1 downto 0);
            Zero_flag      : out std_logic;
            Carry_flag     : out std_logic;
            Borrow_flag    : out std_logic;
            Overflow_flag  : out std_logic;
            Greater_flag    : out std_logic;
            Equal_flag     : out std_logic
        );
    end component;

begin
    uut: Generic_Adder
        GENERIC PORT ( size => 4 )
        port map (
            A => A,
            B => B,
            Cin => Cin,
            Sum => Sum,
            Zero_flag => Zero_flag,
            Carry_flag => Carry_flag,
            Borrow_flag => Borrow_flag,
            Overflow_flag => Overflow_flag,
            Greater_flag => Greater_flag,
            Equal_flag => Equal_flag
        );

    stim_proc: process
    begin
        A <= "1001";  
        B <= "1001";  
        Cin <= '0';
        wait for 20 ns;

        A <= "1010";  
        B <= "0001";  
        Cin <= '1';       
        wait for 20 ns;

        A <= "0111";  
        B <= "0001";  
        Cin <= '0';
        wait for 20 ns;

        A <= "0000";  
        B <= "0000";  
        Cin <= '0';
        wait for 20 ns;

        A <= "0010";  
        B <= "0001";  
        Cin <= '0';
        wait for 20 ns;

        A <= "0110";  
        B <= "0010";  
        Cin <= '0';
        wait for 20 ns;

        wait;
    end process;

end Behavioral;
