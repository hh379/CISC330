% This normalize.m is used to normalize a vector.

function [normalized_vector] = normalize(v)
    % This function is used to mormalize a vector.
    % Input:
    %       v: a vecotr
    % Output:
    %       normalized_vector: a vector which is normalized

        normalized_vector = v / sqrt(dot(v, v));
end % end the function