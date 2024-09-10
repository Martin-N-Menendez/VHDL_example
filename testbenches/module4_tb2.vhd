library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity module4_tb2 is
end module4_tb2;

architecture Behavioral of module4_tb2 is
    signal A, B : STD_LOGIC_VECTOR(3 downto 0);
    signal SUM : STD_LOGIC_VECTOR(3 downto 0);
begin
    uut: entity work.module4
        port map (
            A => A,
            B => B,
            SUM => SUM
        );
    
    process
    begin
        A <= "0110"; B <= "0111"; wait for 10 ns;  -- A = 6, B = 7
        A <= "1001"; B <= "1010"; wait for 10 ns;  -- A = 9, B = 10
        wait;
    end process;
end Behavioral;
