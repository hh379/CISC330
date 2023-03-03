% This function generates a random number between a and b.

function num = randomNum_generator(a, b)
num = a + (b-a).*rand(1,1);
end % end the function