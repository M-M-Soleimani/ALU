LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY GENERIC_OR IS
    GENERIC (size: INTEGER := 4);

    PORT (
        A : IN STD_LOGIC_VECTOR(size-1 downto 0);
        B : IN STD_LOGIC_VECTOR(size-1 downto 0);
        Result : BUFFER STD_LOGIC_VECTOR(size-1 downto 0);
        Zero_flag : OUT STD_LOGIC;
        Carry_flag : OUT STD_LOGIC;
        Borrow_flag : OUT STD_LOGIC;
        Overflow_flag : OUT STD_LOGIC;
        Greater_flag : OUT STD_LOGIC;
        Equal_flag : OUT STD_LOGIC
    );
END GENERIC_OR;

ARCHITECTURE Behavioral OF GENERIC_OR IS
BEGIN 
    PROCESS(A, B)
    BEGIN
        Result <= A OR B;
    END PROCESS ;
    
    PROCESS(A ,B ,Result)
    BEGIN
        Zero_flag <= '1';
        Equal_flag <= '1';
        Carry_flag <= '0';
        Borrow_flag <= '0';
        Overflow_flag <= '0';

        for i in 0 to size-1 loop
            if Result(i) = '1' then
                Zero_flag <= '0';
            end if;

            if A(i) /= B(i) then
                Equal_flag <= '0';
            end if;
        end loop;
        
        if unsigned(A) > unsigned(B) then
            Greater_flag <= '1';
        else
            Greater_flag <= '0';
        end if;
        
    END PROCESS;

END Behavioral;
