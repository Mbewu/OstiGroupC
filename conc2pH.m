function [ pH ] = conc2pH( concentration )
%conc2pH converts concentration to pH

pH = - log10(concentration.*1e-3);


end

