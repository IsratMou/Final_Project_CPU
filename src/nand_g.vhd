library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nand_g is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Y : out STD_LOGIC);
end nand_g;

architecture DataFlow of nand_g is
begin
    Y <= NOT (A AND B);
end DataFlow;