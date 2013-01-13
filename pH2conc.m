function [ conc ] = pH2conc( pH )
%conc2pH converts concentration to pH

conc = 10.^(-pH).*1e3;

end

