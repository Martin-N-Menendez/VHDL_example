library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity module1_tb1 is
end module1_tb1;

architecture Behavioral of module1_tb1 is
    signal A, B : STD_LOGIC_VECTOR(3 downto 0);
    signal SUM : STD_LOGIC_VECTOR(3 downto 0);
begin
    uut: entity module1
        port map (
            A => A,
            B => B,
            SUM => SUM
        );
    
    process
    begin
        A <= "0001"; B <= "0010"; wait for 10 ns;  -- A = 1, B = 2
        A <= "0011"; B <= "0100"; wait for 10 ns;  -- A = 3, B = 4
        A <= "0101"; B <= "0110"; wait for 10 ns;  -- A = 5, B = 6
        wait;
    end process;
end Behavioral;
