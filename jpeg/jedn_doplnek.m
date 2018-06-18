function out = jedn_doplnek(bin_num)

% vraci jednotkovy doplnek binarniho cisla

    for cnt = 1:length(bin_num)
        if bin_num(cnt) == '0'
            out(cnt) = '1';
        else
            out(cnt) = '0';
        end
    end
end