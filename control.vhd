library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY Generic_Control_Unit is
    Generic (
        size : integer := 4
    );
    Port (
        Opcode        : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
        A             : IN  STD_LOGIC_VECTOR (size-1 DOWNTO 0);
        B             : IN  STD_LOGIC_VECTOR (size-1 DOWNTO 0);
        reset         : IN  STD_LOGIC;
        CLK           : IN  STD_LOGIC;
        shift         : IN  STD_LOGIC;
        rotate        : IN  STD_LOGIC;
        Zero_flag     : OUT STD_LOGIC;
        Carry_flag    : OUT STD_LOGIC;
        Borrow_flag   : OUT STD_LOGIC;
        Overflow_flag : OUT STD_LOGIC;
        Greater_flag  : OUT STD_LOGIC;
        Equal_flag    : OUT STD_LOGIC;
        result : OUT  STD_LOGIC_VECTOR (size-1 DOWNTO 0)
    );
END Generic_Control_Unit;

architecture Behavioral of Generic_Control_Unit is

    COMPONENT Generic_Adder is
        Generic (
            size : integer := size
        );
        Port (
            A              : IN  STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            B              : IN  STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            Cin            : IN  STD_LOGIC;  
            Sum            : OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            Zero_flag      : OUT STD_LOGIC;
            Carry_flag     : OUT STD_LOGIC;
            Borrow_flag    : OUT STD_LOGIC;
            Overflow_flag  : OUT STD_LOGIC;
            Greater_flag   : OUT STD_LOGIC;
            Equal_flag     : OUT STD_LOGIC
        );
    end COMPONENT;

    COMPONENT GENERIC_AND is
        Generic (
            size : integer := size
        );
        Port (
            A              : IN  STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            B              : IN  STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            Result         : BUFFER STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            Zero_flag      : OUT STD_LOGIC;
            Carry_flag     : OUT STD_LOGIC;
            Borrow_flag    : OUT STD_LOGIC;
            Overflow_flag  : OUT STD_LOGIC;
            Greater_flag   : OUT STD_LOGIC;
            Equal_flag     : OUT STD_LOGIC
        );
    end COMPONENT;

    COMPONENT generic_not is
        Generic (
            size : integer := size
        );
        Port (
            A              : IN  STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            Result         : BUFFER STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            Zero_flag      : OUT STD_LOGIC;
            Carry_flag     : OUT STD_LOGIC;
            Borrow_flag    : OUT STD_LOGIC;
            Overflow_flag  : OUT STD_LOGIC;
            Greater_flag   : OUT STD_LOGIC;
            Equal_flag     : OUT STD_LOGIC
        );
    end COMPONENT;

    COMPONENT GENERIC_OR is
        Generic (
            size : integer := size
        );
        Port (
            A              : IN  STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            B              : IN  STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            Result         : BUFFER STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            Zero_flag      : OUT STD_LOGIC;
            Carry_flag     : OUT STD_LOGIC;
            Borrow_flag    : OUT STD_LOGIC;
            Overflow_flag  : OUT STD_LOGIC;
            Greater_flag   : OUT STD_LOGIC;
            Equal_flag     : OUT STD_LOGIC
        );
    end COMPONENT;

    COMPONENT Left_Rotate is
        Generic (
            size : integer := size
        );
        Port (
            Rotate         : IN  STD_LOGIC;
            A              : IN  STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            Result         : OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            Zero_flag      : OUT STD_LOGIC;
            Carry_flag     : OUT STD_LOGIC;
            Borrow_flag    : OUT STD_LOGIC;
            Overflow_flag  : OUT STD_LOGIC;
            Greater_flag   : OUT STD_LOGIC;
            Equal_flag     : OUT STD_LOGIC
        );
    end COMPONENT;

    COMPONENT Right_Rotate is
        Generic (
            size : integer := size
        );
        Port (
            Rotate         : IN  STD_LOGIC;
            A              : IN  STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            Result         : OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            Zero_flag      : OUT STD_LOGIC;
            Carry_flag     : OUT STD_LOGIC;
            Borrow_flag    : OUT STD_LOGIC;
            Overflow_flag  : OUT STD_LOGIC;
            Greater_flag   : OUT STD_LOGIC;
            Equal_flag     : OUT STD_LOGIC
        );
    end COMPONENT;

    COMPONENT Left_Shift
        Generic (
            size : integer := size
        );
        Port (
            A             : IN  STD_LOGIC_VECTOR (size-1 DOWNTO 0);
            Shift         : IN  STD_LOGIC ;  
            Zero_flag     : OUT STD_LOGIC ;
            Carry_flag    : OUT STD_LOGIC ;
            Borrow_flag   : OUT STD_LOGIC ; 
            Overflow_flag : OUT STD_LOGIC ;
            Greater_flag  : OUT STD_LOGIC ;
            Equal_flag    : OUT STD_LOGIC ;
            Result        : OUT STD_LOGIC_VECTOR (size-1 DOWNTO 0)
        );
    end COMPONENT;

    COMPONENT Right_Shift is
        Generic (
            size : integer := size
        );
        Port (
            Shift          : IN  STD_LOGIC;
            A              : IN  STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            Result         : OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            Zero_flag      : OUT STD_LOGIC;
            Carry_flag     : OUT STD_LOGIC;
            Borrow_flag    : OUT STD_LOGIC;
            Overflow_flag  : OUT STD_LOGIC;
            Greater_flag   : OUT STD_LOGIC;
            Equal_flag     : OUT STD_LOGIC
        );
    end COMPONENT;

    COMPONENT Arithmetic_Right_Shift is
        Generic (
            size : integer := size
        );
        Port (
            Shift          : IN  STD_LOGIC;
            A              : IN  STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            Result         : OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            Zero_flag      : OUT STD_LOGIC;
            Carry_flag     : OUT STD_LOGIC;
            Borrow_flag    : OUT STD_LOGIC;
            Overflow_flag  : OUT STD_LOGIC;
            Greater_flag   : OUT STD_LOGIC;
            Equal_flag     : OUT STD_LOGIC
        );
    end COMPONENT;

    COMPONENT Generic_Subtractor is
        Generic (
            size : integer := size
        );
        Port (
            A              : IN  STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            B              : IN  STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            Bin            : IN  STD_LOGIC;
            Diff           : OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            Zero_flag      : OUT STD_LOGIC;
            Carry_flag     : OUT STD_LOGIC;
            Borrow_flag    : OUT STD_LOGIC;
            Overflow_flag  : OUT STD_LOGIC;
            Greater_flag   : OUT STD_LOGIC;
            Equal_flag     : OUT STD_LOGIC
        );
    end COMPONENT;

    COMPONENT GENERIC_XOR is
        Generic (
            size : integer := size
        );
        Port (
            A              : IN  STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            B              : IN  STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            Result         : BUFFER STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            Zero_flag      : OUT STD_LOGIC;
            Carry_flag     : OUT STD_LOGIC;
            Borrow_flag    : OUT STD_LOGIC;
            Overflow_flag  : OUT STD_LOGIC;
            Greater_flag   : OUT STD_LOGIC;
            Equal_flag     : OUT STD_LOGIC
        );
    end COMPONENT;

    component Comparator
        Generic (
            size : integer := size
        );
        Port (
            A : in  STD_LOGIC_VECTOR (size-1 downto 0);
            B : in  STD_LOGIC_VECTOR (size-1 downto 0);
            Result : out STD_LOGIC
        );
    end component;

    component Equality_Check
        Generic (
            size : integer := size
        );
        Port (
            A : in  STD_LOGIC_VECTOR (size-1 downto 0);
            B : in  STD_LOGIC_VECTOR (size-1 downto 0);
            Result : out STD_LOGIC
        );
    end component;

    SIGNAL add_res , sub_res , and_res , not_res , or_res , xor_res ,
           rshift_res , lshift_res , signshift_res , Rrotate_res , Lrotate_res : STD_LOGIC_VECTOR(size-1 DOWNTO 0) := (OTHERS => '0');
    -- SIGNAL zero, carry, borrow, overflow, greater, equal : STD_LOGIC;
    SIGNAL add_zero, add_carry, add_borrow, add_overflow, add_greater, add_equal : STD_LOGIC;
    SIGNAL sub_zero, sub_carry, sub_borrow, sub_overflow, sub_greater, sub_equal : STD_LOGIC;
    SIGNAL and_zero, and_carry, and_borrow, and_overflow, and_greater, and_equal : STD_LOGIC;
    SIGNAL not_zero, not_carry, not_borrow, not_overflow, not_greater, not_equal : STD_LOGIC;
    SIGNAL or_zero, or_carry, or_borrow, or_overflow, or_greater, or_equal : STD_LOGIC;
    SIGNAL xor_zero, xor_carry, xor_borrow, xor_overflow, xor_greater, xor_equal : STD_LOGIC;
    SIGNAL rsh_zero, rsh_carry, rsh_borrow, rsh_overflow, rsh_greater, rsh_equal : STD_LOGIC;
    SIGNAL lsh_zero, lsh_carry, lsh_borrow, lsh_overflow, lsh_greater, lsh_equal : STD_LOGIC;
    SIGNAL sign_zero, sign_carry, sign_borrow, sign_overflow, sign_greater, sign_equal : STD_LOGIC;
    SIGNAL rotr_zero, rotr_carry, rotr_borrow, rotr_overflow, rotr_greater, rotr_equal : STD_LOGIC;
    SIGNAL rotl_zero, rotl_carry, rotl_borrow, rotl_overflow, rotl_greater, rotl_equal : STD_LOGIC;

begin

    u1: Generic_Adder
        generic map (size => size)
        port map (
            A => A,
            B => B,
            Cin => '0',
            Sum => add_res,
            Zero_flag => add_zero,
            Carry_flag => add_carry,
            Borrow_flag => add_borrow,
            Overflow_flag => add_overflow,
            Greater_flag => add_greater,
            Equal_flag => add_equal
        );

    u2: Generic_Subtractor
        generic map (size => size)
        port map (
            A => A,
            B => B,
            Bin => '0',
            Diff => sub_res,
            Zero_flag =>      sub_zero,
            Carry_flag =>     sub_carry,
            Borrow_flag =>    sub_borrow,
            Overflow_flag =>  sub_overflow,
            Greater_flag =>   sub_greater,
            Equal_flag =>     sub_equal
        );

    u3: GENERIC_AND
        generic map (size => size)
        port map (
            A => A,
            B => B,
            Result =>         and_res,
            Zero_flag =>      and_zero,
            Carry_flag =>     and_carry,
            Borrow_flag =>    and_borrow,
            Overflow_flag =>  and_overflow,
            Greater_flag =>   and_greater,
            Equal_flag =>     and_equal
        );

    u4: GENERIC_OR
        generic map (size => size)
        port map (
            A => A,
            B => B,
            Result => or_res,
            Zero_flag =>     or_zero,
            Carry_flag =>    or_carry,
            Borrow_flag =>   or_borrow,
            Overflow_flag => or_overflow,
            Greater_flag =>  or_greater,
            Equal_flag =>    or_equal
        );


    u5: generic_not
        generic map (size => size)
        port map (
            A => A,
            Result =>        not_res,
            Zero_flag =>     not_zero,
            Carry_flag =>    not_carry,
            Borrow_flag =>   not_borrow,
            Overflow_flag => not_overflow,
            Greater_flag =>  not_greater,
            Equal_flag =>    not_equal
        );

    u6: GENERIC_XOR
        generic map (size => size)
        port map (
            A => A,
            B => B,
            Result => xor_res,
            Zero_flag =>       xor_zero,
            Carry_flag =>      xor_carry,
            Borrow_flag =>     xor_borrow,
            Overflow_flag =>   xor_overflow,
            Greater_flag =>    xor_greater,
            Equal_flag =>      xor_equal
        );

    u7: Left_Rotate
        generic map (size => size)
        port map (
            Rotate => rotate,
            A => A,
            Result => Lrotate_res ,
            Zero_flag =>        rotl_zero,
            Carry_flag =>       rotl_carry,
            Borrow_flag =>      rotl_borrow,
            Overflow_flag =>    rotl_overflow,
            Greater_flag =>     rotl_greater,
            Equal_flag =>       rotl_equal
        );

    u8: Right_Rotate
        generic map (size => size)
        port map (
            Rotate => rotate,
            A => A,
            Result => Rrotate_res,
            Zero_flag =>      rotr_zero,
            Carry_flag =>     rotr_carry,
            Borrow_flag =>    rotr_borrow,
            Overflow_flag =>  rotr_overflow,
            Greater_flag =>   rotr_greater,
            Equal_flag =>     rotr_equal
        );

    u9: Left_Shift
    generic map (size => size)
    port map (
        A => A,
        Shift => shift,
        Result => lshift_res,
        Zero_flag =>      lsh_zero,
        Carry_flag =>     lsh_carry,
        Borrow_flag =>    lsh_borrow,
        Overflow_flag =>  lsh_overflow,
        Greater_flag =>   lsh_greater,
        Equal_flag =>     lsh_equal
    );
        

    u10: Right_Shift
        generic map (size => size)
        port map (
            Shift => shift,
            A => A,
            Result => rshift_res,
            Zero_flag =>      rsh_zero,
            Carry_flag =>     rsh_carry,
            Borrow_flag =>    rsh_borrow,
            Overflow_flag =>  rsh_overflow,
            Greater_flag =>   rsh_greater,
            Equal_flag =>     rsh_equal
        );

    u11: Arithmetic_Right_Shift
        generic map (size => size)
        port map (
            Shift => shift,
            A => A,
            Result => signshift_res,
            Zero_flag =>     sign_zero,
            Carry_flag =>    sign_carry,
            Borrow_flag =>   sign_borrow,
            Overflow_flag => sign_overflow,
            Greater_flag =>  sign_greater,
            Equal_flag =>    sign_equal
        );

    u12: Comparator
        generic map (size => size)
        port map (
            A => A,
            B => B,
            Result => Greater_flag
        );

    u13: Equality_Check
        generic map (size => size)
        port map (
            A => A,
            B => B,
            Result => Equal_flag
        );

        process(reset , Opcode , A , B , CLK)
        begin
            if reset = '1' then
                Zero_flag <= '1' ;
                Carry_flag <= '0' ;
                Borrow_flag <= '0' ;
                Overflow_flag <= '0' ;
                Greater_flag <= '0' ;
                Equal_flag <= '0' ;
                result <= (others => '0');
            elsif rising_edge(CLK) then
                case Opcode is
                    when "0001" =>
                        result <= add_res ;  -- Addition
                        Zero_flag <= add_zero;
                        Carry_flag <= add_carry;
                        Borrow_flag <= add_borrow;
                        Overflow_flag <= add_overflow;
                        Greater_flag <= add_greater;
                        Equal_flag <= add_equal;
                    when "0010" =>
                        result <= sub_res ;  -- Subtraction
                        Zero_flag <= sub_zero ;
                        Carry_flag <= sub_carry ;
                        Borrow_flag <= sub_borrow ;
                        Overflow_flag <= sub_overflow ;
                        Greater_flag <= sub_greater ;
                        Equal_flag <= sub_equal ;
                    when "0011" =>
                        result <= and_res ;  -- AND
                        Zero_flag <= and_zero ;
                        Carry_flag <= and_carry ;
                        Borrow_flag <= and_borrow ;
                        Overflow_flag <= and_greater ;
                        Equal_flag <= and_equal ;
                    when "0100" =>
                        result <= or_res ;  -- OR
                        Zero_flag <= or_zero ;
                        Carry_flag <= or_carry ;
                        Borrow_flag <= or_borrow ;
                        Overflow_flag <= or_overflow ;
                        Greater_flag <= or_greater ;
                        Equal_flag <= or_equal ;
                    when "0101" =>
                        result <= not_res ;  -- NOT
                        Zero_flag <= not_zero ;
                        Carry_flag <= not_carry ;
                        Borrow_flag <= not_borrow ;
                        Overflow_flag <= not_overflow ;
                        Greater_flag <= not_greater ;
                        Equal_flag <= not_equal ;
                    when "0110" =>
                        result <= xor_res ;  -- XOR
                        Zero_flag <= xor_zero ;
                        Carry_flag <= xor_carry ;
                        Borrow_flag <= xor_borrow ;
                        Overflow_flag <= xor_overflow ;
                        Greater_flag <= xor_greater ;
                        Equal_flag <= xor_equal ;
                    when "0111" =>
                        result <= Lrotate_res ;  -- Rotate left
                        Zero_flag <= rotl_zero ;
                        Carry_flag <= rotl_carry ;
                        Borrow_flag <= rotl_borrow ;
                        Overflow_flag <= rotl_overflow ;
                        Greater_flag <= rotl_greater ;
                        Equal_flag <= rotl_equal ;
                    when "1000" =>
                        result <= Rrotate_res ;  -- Rotate right
                        Zero_flag <= rotr_zero ;
                        Carry_flag <= rotr_carry ;
                        Borrow_flag <= rotr_borrow ;
                        Overflow_flag <= rotr_overflow ;
                        Greater_flag <= rotr_greater ;
                        Equal_flag <= rotr_equal ;
                    when "1001" =>
                        result <= lshift_res ;  -- Logical left shift
                        Zero_flag <= lsh_zero ;
                        Carry_flag <= lsh_carry ;
                        Borrow_flag <= lsh_borrow ;
                        Overflow_flag <= lsh_overflow ;
                        Greater_flag <= lsh_greater ;
                        Equal_flag <= lsh_equal ;
                    when "1010" =>
                        result <= rshift_res ;  -- Logical right shift
                        Zero_flag <= rsh_zero ;
                        Carry_flag <= rsh_carry ;
                        Borrow_flag <= rsh_borrow ;
                        Overflow_flag <= rsh_overflow ;
                        Greater_flag <= rsh_greater ;
                        Equal_flag <= rsh_equal ;
                    when "1011" =>
                        result <= signshift_res ;  -- Arithmetic right shift
                        Zero_flag <= sign_zero ;
                        Carry_flag <= sign_carry ;
                        Borrow_flag <= sign_borrow ;
                        Overflow_flag <= sign_overflow ;
                        Greater_flag <= sign_greater ;
                        Equal_flag <= sign_equal ;
                    when "1100" =>
                        result <= (others => '0'); -- comparison A > B
                        Zero_flag <= '0' ;
                        Carry_flag <= '0' ;
                        Borrow_flag <= '0' ;
                        Overflow_flag <= '0' ;
                        Greater_flag <= '0' ;
                        Equal_flag <= '0' ;
                    when "1101" =>
                        result <= (others => '0');  -- equality check
                        Zero_flag <= '0' ;
                        Carry_flag <= '0' ;
                        Borrow_flag <= '0' ;
                        Overflow_flag <= '0' ;
                        Greater_flag <= '0' ;
                        Equal_flag <= '0' ;
                    when others =>
                        result <= (others => '0');  -- Default case
                        Zero_flag <= '0' ;
                        Carry_flag <= '0' ;
                        Borrow_flag <= '0' ;
                        Overflow_flag <= '0' ;
                        Greater_flag <= '0' ;
                        Equal_flag <= '0' ;
                end case;
    
                -- Zero_flag     <= zero ;
                -- Carry_flag    <= carry ;
                -- Borrow_flag   <= borrow ;
                -- Overflow_flag <= overflow ;
                -- Greater_flag  <= greater ;
                -- Equal_flag    <= equal ;
            end if;
        end process;
    
    end Behavioral;