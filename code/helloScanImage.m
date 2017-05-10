function helloScanImage(src,event,varargin)
    % Instructions:
    %
    % * Add the directory containing this function to your path
    % * In ScanImage go to Settings > User Functions and
    %   assign "helloScanImage" to the events:
    %   focusStart
    %   focusDone
    %   acqModeStart
    %   acqModeDone
    %   acqDone
    % * Ensure all are enabled
    %
    % * Set up a short acquisition, such as 3 Acqs each with 10 frames. 
    % * Press loop. You should see something like this at the command line:
    % Acquiring 256 x 256 images at 8.41 FPS
    % -> acqDone fired
    % -> acqDone fired
    % -> The acquisition took 6.88 seconds
    
    hSI = src.hSI; % get the handle to the ScanImage model
    
    persistent acqModeTime
    
    switch event.EventName
           
        case 'acqModeStart'
            hRoi = hSI.hRoiManager;
            fprintf('Acquiring %d x %d images at %0.2f FPS\n',...
                hRoi.pixelsPerLine, hRoi.linesPerFrame, hRoi.scanFrameRate)
            acqModeTime = tic;

        case 'acqModeDone'
            fprintf(' -> The acquisition took %0.2f seconds\n', toc(acqModeTime) )

        case 'acqDone'
            fprintf(' -> acqDone fired\n')

        case 'focusStart'
            fprintf('Focus mode started\n')
            
        case 'focusDone'
            fprintf('Focus mode finished\n')
    end % switch

end