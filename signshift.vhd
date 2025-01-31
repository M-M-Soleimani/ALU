LIBRARY IEEE ;
USE IEEE.STD_LOGIC_1164.ALL ;
USE IEEE.NUMERIC_STD.ALL ;

ENTITY Arithmetic_Right_Shift IS 
    GENERIC ( size : INTEGER := 4 );
    PORT (
        CLK : IN STD_LOGIC ;
        Reset : IN STD_LOGIC ;
        Shift : IN STD_LOGIC ; 
        A : IN STD_LOGIC_VECTOR ( size - 1 DOWNTO 0 );
        Result : OUT STD_LOGIC_VECTOR ( size - 1 DOWNTO 0 );
        Zero_flag : OUT STD_LOGIC ;
        Carry_flag : OUT STD_LOGIC ;
        Borrow_flag : OUT STD_LOGIC ;
        Overflow_flag : OUT STD_LOGIC ;
        Greater_flag : OUT STD_LOGIC ;
        Equal_flag : OUT STD_LOGIC 
    );
END Arithmetic_Right_Shift ;

ARCHITECTURE Behavioral OF Arithmetic_Right_Shift IS 
    SIGNAL Reg : STD_LOGIC_VECTOR ( size - 1 DOWNTO 0 );
BEGIN 
    PROCESS ( CLK , Reset )
    BEGIN 
        if ( Reset = '1' ) then
            Reg <= ( OTHERS => '0' );
        elsif rising_edge (CLK) then
            if Shift = '1' then 
                Reg <= A (size - 1) & A ( size - 1 DOWNTO 1 );
            else
                Reg <= A ;
            end if ;
        end if ;    
    END PROCESS ;

    Result <= Reg ;

    PROCESS ( Reg , A )
    BEGIN 
            
        Zero_flag <= '1';
        for i in 0 to size-1 loop
            if Reg(i) = '1' then
                Zero_flag <= '0';
            end if ;
        end loop ;

        Carry_flag <= Reg(0) ;
        Borrow_flag <= '0'; 
        Overflow_flag <= '0'; 
        if unsigned(Reg) > unsigned(A) then
            Greater_flag <= '1';
        else
            Greater_flag <= '0';
        end if ;

        if unsigned(Reg) = unsigned(A) then
            Equal_flag <= '1';
        else
            Equal_flag <= '0';
        end if ;
    END PROCESS ;

END Behavioral ;
            