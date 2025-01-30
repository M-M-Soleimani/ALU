LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY tb_Subtractor IS
END tb_Subtractor ;

ARCHITECTURE Behavioral OF tb_Subtractor IS 

    SIGNAL Bin : STD_LOGIC ;
    SIGNAL A : STD_LOGIC_VECTOR ( 3 DOWNTO 0 ) := "0000";
    SIGNAL B : STD_LOGIC_VECTOR ( 3 DOWNTO 0 ) := "0000";
    SIGNAL Diff : STD_LOGIC_VECTOR ( 3 DOWNTO 0 );
    SIGNAL Zero_flag , Carry_flag , Borrow_flag , Overflow_flag , Greater_flag , Equal_flag : STD_LOGIC ;

BEGIN
    UUT : ENTITY work.Generic_Subtractor
        GENERIC MAP ( size => 4 )
        PORT MAP (
            A => A ,
            B => B ,
            Bin => Bin ,
            Diff => Diff ,
            Zero_flag => Zero_flag ,
            Carry_flag => Carry_flag ,
            Borrow_flag => Borrow_flag ,
            Overflow_flag => Overflow_flag ,
            Greater_flag => Greater_flag ,
            Equal_flag => Equal_flag
        );

    stim_proc : PROCESS
    BEGIN

        -- Test Case 1 : A = 12 , B = 8 , Bin = 0
        A <= "1100";
        B <= "1000";
        Bin <= '0';
        WAIT FOR 40 ns;

        
        -- Test Case 3 : A = 15 , B = 6 , Bin = 0
        A <= "1111";
        B <= "0110";
        Bin <= '0';
        WAIT FOR 40 ns;
        
        -- Test Case 2 : A = 6 , B = 5 , Bin = 0
        A <= "0110";
        B <= "0101";
        Bin <= '1';
        WAIT FOR 40 ns;

        -- Test Case 4 : A = 13 , B = 9 , Bin = 1
        A <= "1101";
        B <= "1001";
        Bin <= '1';
        WAIT FOR 40 ns;

        -- Test Case 5 : A = 3 , B = 7 , Bin = 0
        A <= "0011";
        B <= "0111";
        Bin <= '0';
        WAIT FOR 40 ns;
        
        -- Test Case 6 : A = 4 , B = 4 , Bin = 0
        A <= "0100";
        B <= "0100";
        Bin <= '0';
        WAIT FOR 40 ns;

        WAIT;
    END PROCESS;
END Behavioral;