LIBRARY IEEE ;
USE IEEE.STD_LOGIC_1164.ALL ;
USE IEEE.NUMERIC_STD.ALL ;

ENTITY tb_AND IS
END tb_AND ;

ARCHITECTURE behavior OF tb_AND IS
   
    SIGNAL A : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    SIGNAL B : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    
    SIGNAL Result : STD_LOGIC_VECTOR (3 downto 0);
    SIGNAL Zero_flag : STD_LOGIC ;
    SIGNAL Carry_flag : STD_LOGIC ;
    SIGNAL Borrow_flag : STD_LOGIC ;
    SIGNAL Overflow_flag : STD_LOGIC ;
    SIGNAL Greater_flag : STD_LOGIC ;
    SIGNAL Equal_flag : STD_LOGIC ;

BEGIN
    UUT: ENTITY WORK.GENERIC_AND
        GENERIC MAP ( size => 4 )
        PORT MAP (
            A => A ,
            B => B ,
            Result => Result ,
            Zero_flag => Zero_flag ,
            Carry_flag => Carry_flag ,
            Borrow_flag => Borrow_flag ,
            Overflow_flag => Overflow_flag ,
            Greater_flag => Greater_flag ,
            Equal_flag => Equal_flag
        );

    tb_proc : PROCESS
    BEGIN       
        A <= "0000";
        B <= "0000";
        WAIT FOR 5 ns ;
        
        A <= "0001";
        B <= "1001";
        WAIT FOR 5 ns ;
        
        A <= "1111";
        B <= "0001";
        WAIT FOR 5 ns ;

        A <= "1100";
        B <= "0011";
        WAIT FOR 5 ns ;
        
        A <= "1101";
        B <= "0101";
        WAIT FOR 5 ns ;
        
        A <= "0101";
        B <= "1001";
        WAIT FOR 5 ns ;
        WAIT ;
    END PROCESS ;
END ;