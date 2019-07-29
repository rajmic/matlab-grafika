% demo_binary_represent

% Prints binary representations of the chosen interval of integers.
% Displayed values are Sign bit only, One's complement, Two's complement.
% Sign bit is displayed separately.
%
% For zero there are two different representations in Sign bit only and One's
% complement.

% (c) 2019 Matouš Vrbík, Pavel Rajmic, Brno University of Technology

%% vstup: interval celych cisel (dekadicky) ke zobrazeni
firstOfRange = -5
LastOfRange = 5


%% urèení poètu bitù kvùli vypisování
bitDepth = max(length(dec2bin(abs(firstOfRange))), length(dec2bin(abs(LastOfRange))));

% if length(dec2bin(abs(LastOfRange)))> bitDepth
%     bitDepth = length(dec2bin(abs(LastOfRange)));
% end

if bitDepth<3
    bitDepth = 3;
end

%% výèet èísel
n = LastOfRange - firstOfRange + 1;
numbers = linspace(firstOfRange,LastOfRange,n);

initMessage = 'Decadic   Only sign bit  One''s Complement  Two''s Complement';
disp(initMessage);

%print original
%check if number X is negative
%   not -> all three representations equal
%   yes ->  
%       1) signed bit - s = 1, dec2bin(abs(X))
%       2) one's comp - s = 1, dec2bin(bitget(X-1))
%       3) two's comp - s = 1, dec2bin(bitget(X))
%
%bitget(X) returns bits even for negative numbers - in two's complement
%so to convert it to ones we must subtract 1
%note that bitget() returns an array; thus conversion must be done


for i=1:n
    %% print original
    if(numbers(i) == 0)
        numberDisplay = '-0';
        numSpaces = 21-bitDepth-length(num2str(numbers(i)))-1;
    else
        numberDisplay = num2str(numbers(i));
        numSpaces = 21-bitDepth-length(num2str(numbers(i)));
    end
    for j=1:numSpaces %form the output string by appending spaces
        numberDisplay = strcat(numberDisplay,{' '});
    end
    %% print converted
    if numbers(i)>0     % greater than zero -- all are identical
        sign = num2str(0);
        signedNumber = dec2bin(numbers(i),bitDepth);
        onesNumber = signedNumber;
        twosNumber = signedNumber;
    else
        if numbers(i)<0    % smaller than zero
            sign = num2str(1);
            signedNumber = dec2bin(abs(numbers(i)),bitDepth);
            
            %conversions
            onesNumberAr = bitget(int32(numbers(i)-1),bitDepth:-1:1);
            onesNumber = num2str(onesNumberAr(1));
            for k=2:length(onesNumberAr)
                onesNumber = strcat(onesNumber,num2str(onesNumberAr(k)));
            end
            
            twosNumberAr = bitget(int32(numbers(i)),bitDepth:-1:1);
            twosNumber = num2str(twosNumberAr(1));
            for k=2:length(twosNumberAr)
                twosNumber = strcat(twosNumber,num2str(twosNumberAr(k)));
            end
        else    % zero
            sign = num2str(1);
            sign1 = num2str(0);
            signedNumber1 = dec2bin(numbers(i),bitDepth);        %positive zero
            signedNumber = dec2bin(numbers(i),bitDepth);         %negative zero
            onesNumber1 = dec2bin(numbers(i),bitDepth);          %positive zero
            onesNumber = dec2bin(2^bitDepth-1,bitDepth);         %negative zero
            twosNumber = dec2bin(numbers(i),bitDepth);
        end
    end

%% print
    numberDisplay = strcat(numberDisplay,sign );
    numberDisplay = strcat(numberDisplay,{' '},signedNumber);  
    numSpaces = 16-bitDepth;
    for j=1:numSpaces %form the output string by appending spaces
            numberDisplay = strcat(numberDisplay,{' '});   
    end
    numberDisplay = strcat(numberDisplay,sign );
    numberDisplay = strcat(numberDisplay,{' '},onesNumber);  
    if(numbers(i) ~=0)  %print if not zero - because -0 gets printed first, and it does not have representation here
        numSpaces = 16-bitDepth;
        for j=1:numSpaces %form the output string by appending spaces
            numberDisplay = strcat(numberDisplay,{' '});   
        end
        numberDisplay = strcat(numberDisplay,sign );
        numberDisplay = strcat(numberDisplay,{' '},twosNumber);  
    end
    
    disp(numberDisplay{1});
    
 %% if number is zero print agin
    if numbers(i) == 0   
        numberDisplay = num2str(numbers(i));
        strcat(numberDisplay,num2str(numbers(i)));  
        numSpaces = 21-bitDepth-length(num2str(numbers(i)));
        for j=1:numSpaces
            numberDisplay = strcat(numberDisplay,{' '});   
        end
        numberDisplay = strcat(numberDisplay,sign1 );
        numberDisplay = strcat(numberDisplay,{' '},signedNumber1);  
        numSpaces = 16-bitDepth;
        for j=1:numSpaces
            numberDisplay = strcat(numberDisplay,{' '});   
        end
        numberDisplay = strcat(numberDisplay,sign1 );
        numberDisplay = strcat(numberDisplay,{' '},onesNumber1);    
        numSpaces = 16-bitDepth;
        for j=1:numSpaces
            numberDisplay = strcat(numberDisplay,{' '});   
        end
        numberDisplay = strcat(numberDisplay,sign1 );
        numberDisplay = strcat(numberDisplay,{' '},twosNumber); 
        
        disp(numberDisplay{1});
    end

end