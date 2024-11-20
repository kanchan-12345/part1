library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Processor_tb is
end Processor_tb;

architecture Behavioral of Processor_tb is
    -- Component Declaration
    component Processor
        Port (
            clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            instr_addr : out STD_LOGIC_VECTOR (7 downto 0);
            instr : in STD_LOGIC_VECTOR (31 downto 0);
            data_addr : out STD_LOGIC_VECTOR (7 downto 0);
            data_in : out STD_LOGIC_VECTOR (7 downto 0);
            data_out : in STD_LOGIC_VECTOR (7 downto 0);
            data_wr : out STD_LOGIC
        );
    end component;
    
    -- Test Signals
    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal instr_addr : STD_LOGIC_VECTOR (7 downto 0);
    signal instr : STD_LOGIC_VECTOR (31 downto 0);
    signal data_addr : STD_LOGIC_VECTOR (7 downto 0);
    signal data_in : STD_LOGIC_VECTOR (7 downto 0);
    signal data_out : STD_LOGIC_VECTOR (7 downto 0);
    signal data_wr : STD_LOGIC;
    
    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns;
    
begin
    -- Instantiate the Unit Under Test (UUT)
    UUT: Processor port map (
        clk => clk,
        reset => reset,
        instr_addr => instr_addr,
        instr => instr,
        data_addr => data_addr,
        data_in => data_in,
        data_out => data_out,
        data_wr => data_wr
    );
    
    -- Clock process
    clk_process: process
    begin
        clk <= '0';
        wait for CLK_PERIOD/2;
        clk <= '1';
        wait for CLK_PERIOD/2;
    end process;
    
    -- Stimulus process
    stim_proc: process
    begin
        -- Initialize
        reset <= '1';
        data_out <= x"00";
        wait for CLK_PERIOD*2;
        
        -- Release reset
        reset <= '0';
        wait for CLK_PERIOD;
        
        -- Test ADD instruction
        instr <= "00000000" & x"FF" & x"01" & x"00"; -- ADD FF + 01
        wait for CLK_PERIOD;
        
        -- Test SUB instruction
        instr <= "00100000" & x"FF" & x"01" & x"00"; -- SUB FF - 01
        wait for CLK_PERIOD;
        
        -- Test AND instruction
        instr <= "01000000" & x"FF" & x"0F" & x"00"; -- AND FF & 0F
        wait for CLK_PERIOD;
        
        -- Test OR instruction
        instr <= "01100000" & x"F0" & x"0F" & x"00"; -- OR F0 | 0F
        wait for CLK_PERIOD;
        
        -- Test XOR instruction
        instr <= "10000000" & x"FF" & x"55" & x"00"; -- XOR FF ^ 55
        wait for CLK_PERIOD;
        
        -- Test NOR instruction
        instr <= "10100000" & x"FF" & x"00" & x"00"; -- NOR FF NOR 00
        wait for CLK_PERIOD;
        
        -- Wait for a few more cycles
        wait for CLK_PERIOD*4;
        
        -- Test reset again
        reset <= '1';
        wait for CLK_PERIOD*2;
        reset <= '0';
        
        wait;
    end process;
end Behavioral;

