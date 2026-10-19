library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor_g is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Y : out STD_LOGIC);
end xor_g;

architecture Structural of xor_g is

    -- Component declaration for our base NAND gate
    component nand_g
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Y : out STD_LOGIC);
    end component;

    -- Internal signals to connect the NAND gates
    signal w1, w2, w3 : STD_LOGIC;
begin

    -- w1 = A NAND B
    U1: nand_g port map (A => A, B => B, Y => w1);

    -- w2 = A NAND w1
    U2: nand_g port map (A => A, B => w1, Y => w2);

    -- w3 = B NAND w1
    U3: nand_g port map (A => B, B => w1, Y => w3);

    -- Y = w2 NAND w3 (which gives the final XOR output)
    U4: nand_g port map (A => w2, B => w3, Y => Y);

end Structural;
