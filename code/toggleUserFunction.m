function toggleUserFunction(UserFcnName,toggleStateTo)
    % Find userfunction with UserFcnName and toggle its Enable state to toggleStateTo
    %
    % Purpose
    % Shows how to enable/disable a named user function from the command line
    %
    % Instructions
    %  Start ScanImage
    %  Go to Settings > UserFunctions
    %  Press Add 
    %  Under the "User Function column type "test" (this won't run anything since this function does not exist)
    %  At the command line try: toggleUserFunction('test',1) and toggleUserFunction('test',0) 
    %  Delete the user function line in the GUI window when you're done.
    %


    % Pull in ScanImage API handle
    scanimageObjectName='hSI';
    W = evalin('base','whos');
    if ~ismember(scanimageObjectName,{W.name})
        fprintf('Can not find ScanImage API handle in base workspace. Please start ScanImage\n')
        return
    end

    hSI = evalin('base',scanimageObjectName); % get hSI from the base workspace


    if isempty(hSI.hUserFunctions.userFunctionsCfg)
        fprintf('ScanImage contains no user functions.\n')
        return
    end

    names={hSI.hUserFunctions.userFunctionsCfg.UserFcnName};
    ind=strmatch(UserFcnName,names,'exact');

    if isempty(ind)
        fprintf('Can not find user function names %s\n',UserFcnName);
        return
    end

    if length(ind)>1
        fprintf('Disabling %d user functions with name %s\n', length(ind), UserFcnName);
    end

    for ii=1:length(ind)
        hSI.hUserFunctions.userFunctionsCfg(ind(ii)).Enable=toggleStateTo;
    end


end %toggleUserFunction

