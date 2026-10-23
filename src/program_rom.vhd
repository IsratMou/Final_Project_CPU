library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- 16 x 12-bit program ROM (Appendix B, Set 9). Unused locations = 0x000 (NOP).
entity program_rom is
    Port ( PC    : in  STD_LOGIC_VECTOR (3 downto 0);
           INSTR : out STD_LOGIC_VECTOR (11 downto 0));
end program_rom;

architecture Behavioral of program_rom is
    type rom_type is array (0 to 15) of STD_LOGIC_VECTOR (11 downto 0);
    constant ROM : rom_type := (
        0      => x"1FF",   -- LDI 0xFF
        1      => x"700",   -- NOT
        2      => x"C05",   -- JZ  0x05
        3      => x"277",   -- ADD 0x77
        4      => x"277",   -- ADD 0x77
        5      => x"211",   -- ADD 0x11
        6      => x"800",   -- SHL
        7      => x"C00",   -- JZ  0x00
        8      => x"800",   -- SHL
        others => x"000");  -- NOP
begin
    INSTR <= ROM(to_integer(unsigned(PC)));
end Behavioral;
