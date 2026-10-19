library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Zero flag: 1 when the value written to ACC is 0x00. RESET sets it to 1.
entity z_flag is
    Port ( CLK   : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           EN    : in  STD_LOGIC;     -- Z updates only when ACC is written (not for JZ / NOP)
           D     : in  STD_LOGIC;     -- zero-detect of ALU result
           Z     : out STD_LOGIC);
end z_flag;

architecture Behavioral of z_flag is
    signal z_s : STD_LOGIC := '1';
begin
    process (CLK)
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                z_s <= '1';
            elsif EN = '1' then
                z_s <= D;
            end if;
        end if;
    end process;
    Z <= z_s;
end Behavioral;
