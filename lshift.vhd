library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Left_Shift is
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
end Left_Shift;

architecture Behavioral of Left_Shift is
    SIGNAL temp_result : STD_LOGIC_VECTOR (size - 1 DOWNTO 0);
begin

    process(A, Shift , temp_result)
    begin
        if Shift = '1' then
            temp_result <= A(size-2 DOWNTO 0) & '0';  
            Carry_flag <= A(size-1); 
            if unsigned(temp_result) = unsigned(A) then
                Equal_flag <= '1';
            else
                Equal_flag <= '0';
            end if;
            if unsigned(A) > unsigned(temp_result) then
                Greater_flag <= '1';
            else
                Greater_flag <= '0';
            end if;
        else
            temp_result <= A;  
            Carry_flag <= '0';  
            Equal_flag <= '1';
            Greater_flag <= '0';
        end if;

        if (unsigned(temp_result) = 0) then
            Zero_flag <= '1';
        else
            Zero_flag <= '0';
        end if;

        Overflow_flag <= '0'; 
        Borrow_flag <= '0'; 
    end process;

    Result <= temp_result;

end Behavioral;