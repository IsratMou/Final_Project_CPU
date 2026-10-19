library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- 8-bit accumulator. Output Q is also the CPU output.
entity acc_reg is
    Port ( CLK   : in  STD_LOGIC;
           RESET : in  STD_LOGIC;                       -- synchronous, active high
           EN    : in  STD_LOGIC;                       -- load enable from Control Unit
           D     : in  STD_LOGIC_VECTOR (7 downto 0);   -- ALU result
           Q     : out STD_LOGIC_VECTOR (7 downto 0));
end acc_reg;

architecture Behavioral of acc_reg is
    signal acc_s : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
begin
    process (CLK)
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                acc_s <= (others => '0');
            elsif EN = '1' then
                acc_s <= D;
            end if;
        end if;
    end process;
    Q <= acc_s;
end Behavioral;
