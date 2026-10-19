library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity or_g is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Y : out STD_LOGIC);
end or_g;

architecture DataFlow of or_g is
begin
    -- OR logic
    Y <= A OR B;
end DataFlow;