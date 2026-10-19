library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- 4-bit program counter: PC+1 every cycle, or PC <- LOAD_ADDR when LOAD = 1 (JZ taken).
entity pc_reg is
    Port ( CLK       : in  STD_LOGIC;
           RESET     : in  STD_LOGIC;
           LOAD      : in  STD_LOGIC;
           LOAD_ADDR : in  STD_LOGIC_VECTOR (3 downto 0);
           PC        : out STD_LOGIC_VECTOR (3 downto 0));
end pc_reg;

architecture Behavioral of pc_reg is
    signal pc_s : UNSIGNED (3 downto 0) := (others => '0');
begin
    process (CLK)
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                pc_s <= (others => '0');
            elsif LOAD = '1' then
                pc_s <= UNSIGNED(LOAD_ADDR);
            else
                pc_s <= pc_s + 1;
            end if;
        end if;
    end process;
    PC <= STD_LOGIC_VECTOR(pc_s);
end Behavioral;
