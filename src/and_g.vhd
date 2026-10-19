
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity and_g is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Y : out STD_LOGIC);
end and_g;

architecture DataFlow of and_g is
    -- Intermediate signal for NAND output
    signal nand_out : STD_LOGIC;
	 
begin
    -- First NAND operation
    nand_out <= NOT (A AND B);
    
    -- Second NAND (acting as NOT) to make it an AND gate
    Y <= NOT nand_out;
	 
end DataFlow;
