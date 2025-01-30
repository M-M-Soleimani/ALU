library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Shift_Register_Left is
    Generic (
        size : integer := 4
    );
    Port (
        clk         : in  std_logic;
        reset       : in  std_logic;
        shift       : in  std_logic;
        A     : in  std_logic_vector(size-1 downto 0);
        Result    : out std_logic_vector(size-1 downto 0);
        Zero_flag    : out std_logic;
        Carry_flag   : out std_logic;
        Borrow_flag  :  out std_logic;
        Overflow_flag : out std_logic;
        Greater_flag  : out std_logic;
        Equal_flag    : out std_logic
    );
end Shift_Register_Left;

architecture Behavioral of Shift_Register_Left is
    signal reg : std_logic_vector(size-1 downto 0);
begin
    process(clk, reset)
    begin
        if reset = '1' then
            reg <= (others => '0');
        elsif rising_edge(clk) then
            if shift = '1' then
                reg <= reg(size-2 downto 0) & '0';
            else
                reg <= A;
            end if;
        end if;
    end process;

    Result <= reg;

    process(reg, A)
    begin

        Zero_flag <= '1';
        for i in 0 to size-1 loop
            if reg(i) = '1' then
                Zero_flag <= '0';
            end if;
        end loop;

        Carry_flag <= reg(size-1);
        Overflow_flag <= '0'; 
        Borrow_flag <= '0';
        if unsigned(reg) > unsigned(A) then
            Greater_flag <= '1';
        else
            Greater_flag <= '0';
        end if;

        if unsigned(reg) = unsigned(A) then
            Equal_flag <= '1';
        else
            Equal_flag <= '0';
        end if;
    end process;

end Behavioral;