library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Generic_Control_Unit is
end tb_Generic_Control_Unit;

architecture Behavioral of tb_Generic_Control_Unit is

    signal Opcode : STD_LOGIC_VECTOR(3 DOWNTO 0) := ( OTHERS => '0' );
    signal A      : STD_LOGIC_VECTOR(3 DOWNTO 0) := ( OTHERS => '0' );
    signal B      : STD_LOGIC_VECTOR(3 DOWNTO 0) := ( OTHERS => '0' );
    signal reset  : STD_LOGIC := '0';
    signal CLK    : STD_LOGIC := '0';
    signal shift  : STD_LOGIC := '0';
    signal rotate : STD_LOGIC := '0';
    signal Zero_flag     : std_logic := '0' ;
    signal Carry_flag    : std_logic := '0' ;
    signal Borrow_flag   : std_logic := '0' ;
    signal Overflow_flag : std_logic := '0' ;
    signal Greater_flag  : std_logic := '0' ;
    signal Equal_flag    : std_logic := '0' ;
    signal result : STD_LOGIC_VECTOR(3 DOWNTO 0):= ( OTHERS => '0' );

    constant CLK_PERIOD : time := 10 ns;

begin

    uut: entity work.Generic_Control_Unit
        generic map (
            size => 4
        )
        port map (
            Opcode => Opcode,
            A      => A,
            B      => B,
            reset  => reset,
            CLK    => CLK,
            shift  => shift,
            rotate => rotate,
            result => result
        );

    clk_process : process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;


    stim_process : process
    
    begin
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait for 20 ns;

        Opcode <= "0001";  -- Addition
        A <= "0011";       
        B <= "0001";       
        wait for 40 ns;

        Opcode <= "0010";  -- Subtraction
        A <= "0011";       
        B <= "0001";       
        wait for 40 ns;

        Opcode <= "0011";  -- AND
        A <= "1100";       
        B <= "1010";       
        wait for 40 ns;

        Opcode <= "0100";  -- OR
        A <= "1100";       
        B <= "1010";       
        wait for 40 ns;

        Opcode <= "0101";  -- NOT
        A <= "1100";       
        wait for 40 ns;

        Opcode <= "0110";  -- XOR
        A <= "1100";       
        B <= "1010";       
        wait for 40 ns;

        Opcode <= "0111";  -- Rotate left
        A <= "1001";       
        rotate <= '1';
        wait for 40 ns;
        rotate <= '0';
        wait for 40 ns;

        Opcode <= "1000";  -- Rotate right
        A <= "1001";       
        rotate <= '1';
        wait for 40 ns;
        rotate <= '0';
        wait for 40 ns;

        Opcode <= "1001";  -- Logical left shift
        A <= "1100";       
        shift <= '1';
        wait for 40 ns;
        shift <= '0';
        wait for 40 ns;

        Opcode <= "1010";  -- Logical right shift
        A <= "0011";       
        shift <= '1';
        wait for 40 ns;
        shift <= '0';
        wait for 40 ns;

        Opcode <= "1011";  -- Arithmetic right shift
        A <= "1100";       
        shift <= '1';
        wait for 40 ns;
        shift <= '0';
        wait for 40 ns;

        Opcode <= "1100";  -- comparison A > B
        A <= "1111";       
        B <= "1100";       
        wait for 40 ns;

        Opcode <= "1001";  -- check A equal B
        A <= "1001";       
        B <= "1001";       
        wait for 40 ns;

        wait;  -- Wait indefinitely to end the simulation
    end process;

end Behavioral;