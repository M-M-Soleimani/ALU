library IEEE ;
use IEEE.STD_LOGIC_1164.ALL ;
USE IEEE.NUMERIC_STD.ALL ;

ENTITY tb_Right_Rotate IS
END tb_Right_Rotate ;

ARCHITECTURE Behavior of tb_Right_Rotate IS 

    SIGNAL Rotate : STD_LOGIC := '0';             
    SIGNAL A : STD_LOGIC_VECTOR (3 downto 0); 
    SIGNAL Result : STD_LOGIC_VECTOR (3 downto 0); 
    SIGNAL Zero_flag : STD_LOGIC ;
    SIGNAL Carry_flag : STD_LOGIC ;
    SIGNAL Borrow_flag : STD_LOGIC ;
    SIGNAL Overflow_flag : STD_LOGIC ;
    SIGNAL Greater_flag : STD_LOGIC ;
    SIGNAL Equal_flag : STD_LOGIC ;

    COMPONENT Right_Rotate
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
    END COMPONENT ;

BEGIN 

    UUT : Right_Rotate
    GENERIC MAP ( size => 4 )
    PORT MAP (
        Rotate => Rotate,
        A => A ,
        Result => Result ,
        Zero_flag => Zero_flag ,
        Carry_flag => Carry_flag ,
        Borrow_flag => Borrow_flag ,
        Overflow_flag => Overflow_flag ,
        Greater_flag => Greater_flag ,
        Equal_flag => Equal_flag
    );

    stim_proc : PROCESS 
    BEGIN 

    A <= "1001" ;
    Rotate <= '1';
    WAIT FOR 20 ns ;
    
    A <= "1010" ;
    Rotate <= '1';
    WAIT FOR 20 ns ;
    
    A <= "0011" ;
    Rotate <= '1';
    WAIT FOR 20 ns ;
    
    A <= "1011" ;
    Rotate <= '0';
    WAIT FOR 20 ns ;
    
    A <= "0111" ;
    Rotate <= '1';
    WAIT FOR 20 ns ;
    
    WAIT ;
    END PROCESS ;

END Behavior ;
