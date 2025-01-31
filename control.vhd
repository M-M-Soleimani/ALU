library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Generic_Control_Unit is
    Generic (
        size : integer := 4
    );
    Port (
        opcode : in  STD_LOGIC_VECTOR (3 downto 0);
        A : in  STD_LOGIC_VECTOR (size-1 downto 0);
        B : in  STD_LOGIC_VECTOR (size-1 downto 0);
        result : out  STD_LOGIC_VECTOR (size-1 downto 0)
    );
end Generic_Control_Unit;

architecture Behavioral of Generic_Control_Unit is

    component Generic_Adder is
        Generic (
            size : integer := size
        );
        Port (
            A              : in  STD_LOGIC_VECTOR(size-1 downto 0);
            B              : in  STD.LOGIC_VECTOR(size-1 downto 0);
            Cin            : in  std.logic;  
            Sum            : out std.logic_vector(size-1 downto 0);
            Zero_flag      : out std.logic;
            Carry_flag     : out std.logic;
            Borrow_flag    : out std.logic;
            Overflow_flag  : out std.logic;
            Greater_flag   : out std.logic;
            Equal_flag     : out std.logic
        );
    end component;

    component GENERIC_AND is
        Generic (
            size : integer := size
        );
        Port (
            A              : in  STD.LOGIC_VECTOR(size-1 downto 0);
            B              : in  STD.LOGIC_VECTOR(size-1 downto 0);
            Result         : buffer STD.LOGIC_VECTOR(size-1 downto 0);
            Zero_flag      : out std.logic;
            Carry_flag     : out std.logic;
            Borrow_flag    : out std.logic;
            Overflow_flag  : out std.logic;
            Greater_flag   : out std.logic;
            Equal_flag     : out std.logic
        );
    end component;

    component generic_not is
        Generic (
            size : integer := size
        );
        Port (
            A              : in  STD.LOGIC_VECTOR(size-1 downto 0);
            Result         : buffer STD.LOGIC_VECTOR(size-1 downto 0);
            Zero_flag      : out std.logic;
            Carry_flag     : out std.logic;
            Borrow_flag    : out std.logic;
            Overflow_flag  : out std.logic;
            Greater_flag   : out std.logic;
            Equal_flag     : out std.logic
        );
    end component;

    component GENERIC_OR is
        Generic (
            size : integer := size
        );
        Port (
            A              : in  STD.LOGIC_VECTOR(size-1 downto 0);
            B              : in  STD.LOGIC_VECTOR(size-1 downto 0);
            Result         : buffer STD.LOGIC_VECTOR(size-1 downto 0);
            Zero_flag      : out std.logic;
            Carry_flag     : out std.logic;
            Borrow_flag    : out std.logic;
            Overflow_flag  : out std.logic;
            Greater_flag   : out std.logic;
            Equal_flag     : out std.logic
        );
    end component;

    component Left_Rotate is
        Generic (
            size : integer := size
        );
        Port (
            CLK            : in  std.logic;
            Reset          : in  std.logic;
            Rotate         : in  std.logic;
            A              : in  STD.LOGIC_VECTOR(size-1 downto 0);
            Result         : out STD.LOGIC_VECTOR(size-1 downto 0);
            Zero_flag      : out std.logic;
            Carry_flag     : out std.logic;
            Borrow_flag    : out std.logic;
            Overflow_flag  : out std.logic;
            Greater_flag   : out std.logic;
            Equal_flag     : out std.logic
        );
    end component;

    component Right_Rotate is
        Generic (
            size : integer := size
        );
        Port (
            CLK            : in  std.logic;
            Reset          : in  std.logic;
            Rotate         : in  std.logic;
            A              : in  STD.LOGIC_VECTOR(size-1 downto 0);
            Result         : out STD.LOGIC_VECTOR(size-1 downto 0);
            Zero_flag      : out std.logic;
            Carry_flag     : out std.logic;
            Borrow_flag    : out std.logic;
            Overflow_flag  : out std.logic;
            Greater_flag   : out std.logic;
            Equal_flag     : out std.logic
        );
    end component;

    component Right_Shift_Register is
        Generic (
            size : integer := size
        );
        Port (
            CLK            : in  std.logic;
            Reset          : in  std.logic;
            Shift          : in  std.logic;
            A              : in  STD.LOGIC_VECTOR(size-1 downto 0);
            Result         : out STD.LOGIC_VECTOR(size-1 downto 0);
            Zero_flag      : out std.logic;
            Carry_flag     : out std.logic;
            Borrow_flag    : out std.logic;
            Overflow_flag  : out std.logic;
            Greater_flag   : out std.logic;
            Equal_flag     : out std.logic
        );
    end component;

    component Arithmetic_Right_Shift is
        Generic (
            size : integer := size
        );
        Port (
            CLK            : in  std.logic;
            Reset          : in  std.logic;
            Shift          : in  std.logic;
            A              : in  STD.LOGIC_VECTOR(size-1 downto 0);
            Result         : out STD.LOGIC_VECTOR(size-1 downto 0);
            Zero_flag      : out std.logic;
            Carry_flag     : out std.logic;
            Borrow_flag    : out std.logic;
            Overflow_flag  : out std.logic;
            Greater_flag   : out std.logic;
            Equal_flag     : out std.logic
        );
    end component;

    component Generic_Subtractor is
        Generic (
            size : integer := size
        );
        Port (
            A              : in  STD.LOGIC_VECTOR(size-1 downto 0);
            B              : in  STD.LOGIC_VECTOR(size-1 downto 0);
            Bin            : in  std.logic;
            Diff           : out STD.LOGIC_VECTOR(size-1 downto 0);
            Zero_flag      : out std.logic;
            Carry_flag     : out std.logic;
            Borrow_flag    : out std.logic;
            Overflow_flag  : out std.logic;
            Greater_flag   : out std.logic;
            Equal_flag     : out std.logic
        );
    end component;

    component GENERIC_XOR is
        Generic (
            size : integer := size
        );
        Port (
            A              : in  STD_LOGIC_VECTOR(size-1 downto 0);
            B              : in  STD.LOGIC_VECTOR(size-1 downto 0);
            Result         : buffer STD.LOGIC_VECTOR(size-1 downto 0);
            Zero_flag      : out std.logic;
            Carry_flag     : out std.logic;
            Borrow_flag    : out std.logic;
            Overflow_flag  : out std.logic;
            Greater_flag   : out std.logic;
            Equal_flag     : out std.logic
        );
    end component;

    signal temp_result : STD.LOGIC_VECTOR(size-1 downto 0);
    signal carry, borrow, overflow, greater, equal, zero : STD.LOGIC;

begin
    process(opcode, A, B)
    begin
        case opcode is
            when "0000" =>
                u1: Generic_Adder
                    generic map (size => size)
                    port map (
                        A => A,
                        B => B,
                        Cin => '0',
                        Sum => temp_result,
                        Zero_flag => zero,
                        Carry_flag => carry,
                        Borrow_flag => borrow,
                        Overflow_flag => overflow,
                        Greater_flag => greater,
                        Equal_flag => equal
                    );
                result <= temp_result;  -- Addition

            when "0001" =>
                u2: Generic_Subtractor
                    generic map (size => size)
                    port map (
                        A => A,
                        B => B,
                        Bin => '0',
                        Diff => temp_result,
                        Zero_flag => zero,
                        Carry_flag => carry,
                        Borrow_flag => borrow,
                        Overflow_flag => overflow,
                        Greater_flag => greater,
                        Equal_flag => equal
                    );
                result <= temp_result;  -- Subtraction

            when "0010" =>
                u3: GENERIC_AND
                    generic map (size => size)
                    port map (
                        A => A,
                        B => B,
                        Result => temp_result,
                        Zero_flag => zero,
                        Carry_flag => carry,
                        Borrow_flag => borrow,
                        Overflow_flag => overflow,
                        Greater_flag => greater,
                        Equal_flag => equal
                    );
                result <= temp_result;  -- AND

            when "0011" =>
                u4: GENERIC_OR
                    generic map (size => size)
                    port map (
                        A => A,
                        B => B,
                        Result => temp_result,
                        Zero_flag => zero,
                        Carry_flag => carry,
                        Borrow_flag => borrow,
                        Overflow_flag => overflow,
                        Greater_flag => greater,
                        Equal_flag => equal
                    );
                result <= temp_result;  -- OR

            when "0100" =>
                u5: generic_not
                    generic map (size => size)
                    port map (
                        A => A,
                        Result => temp_result,
                        Zero_flag => zero,
                        Carry_flag => carry,
                        Borrow_flag => borrow,
                        Overflow_flag => overflow,
                        Greater_flag => greater,
                        Equal_flag => equal
                    );
                result <= temp_result;  -- NOT

            when "0101" =>
                u6: GENERIC_XOR
                    generic map (size => size)
                    port map (
                        A => A,
                        B => B,
                        Result => temp_result,
                        Zero_flag => zero,
                        Carry_flag => carry,
                        Borrow_flag => borrow,
                        Overflow_flag => overflow,
                        Greater_flag => greater,
                        Equal_flag => equal
                    );
                result <= temp_result;  -- XOR

            when "1000" =>
                u7: Left_Rotate
                    generic map (size => size)
                    port map (
                        CLK => '0',
                        Reset => '0',
                        Rotate => '1',
                        A => A,
                        Result => temp_result,
                        Zero_flag => zero,
                        Carry_flag => carry,
                        Borrow_flag => borrow,
                        Overflow_flag => overflow,
                        Greater_flag => greater,
                        Equal_flag => equal
                    );
                result <= temp_result;  -- Rotate left

            when "1001" =>
                u8: Right_Rotate
                    generic map (size => size)
                    port map (
                        CLK => '0',
                        Reset => '0',
                        Rotate => '1',
                        A => A,
                        Result => temp_result,
                        Zero_flag => zero,
                        Carry_flag => carry,
                        Borrow_flag => borrow,
                        Overflow_flag => overflow,
                        Greater_flag => greater,
                        Equal_flag => equal
                    );
                result <= temp_result;  -- Rotate right

            when "0110" =>
                u9: Right_Shift_Register
                    generic map (size => size)
                    port map (
                        CLK => '0',
                        Reset => '0',
                        Shift => '1',
                        A => A,
                        Result => temp_result,
                        Zero_flag => zero,
                        Carry_flag => carry,
                        Borrow_flag => borrow,
                        Overflow_flag => overflow,
                        Greater_flag => greater,
                        Equal_flag => equal
                    );
                result <= temp_result;  -- Logical right shift

            when "0111" =>
                u10: Arithmetic_Right_Shift
                    generic map (size => size)
                    port map (
                        CLK => '0',
                        Reset => '0',
                        Shift => '1',
                        A => A,
                        Result => temp_result,
                        Zero_flag => zero,
                        Carry_flag => carry,
                        Borrow_flag => borrow,
                        Overflow_flag => overflow,
                        Greater_flag => greater,
                        Equal_flag => equal
                    );
                result <= temp_result;  -- Arithmetic right shift

            when others =>
                result <= (others => '0');  -- Default case
        end case;
    end process;

end Behavioral;