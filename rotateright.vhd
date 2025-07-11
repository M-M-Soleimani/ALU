LIBRARY IEEE ;
USE IEEE.STD_LOGIC_1164.ALL ;
USE IEEE.NUMERIC_STD.ALL ;

ENTITY Right_Rotate IS 
    GENERIC ( size : INTEGER := 4 );
    PORT (
        Rotate : IN STD_LOGIC ; 
        A : IN STD_LOGIC_VECTOR ( size - 1 DOWNTO 0 );
        Result : OUT STD_LOGIC_VECTOR ( size - 1 DOWNTO 0 );
        Zero_flag : OUT STD_LOGIC ;
        Carry_flag : OUT STD_LOGIC ;
        Borrow_flag : OUT STD_LOGIC ;
        Overflow_flag : OUT STD_LOGIC ;
        Greater_flag : OUT STD_LOGIC ;
        Equal_flag : OUT STD_LOGIC 
    );
END Right_Rotate ;

ARCHITECTURE Behavioral OF Right_Rotate IS
    SIGNAL Reg : STD_LOGIC_VECTOR ( size - 1 DOWNTO 0 );
BEGIN 

    PROCESS ( Rotate , A )
    BEGIN  
        if ( Rotate = '1' ) then
            Reg <= A(0) & A(size-1 DOWNTO 1);  
        else 
            Reg <= A ;
        end if ;
    END PROCESS ;

    Result <= Reg ;

    PROCESS ( Reg , A )
    BEGIN
        Zero_flag <= '1';
        for i in 0 to size - 1 loop
            if Reg(i) = '1' then
                Zero_flag <= '0';
            end if;
        end loop;

        Carry_flag <= A(0); 
        Borrow_flag <= '0'; 
        Overflow_flag <= '0'; 

        if signed(Reg) > signed(A) then
            Greater_flag <= '1';
        else
            Greater_flag <= '0';
        end if;

        if signed(Reg) = signed(A) then
            Equal_flag <= '1';
        else
            Equal_flag <= '0';
        end if;
    END PROCESS ;

    --         if unsigned(Reg) = unsigned(A) then
    --             Equal_flag <= '1';
    --         else
    --             Equal_flag <= '0';
    --         end if ;
    --         if unsigned(A) > unsigned(Reg) then
    --             Greater_flag <= '1';
    --         else
    --             Greater_flag <= '0';
    --         end if ;

    --         if (unsigned(Reg) = 0) then
    --             Zero_flag <= '1';
    --         else
    --             Zero_flag <= '0';
    --         end if;
    --     else 
    --         Reg <= A;  
    --         Carry_flag <= '0';  
    --         Equal_flag <= '1';
    --         Greater_flag <= '0';

    --         if (unsigned(A) = 0) then
    --             Zero_flag <= '1';
    --         else
    --             Zero_flag <= '0';
    --         end if;

    --     end if ;

    --     Borrow_flag <= '0' ;
    --     Overflow_flag <= '0' ;

    -- END PROCESS ;

    -- Result <= Reg ;

END Behavioral ; 
