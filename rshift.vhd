LIBRARY IEEE ;
USE IEEE.STD_LOGIC_1164.ALL ;
USE IEEE.STD_LOGIC_ARITH.ALL ;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;

ENTITY Right_Shift IS 
    GENERIC ( size : INTEGER := 4 );
    PORT (
        CLK : IN STD_LOGIC ;
        Reset : IN STD_LOGIC ;
        A : IN STD_LOGIC_VECTOR ( size - 1 DOWNTO 0 );
        Amount : IN INTEGER ; --OPTIONAL
        Result : OUT STD_LOGIC_VECTOR ( size - 1 DOWNTO 0 );
        Zero_flag : OUT STD_LOGIC ;
        Carry_flag : OUT STD_LOGIC ;
        Borrow_flag : OUT STD_LOGIC ;
        Overflow_flag : OUT STD_LOGIC ;
        Greater_flag : OUT STD_LOGIC ;
        Equal_flag : OUT STD_LOGIC ;
    );
END Right_Shift ;

ARCHITECTURE Behavior OF Right_Shift IS 
BEGIN 
    VARIABLE temp : STD_LOGIC_VECTOR ( size DOWNTO 0 );
    PROCESS( CLK , Reset );
        if ( Reset = 1 ) then 
            Result <= ( OTHERS => '0' );
            Zero_flag <= '0';
            Carry_flag <= '0';
            Borrow_flag <= '0';
            Overflow_flag <= '0';
            Greater_flag <= '0';
            Equal_flag <= '0';
        elsif rising_edge (CLK) then
            temp <= A ;
            for i in 0 to Amount - 1 LOOP 
                Carry_flag <= temp(0);
                temp = "0" & temp ( size - 1 DOWNTO 1 );
            END LOOP ;
            Result <= temp ;
        end if ;

        if Result = (others => '0') then
            Zero_flag <= '1';
        else
            Zero_flag <= '0';
        end if ;
       
        Carry_flag <= Carry_flag ;
        Borrow_flag <= '0'; 
        Overflow_flag <= '0'; 
        Greater_flag <= '0'; 
        Equal_flag <= '0'; 
        
    END PROCESS ;
END Behavior ;



