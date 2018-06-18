function startup_grafika

% Pridava vsechny podadresare do "cesty"

% Pavel Rajmic, Zdenek Prusa

startupfilename = 'startup_grafika';

basepath = which(startupfilename);
basepath = basepath(1:end-length(startupfilename)-2);

dircurr = dir(basepath);
addpath(basepath);

ignored = {'.','..','.git'};

for ii=1:numel(dircurr)
    if dircurr(ii).isdir && ...
       ~any(cellfun(@(iEl)strcmp(iEl,dircurr(ii).name),ignored))
        addpath([basepath,dircurr(ii).name]);
    end
end


if isoctave
    % set(0,'linewidth',2);
    IMAGE_PATH([basepath,'obrazky']);
end

disp('Cesty (path) byly pridany ke stavajicim, coz plati az do ukonceni Matlabu')
