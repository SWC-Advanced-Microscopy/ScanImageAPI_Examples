function reportChannels
    % Simple function that uses the ScanImage API to report which channels are active
    %
    % Instructions
    % * Start ScanImage 
    % * Run this function from the command line
    % * Try checking/unchecking save and display boxes and run again



    % Pull in ScanImage API handle from the base workspace
    scanimageObjectName='hSI';
    W = evalin('base','whos');
    if ~ismember(scanimageObjectName,{W.name})
        fprintf('Can not find ScanImage API handle in base workspace. Please start ScanImage\n')
        return
    end


    SIAPI = evalin('base',scanimageObjectName); % get hSI from the base workspace


    % Pull out channels information and report details to screen
    hC = SIAPI.hChannels;
    fprintf('%d channels are available for acquisition:\n', hC.channelsAvailable)

    for ii=1:hC.channelsAvailable
        chnDisp = any(hC.channelDisplay == ii);
        fprintf('%s - Input Range= +/- %0.2f V, Save=%s, Display=%s\n', ...
            hC.channelName{ii}, ...
            hC.channelInputRange{ii}(2),...
            logicalToYesNo(any(hC.channelSave == ii)), ...
            logicalToYesNo(any(hC.channelDisplay == ii)) )
    end

    fprintf('\n')



function myStr = logicalToYesNo(in)
    if in
        myStr='YES';
    else
        myStr='NO ';
    end