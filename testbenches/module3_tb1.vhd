library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity module3_tb1 is
end module3_tb1;

architecture Behavioral of module3_tb1 is
    signal A, B : STD_LOGIC_VECTOR(3 downto 0);
    signal SUM : STD_LOGIC_VECTOR(3 downto 0);
begin
    uut: entity work.module3
        port map (
            A => A,
            B => B,
            SUM => SUM
        );
    
    process
    begin
        A <= "0011"; B <= "0101"; wait for 10 ns;  -- A = 3, B = 5
        A <= "0100"; B <= "0110"; wait for 10 ns;  -- A = 4, B = 6
        wait;
    end process;
end Behavioral;
