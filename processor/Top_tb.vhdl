library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Top_tb is
end Top_tb;

architecture Behavioral of Top_tb is
    -- Component Declaration
    component Top
        Port (
            clk : in STD_LOGIC;
            reset : in STD_LOGIC
        );
    end component;
    
    -- Test Signals
    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    
    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns;
    
begin
    -- Instantiate the Unit Under Test (UUT)
    UUT: Top port map (
        clk => clk,
        reset => reset
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
        -- Initialize with reset
        reset <= '1';
        wait for CLK_PERIOD*4;
        
        -- Release reset and let it run
        reset <= '0';
        wait for CLK_PERIOD*20;  -- Run for 20 clock cycles
        
        -- Apply reset again
        reset <= '1';
        wait for CLK_PERIOD*2;
        reset <= '0';
        
        -- Let it run some more
        wait for CLK_PERIOD*20;
        
        -- End simulation
        wait;
    end process;
end Behavioral;