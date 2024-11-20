library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  

entity tb_ALU is
end tb_ALU;

architecture Behavioral of tb_ALU is
    -- Component Declaration
    component ALU
        Port (
            A : in STD_LOGIC_VECTOR (7 downto 0);
            B : in STD_LOGIC_VECTOR (7 downto 0);
            sel : in STD_LOGIC_VECTOR (2 downto 0);
            Result : out STD_LOGIC_VECTOR (7 downto 0);
            Zero : out STD_LOGIC
        );
    end component;

    -- Test Signals
    signal A_tb      : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal B_tb      : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal sel_tb    : STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
    signal Result_tb : STD_LOGIC_VECTOR (7 downto 0);
    signal Zero_tb   : STD_LOGIC;

    -- Function to convert STD_LOGIC to STRING
    function std_logic_to_string(bit: STD_LOGIC) return string is
    begin
        if bit = '0' then
            return "0";
        else
            return "1";
        end if;
    end function;

    -- Procedure for printing test cases
    procedure print_test_case(
        test_name: string;
        A, B: STD_LOGIC_VECTOR(7 downto 0);
        sel: STD_LOGIC_VECTOR(2 downto 0);
        result: STD_LOGIC_VECTOR(7 downto 0);
        zero_flag: STD_LOGIC) is
    begin
        report "Test: " & test_name & 
               " | A=" & integer'image(to_integer(unsigned(A))) &
               " | B=" & integer'image(to_integer(unsigned(B))) &
               " | sel=" & integer'image(to_integer(unsigned(sel))) &
               " | Result=" & integer'image(to_integer(unsigned(result))) &
               " | Zero=" & std_logic_to_string(zero_flag);
    end procedure;

    
begin
    -- Unit Under Test (UUT)
    UUT: ALU port map (
        A => A_tb,
        B => B_tb,
        sel => sel_tb,
        Result => Result_tb,
        Zero => Zero_tb
    );
    
    -- Stimulus Process
    stim_proc: process
    begin
        -- Wait for 10ns for global reset
        wait for 10 ns;
        
        -- Test Case 1: Addition (000)
        A_tb <= "00000110";  -- 6
        B_tb <= "00000101";  -- 5
        sel_tb <= "000";     -- ADD
        wait for 10 ns;
        print_test_case("Addition", A_tb, B_tb, sel_tb, Result_tb, Zero_tb);
        
        -- Test Case 2: Subtraction (001)
        A_tb <= "00000111";  -- 7
        B_tb <= "00000011";  -- 3
        sel_tb <= "001";     -- SUB
        wait for 10 ns;
        print_test_case("Subtraction", A_tb, B_tb, sel_tb, Result_tb, Zero_tb);
        
        -- Test Case 3: AND (010)
        A_tb <= "11100000";
        B_tb <= "00000111";
        sel_tb <= "010";     -- AND
        wait for 10 ns;
        print_test_case("AND", A_tb, B_tb, sel_tb, Result_tb, Zero_tb);
        
        -- Test Case 4: OR (011)
        A_tb <= "11100000";
        B_tb <= "00001011";
        sel_tb <= "011";     -- OR
        wait for 10 ns;
        print_test_case("OR", A_tb, B_tb, sel_tb, Result_tb, Zero_tb);
        
        -- Test Case 5: XOR (100)
        A_tb <= "11010000";
        B_tb <= "00001011";
        sel_tb <= "100";     -- XOR
        wait for 10 ns;
        print_test_case("XOR", A_tb, B_tb, sel_tb, Result_tb, Zero_tb);
        
        -- Test Case 6: NOR (101)
        A_tb <= "10110000";
        B_tb <= "00001101";
        sel_tb <= "101";     -- NOR
        wait for 10 ns;
        print_test_case("NOR", A_tb, B_tb, sel_tb, Result_tb, Zero_tb);
        
        -- Test Case 7: Zero flag test
        A_tb <= "00000000";
        B_tb <= "00000000";
        sel_tb <= "000";     -- ADD
        wait for 10 ns;
        print_test_case("Zero Flag", A_tb, B_tb, sel_tb, Result_tb, Zero_tb);
        
        -- Test Case 8: Default case (Others)
        A_tb <= "11111111";
        B_tb <= "11111111";
        sel_tb <= "111";     -- Default operation
        wait for 10 ns;
        print_test_case("Default Case", A_tb, B_tb, sel_tb, Result_tb, Zero_tb);
        
        -- End simulation
        report "Simulation completed successfully";
        wait;
    end process;
    
end Behavioral;
