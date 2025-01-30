library IEEE ;
use IEEE.STD_LOGIC_1164.ALL ;
USE IEEE.NUMERIC_STD.ALL ;

ENTITY tb_Right_Shift_Register IS
END tb_Right_Shift_Register ;

ARCHITECTURE Behavior of tb_Right_Shift_Register IS

    SIGNAL CLK : STD_LOGIC := '0';
    SIGNAL Reset : STD_LOGIC := '0';
    SIGNAL Shift : STD_LOGIC := '0';             
    SIGNAL A : STD_LOGIC_VECTOR (3 downto 0) := ( OTHERS => '0' ); 
    SIGNAL Result : STD_LOGIC_VECTOR (3 downto 0); 
    SIGNAL Zero_flag : STD_LOGIC ;
    SIGNAL Carry_flag : STD_LOGIC ;
    SIGNAL Borrow_flag : STD_LOGIC ;
    SIGNAL Overflow_flag : STD_LOGIC ;
    SIGNAL Greater_flag : STD_LOGIC ;
    SIGNAL Equal_flag : STD_LOGIC ;

    COMPONENT Right_Shift_Register
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
    END COMPONENT ;

BEGIN 

    UUT : Right_Shift_Register
        GENERIC MAP ( size => 4 )
        PORT MAP (
            CLK => CLK ,
            Reset => Reset ,
            Shift => Shift,
            A => A ,
            Result => Result ,
            Zero_flag => Zero_flag ,
            Carry_flag => Carry_flag ,
            Borrow_flag => Borrow_flag ,
            Overflow_flag => Overflow_flag ,
            Greater_flag => Greater_flag ,
            Equal_flag => Equal_flag
        );

    clk_process : PROCESS
    BEGIN 
        while true loop
            CLK <= '0';
            WAIT FOR 10 ns ;
            CLK <= '1';
            WAIT FOR 10 ns ;
        end loop ;
    END PROCESS ;

    stim_proc : PROCESS
    BEGIN 

        Reset <= '1';
        WAIT FOR 20 ns ;
        Reset <= '0';

        A <= "1011" ;
        WAIT FOR 20 ns ;

        Shift <= '1';
        WAIT FOR 20 ns ;
        Shift <= '0';
        WAIT FOR 20 ns ;
        
        A <= "0001" ;
        WAIT FOR 20 ns ;
        
        Shift <= '1';
        WAIT FOR 20 ns ;
        Shift <= '0';
        WAIT FOR 20 ns ;
        
        A <= "1010" ;
        WAIT FOR 20 ns ;
        
        Shift <= '1';
        WAIT FOR 20 ns ;
        Shift <= '0';
        WAIT FOR 20 ns ;

        A <= "1111" ;
        WAIT FOR 20 ns ;

        Shift <= '1';
        WAIT FOR 20 ns ;

        WAIT ;
    END PROCESS ;

end Behavior ;


