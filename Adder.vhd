library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Generic_Adder is
    Generic (
        size : integer := 4
    );
    Port (
        A              : in  std_logic_vector(size-1 downto 0);
        B              : in  std_logic_vector(size-1 downto 0);
        Cin            : in  std_logic;  
        Sum            : out std_logic_vector(size-1 downto 0);
        Zero_flag      : out std_logic;
        Carry_flag     : out std_logic;
        Borrow_flag    : out std_logic;
        Overflow_flag  : out std_logic;
        Greater_flag    : out std_logic;
        Equal_flag     : out std_logic
    );
end Generic_Adder;

architecture Behavioral of Generic_Adder is
    signal temp_sum : std_logic_vector(size-1 downto 0);
    signal Cin_unsigned : unsigned(size-1 downto 0);  
begin

    process(A, B, Cin, temp_sum)
    begin
        Cin_unsigned <= (others => '0');
        if Cin = '1' then
            Cin_unsigned(0) <= '1';
        end if ;
        temp_sum <= std_logic_vector(unsigned(A) + unsigned(B) + Cin_unsigned);
        Sum <= temp_sum; 
    end process;
    
    process(A, B, Cin, temp_sum)
    begin
        Zero_flag <= '1';
        for i in 0 to size-1 loop
            if temp_sum(i) = '1' then
                Zero_flag <= '0';
            end if;
        end loop;

        Carry_flag <= (A(size-1) AND B(size-1)) OR (A(size-2) AND B(size-2));

        Borrow_flag <= '0';

        Overflow_flag <= (A(size-1) AND B(size-1)) OR (A(size-2) AND B(size-2));

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
    end process;

end Behavioral;