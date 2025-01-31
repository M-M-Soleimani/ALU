library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Generic_Control_Unit is
    Generic (
        size : integer := 4
    );
    Port (
        Opcode        : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
        A             : IN  STD_LOGIC_VECTOR (size-1 DOWNTO 0);
        B             : IN  STD_LOGIC_VECTOR (size-1 DOWNTO 0);
        CLK           : IN  STD_LOGIC;
        reset         : IN  STD_LOGIC;
        shift         : IN  STD_LOGIC;
        rotate        : IN  STD_LOGIC;
        Zero_flag     : out std_logic;
        Carry_flag    : out std_logic;
        Borrow_flag   : out std_logic;
        Overflow_flag : out std_logic;
        Greater_flag  : out std_logic;
        Equal_flag    : out std_logic;
        result : OUT  STD_LOGIC_VECTOR (size-1 DOWNTO 0)
    );
end Generic_Control_Unit;

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
            CLK            : IN  STD_LOGIC;
            Reset          : IN  STD_LOGIC;
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
            CLK            : IN  STD_LOGIC;
            Reset          : IN  STD_LOGIC;
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

    COMPONENT Shift_Register_Left
        Generic (
            size : integer := 4
        );
        Port (
            clk         : IN  STD_LOGIC;
            reset       : IN  STD_LOGIC;
            shift       : IN  STD_LOGIC;
            A           : IN  STD_LOGIC_VECTOR(size-1 downto 0);
            Result      : OUT STD_LOGIC_VECTOR(size-1 downto 0);
            Zero_flag    : OUT STD_LOGIC;
            Carry_flag   : OUT STD_LOGIC;
            Borrow_flag  : OUT STD_LOGIC;
            Overflow_flag : OUT STD_LOGIC;
            Greater_flag  : OUT STD_LOGIC;
            Equal_flag    : OUT STD_LOGIC
        );
    end COMPONENT;

    COMPONENT Right_Shift_Register is
        Generic (
            size : integer := size
        );
        Port (
            CLK            : IN  STD_LOGIC;
            Reset          : IN  STD_LOGIC;
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
            CLK            : IN  STD_LOGIC;
            Reset          : IN  STD_LOGIC;
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
           rshift_res , lshift_res , signshift_res , Rrotate_res , Lrotate_res : STD_LOGIC_VECTOR(size-1 DOWNTO 0);
    SIGNAL carry, borrow, overflow, greater, equal, zero : STD_LOGIC;

begin

    u1: Generic_Adder
        generic map (size => size)
        port map (
            A => A,
            B => B,
            Cin => '0',
            Sum => add_res,
            Zero_flag => zero,
            Carry_flag => carry,
            Borrow_flag => borrow,
            Overflow_flag => overflow,
            Greater_flag => greater,
            Equal_flag => equal
        );

    u2: Generic_Subtractor
        generic map (size => size)
        port map (
            A => A,
            B => B,
            Bin => '0',
            Diff => sub_res,
            Zero_flag => zero,
            Carry_flag => carry,
            Borrow_flag => borrow,
            Overflow_flag => overflow,
            Greater_flag => greater,
            Equal_flag => equal
        );

    u3: GENERIC_AND
        generic map (size => size)
        port map (
            A => A,
            B => B,
            Result => and_res,
            Zero_flag => zero,
            Carry_flag => carry,
            Borrow_flag => borrow,
            Overflow_flag => overflow,
            Greater_flag => greater,
            Equal_flag => equal
        );

    u4: GENERIC_OR
        generic map (size => size)
        port map (
            A => A,
            B => B,
            Result => or_res,
            Zero_flag => zero,
            Carry_flag => carry,
            Borrow_flag => borrow,
            Overflow_flag => overflow,
            Greater_flag => greater,
            Equal_flag => equal
        );


    u5: generic_not
        generic map (size => size)
        port map (
            A => A,
            Result => not_res,
            Zero_flag => zero,
            Carry_flag => carry,
            Borrow_flag => borrow,
            Overflow_flag => overflow,
            Greater_flag => greater,
            Equal_flag => equal
        );

    u6: GENERIC_XOR
        generic map (size => size)
        port map (
            A => A,
            B => B,
            Result => xor_res,
            Zero_flag => zero,
            Carry_flag => carry,
            Borrow_flag => borrow,
            Overflow_flag => overflow,
            Greater_flag => greater,
            Equal_flag => equal
        );

    u7: Left_Rotate
        generic map (size => size)
        port map (
            CLK => CLK,
            Reset => reset,
            Rotate => rotate,
            A => A,
            Result => Lrotate_res ,
            Zero_flag => zero,
            Carry_flag => carry,
            Borrow_flag => borrow,
            Overflow_flag => overflow,
            Greater_flag => greater,
            Equal_flag => equal
        );

    u8: Right_Rotate
        generic map (size => size)
        port map (
            CLK => CLK,
            Reset => reset,
            Rotate => rotate,
            A => A,
            Result => Rrotate_res,
            Zero_flag => zero,
            Carry_flag => carry,
            Borrow_flag => borrow,
            Overflow_flag => overflow,
            Greater_flag => greater,
            Equal_flag => equal
        );

    u9: Shift_Register_Left
    generic map (size => size)
    port map (
        CLK => CLK,
        Reset => reset,
        Shift => shift,
        A => A,
        Result => lshift_res,
        Zero_flag => zero,
        Carry_flag => carry,
        Borrow_flag => borrow,
        Overflow_flag => overflow,
        Greater_flag => greater,
        Equal_flag => equal
    );
        

    u10: Right_Shift_Register
        generic map (size => size)
        port map (
            CLK => CLK,
            Reset => reset,
            Shift => shift,
            A => A,
            Result => rshift_res,
            Zero_flag => zero,
            Carry_flag => carry,
            Borrow_flag => borrow,
            Overflow_flag => overflow,
            Greater_flag => greater,
            Equal_flag => equal
        );

    u11: Arithmetic_Right_Shift
        generic map (size => size)
        port map (
            CLK => CLK,
            Reset => reset,
            Shift => shift,
            A => A,
            Result => signshift_res,
            Zero_flag => zero,
            Carry_flag => carry,
            Borrow_flag => borrow,
            Overflow_flag => overflow,
            Greater_flag => greater,
            Equal_flag => equal
        );

    u12: Comparator
        generic map (size => size)
        port map (
            A => A,
            B => B,
            Result => greater
        );

    u13: Equality_Check
        generic map (size => size)
        port map (
            A => A,
            B => B,
            Result => equal
        );


    process(Opcode, A, B)
    begin
        case Opcode is
            when "0001" =>
                result <= add_res ;  -- Addition
                Zero_flag       <= zero;
                Carry_flag      <= carry;
                Borrow_flag     <= borrow;
                Overflow_flag   <= overflow;
                Greater_flag    <= greater;
                Equal_flag      <= equal;

            when "0010" =>
                result <= sub_res ;  -- Subtraction
                Zero_flag       <= zero;
                Carry_flag      <= carry;
                Borrow_flag     <= borrow;
                Overflow_flag   <= overflow;
                Greater_flag    <= greater;
                Equal_flag      <= equal;

            when "0011" =>
                result <= and_res ;  -- AND
                Zero_flag       <= zero;
                Carry_flag      <= carry;
                Borrow_flag     <= borrow;
                Overflow_flag   <= overflow;
                Greater_flag    <= greater;
                Equal_flag      <= equal;

            when "0100" =>
                result <= or_res ;  -- OR
                Zero_flag       <= zero;
                Carry_flag      <= carry;
                Borrow_flag     <= borrow;
                Overflow_flag   <= overflow;
                Greater_flag    <= greater;
                Equal_flag      <= equal;

            when "0101" =>
                result <= not_res ;  -- NOT
                Zero_flag       <= zero;
                Carry_flag      <= carry;
                Borrow_flag     <= borrow;
                Overflow_flag   <= overflow;
                Greater_flag    <= greater;
                Equal_flag      <= equal;

            when "0110" =>
                result <= xor_res ;  -- XOR
                Zero_flag       <= zero;
                Carry_flag      <= carry;
                Borrow_flag     <= borrow;
                Overflow_flag   <= overflow;
                Greater_flag    <= greater;
                Equal_flag      <= equal;

            when "0111" =>
                result <= Lrotate_res ;  -- Rotate left
                Zero_flag       <= zero;
                Carry_flag      <= carry;
                Borrow_flag     <= borrow;
                Overflow_flag   <= overflow;
                Greater_flag    <= greater;
                Equal_flag      <= equal;

            when "1000" =>
                result <= Rrotate_res ;  -- Rotate right
                Zero_flag       <= zero;
                Carry_flag      <= carry;
                Borrow_flag     <= borrow;
                Overflow_flag   <= overflow;
                Greater_flag    <= greater;
                Equal_flag      <= equal;

            when "1001" =>
                result <= lshift_res ;  -- Logical left shift
                Zero_flag       <= zero;
                Carry_flag      <= carry;
                Borrow_flag     <= borrow;
                Overflow_flag   <= overflow;
                Greater_flag    <= greater;
                Equal_flag      <= equal;

            when "1010" =>
                result <= rshift_res ;  -- Logical right shift
                Zero_flag       <= zero;
                Carry_flag      <= carry;
                Borrow_flag     <= borrow;
                Overflow_flag   <= overflow;
                Greater_flag    <= greater;
                Equal_flag      <= equal;

            when "1011" =>
                result <= signshift_res ;  -- Arithmetic right shift
                Zero_flag       <= zero;
                Carry_flag      <= carry;
                Borrow_flag     <= borrow;
                Overflow_flag   <= overflow;
                Greater_flag    <= greater;
                Equal_flag      <= equal;

            when "1100" =>
                result <= (others => '0'); -- comparison A > B 
                Zero_flag       <= zero;
                Carry_flag      <= carry;
                Borrow_flag     <= borrow;
                Overflow_flag   <= overflow;
                Greater_flag    <= greater;
                Equal_flag      <= equal;
            
            when "1101" =>
                result <= (others => '0');  -- equality check
                Zero_flag       <= zero;
                Carry_flag      <= carry;
                Borrow_flag     <= borrow;
                Overflow_flag   <= overflow;
                Greater_flag    <= greater;
                Equal_flag      <= equal;
            
            when others =>
                result <= (others => '0');  -- Default case
        end case;
    end process;

end Behavioral;