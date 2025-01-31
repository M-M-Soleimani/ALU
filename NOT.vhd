LIBRARY IEEE ;
USE IEEE.STD_LOGIC_1164.ALL ;
USE IEEE.NUMERIC_STD.ALL ;

ENTITY generic_not IS 
    GENERIC ( size : INTEGER := 4 );
    PORT ( A : IN STD_LOGIC_VECTOR (size-1 DOWNTO 0);
           Result : BUFFER STD_LOGIC_VECTOR (size-1 DOWNTO 0);
           Zero_flag : OUT STD_LOGIC ;
           Carry_flag : OUT STD_LOGIC ;
           Borrow_flag : OUT STD_LOGIC ;
           Overflow_flag : OUT STD_LOGIC ;
           Greater_flag : OUT STD_LOGIC ;
           Equal_flag : OUT STD_LOGIC 
    );
END generic_not ;

ARCHITECTURE Behavior OF generic_not IS 
BEGIN 
    PROCESS(A)
    BEGIN
        Result <= NOT A ;
    END PROCESS ;

    PROCESS(Result)
    BEGIN
        if (Result = "0000") then 
            Zero_flag <= '1';
        else
            Zero_flag <= '0'; 
        end if ;

        Carry_flag <= '0';
        Borrow_flag <= '0';
        Overflow_flag <= '0';
        Overflow_flag <= '0';
        Greater_flag <= '0';
        Equal_flag <= '0';
        
    END PROCESS ;
END Behavior ;