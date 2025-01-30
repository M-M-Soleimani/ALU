library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Shift_Register_Left is
end tb_Shift_Register_Left;

architecture Behavioral of tb_Shift_Register_Left is
    signal clk         : std_logic := '0';
    signal reset       : std_logic := '0';
    signal shift       : std_logic := '0';
    signal A           : std_logic_vector(3 downto 0) := (others => '0');
    signal Result      : std_logic_vector(3 downto 0);
    signal Zero_flag    : std_logic;
    signal Carry_flag   : std_logic;
    signal Borrow_flag  : std_logic;
    signal Overflow_flag : std_logic;
    signal Greater_flag  : std_logic;
    signal Equal_flag    : std_logic;

    component Shift_Register_Left
        Generic (
            size : integer := 4
        );
        Port (
            clk         : in  std_logic;
            reset       : in  std_logic;
            shift       : in  std_logic;
            A           : in  std_logic_vector(size-1 downto 0);
            Result      : out std_logic_vector(size-1 downto 0);
            Zero_flag    : out std_logic;
            Carry_flag   : out std_logic;
            Borrow_flag  : out std_logic;
            Overflow_flag : out std_logic;
            Greater_flag  : out std_logic;
            Equal_flag    : out std_logic
        );
    end component;

begin
    uut: Shift_Register_Left
        port map (
            clk => clk,
            reset => reset,
            shift => shift,
            A => A,
            Result => Result,
            Zero_flag => Zero_flag,
            Carry_flag => Carry_flag,
            Borrow_flag => Borrow_flag,
            Overflow_flag => Overflow_flag,
            Greater_flag => Greater_flag,
            Equal_flag => Equal_flag
        );

    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
        end loop;
    end process;


    stim_proc: process
    begin
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        
        A <= "1101";
        wait for 20 ns;

        shift <= '1';
        wait for 20 ns;

        shift <= '0';
        wait for 20 ns;

        A <= "1010";
        wait for 20 ns;

        shift <= '1';
        wait for 20 ns;

        shift <= '0';
        wait for 20 ns;

        A <= "0001";
        wait for 20 ns;

        shift <= '1';
        wait for 20 ns;

        wait;
    end process;

end Behavioral;
