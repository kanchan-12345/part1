library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FourBitAdder_tb is
end FourBitAdder_tb;

architecture Behavioral of FourBitAdder_tb is
    -- Component Declaration
    component FourBitAdder
        Port (
            A      : in  STD_LOGIC_VECTOR(3 downto 0);
            B      : in  STD_LOGIC_VECTOR(3 downto 0);
            Cin    : in  STD_LOGIC;
            Sum    : out STD_LOGIC_VECTOR(3 downto 0);
            Cout   : out STD_LOGIC
        );
    end component;

    -- Signals for simulation
    signal A, B : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal Cin  : STD_LOGIC := '0';
    signal Sum  : STD_LOGIC_VECTOR(3 downto 0);
    signal Cout : STD_LOGIC;

begin
    -- Instantiate the 4-bit Adder
    UUT: FourBitAdder
        Port map (
            A => A,
            B => B,
            Cin => Cin,
            Sum => Sum,
            Cout => Cout
        );

    -- Testbench process
    process
    begin
        -- Test Case 1
        A <= "0001"; B <= "0010"; Cin <= '0';
        wait for 10 ns;

        -- Test Case 2
        A <= "0110"; B <= "0101"; Cin <= '1';
        wait for 10 ns;

        -- Test Case 3
        A <= "1111"; B <= "1111"; Cin <= '1';
        wait for 10 ns;

        wait;
    end process;
end Behavioral;
