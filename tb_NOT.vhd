LIBRARY IEEE ;
USE IEEE.STD_LOGIC_1164.ALL ;
USE IEEE.NUMERIC_STD.ALL ;

ENTITY tb_not IS 
END tb_not ;

ARCHITECTURE Behavior OF tb_not IS 

    SIGNAL A : STD_LOGIC_VECTOR ( 3 DOWNTO 0 ) := "0000";
    SIGNAL RESULT : STD_LOGIC_VECTOR ( 3 DOWNTO 0 );
    SIGNAL Zero_flag : STD_LOGIC ;
    SIGNAL Carry_flag : STD_LOGIC ;
    SIGNAL Borrow_flag : STD_LOGIC ;
    SIGNAL Overflow_flag : STD_LOGIC ;
    SIGNAL Greater_flag : STD_LOGIC ;
    SIGNAL Equal_flag : STD_LOGIC ;

    COMPONENT generic_not
    GENERIC (size : INTEGER := 4);
    PORT (
        A : IN STD_LOGIC_VECTOR(size-1 downto 0);
        Result : BUFFER STD_LOGIC_VECTOR(size-1 downto 0);
        Zero_flag : OUT STD_LOGIC ;
        Carry_flag : OUT STD_LOGIC ;
        Borrow_flag : OUT STD_LOGIC ;
        Overflow_flag : OUT STD_LOGIC ;
        Greater_flag : OUT STD_LOGIC ;
        Equal_flag : OUT STD_LOGIC
    );
    END COMPONENT;

BEGIN 
    UUT : generic_not 
    GENERIC MAP ( size => 4 )
    PORT MAP (
        A => A ,
        RESULT => RESULT ,
        Zero_flag => Zero_flag , 
        Carry_flag => Carry_flag ,
        Borrow_flag => Borrow_flag ,
        Overflow_flag => Overflow_flag ,
        Greater_flag => Greater_flag ,
        Equal_flag => Equal_flag 
    );
    
    PROCESS 
    BEGIN
        WAIT FOR 5 ns ;
        A(0) <= NOT A(0);
        WAIT FOR 5 ns ;
        A(1) <= NOT A(1) ;
        WAIT FOR 5 ns ;
        A(2) <= NOT A(2) ;
        WAIT FOR 5 ns ;
        A(3) <= NOT A(3) ;
    END PROCESS ;
END Behavior ;