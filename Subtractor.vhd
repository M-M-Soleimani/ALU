LIBRARY IEEE ;
USE IEEE.STD_LOGIC_1164.ALL ;
USE IEEE.NUMERIC_STD.ALL ;

ENTITY Generic_Subtractor IS
    GENERIC ( size : integer := 4 );
    PORT (
        A , B : IN STD_LOGIC_VECTOR ( size - 1 DOWNTO 0 );
        Bin : IN STD_LOGIC ;
        Diff : OUT STD_LOGIC_VECTOR ( size - 1 DOWNTO 0 );
        Zero_flag : OUT STD_LOGIC ;
        Carry_flag : OUT STD_LOGIC ;
        Borrow_flag : OUT STD_LOGIC ;
        Overflow_flag : OUT STD_LOGIC ;
        Greater_flag : OUT STD_LOGIC ;
        Equal_flag : OUT STD_LOGIC 
    );
END Generic_Subtractor ;

ARCHITECTURE Behavioral OF Generic_Subtractor IS

    SIGNAL tempSub : STD_LOGIC_VECTOR ( size DOWNTO 0 );
BEGIN
    PROCESS ( A , B , tempSub , Bin )
    BEGIN

        tempSub <= STD_LOGIC_VECTOR (unsigned ('0' & A) - unsigned ('0' & B) - unsigned ('0' & std_logic_vector'(0 => Bin)));
        Diff <= tempSub (size - 1 downto 0);

    END PROCESS ;

    PROCESS ( tempSub )
    BEGIN 

        Zero_flag <= '1';
        for i in 0 to size-1 loop
            if tempSub(i) = '1' then
                Zero_flag <= '0';
            end if ;
        end loop ;

        Carry_flag <= NOT tempSub ( size );
        Borrow_flag <= tempSub ( size );
        Overflow_flag <= (A(size-1) XOR B(size-1)) AND (A(size-1) XOR tempSub(size-1));

        if unsigned(A) > unsigned(B) then
            Greater_flag <= '1';
        else
            Greater_flag <= '0';
        end if;

        if unsigned(A) = unsigned(B) then
            Equal_flag <= '1';
        else
            Equal_flag <= '0';
        end if;

    END PROCESS ;

end Behavioral ;