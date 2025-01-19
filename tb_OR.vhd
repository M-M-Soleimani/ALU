LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY GENERIC_OR_TB IS
END GENERIC_OR_TB;

ARCHITECTURE behavior OF GENERIC_OR_TB IS 

    COMPONENT GENERIC_OR
    GENERIC (size : INTEGER := 4);
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
    END COMPONENT;
   
    SIGNAL A : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    SIGNAL B : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    
    SIGNAL Result : STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL Zero_flag : STD_LOGIC;
    SIGNAL Carry_flag : STD_LOGIC;
    SIGNAL Borrow_flag : STD_LOGIC;
    SIGNAL Overflow_flag : STD_LOGIC;
    SIGNAL Greater_flag : STD_LOGIC;
    SIGNAL Equal_flag : STD_LOGIC;

BEGIN

    uut: GENERIC_OR
        GENERIC MAP (
            size => 4
        )
        PORT MAP (
            A => A,
            B => B,
            Result => Result,
            Zero_flag => Zero_flag,
            Carry_flag => Carry_flag,
            Borrow_flag => Borrow_flag,
            Overflow_flag => Overflow_flag,
            Greater_flag => Greater_flag,
            Equal_flag => Equal_flag
        );

    -- Stimulus process
    stim_proc: process
    begin       
        A <= "0000";
        B <= "0000";
        wait for 10 ns;
        
        A <= "0001";
        B <= "0011";
        wait for 10 ns;
        
        A <= "1111";
        B <= "0001";
        wait for 10 ns;

        A <= "1001";
        B <= "0110";
        wait for 10 ns;

        wait;
    end process;
END;