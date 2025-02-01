library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Arithmetic_Right_Shift is 
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
end Arithmetic_Right_Shift;

architecture Behavioral of Arithmetic_Right_Shift is 
    SIGNAL temp_result : STD_LOGIC_VECTOR (size - 1 DOWNTO 0);
begin 

    process(A, Shift)
    begin 
        if Shift = '1' then 
            temp_result <= A(size - 1) & A(size - 1 DOWNTO 1);  
        else
            temp_result <= A;  
        end if;    
    end process;

    Result <= temp_result;

    process(temp_result, A)
    begin 
        Zero_flag <= '1';
        for i in 0 to size - 1 loop
            if temp_result(i) = '1' then
                Zero_flag <= '0';
            end if;
        end loop;

        Carry_flag <= temp_result(0);  
        Borrow_flag <= '0'; 
        Overflow_flag <= '0'; 
        
        if signed(temp_result) > signed(A) then
            Greater_flag <= '1';
        else
            Greater_flag <= '0';
        end if;

        if signed(temp_result) = signed(A) then
            Equal_flag <= '1';
        else
            Equal_flag <= '0';
        end if;
    end process;

end Behavioral;
