function helloScanImage(src,event,varargin)
    % Tutorial ScanImage user function
    %
    % function helloScanImage(src,event,varargin)
    %
    % 
    % Purpose
    % Prints messages to screen when the user starts and stops Focus
    % and acquires data.
    %
    % 
    % Instructions:
    %
    % * Add the directory containing this function to your path
    % * In ScanImage go to Settings > User Functions and press "Add"
    %   to assign "helloScanImage" (by just entering the function name
    %   under the "User Function" column) to the Events:
    %   focusStart
    %   focusDone
    %   acqModeStart
    %   acqModeDone
    %   acqDone
    % * Ensure all are enabled
    %
    % Now try the following and you will see messages appearing at the
    % command line:
    %
    % 1) Press "Focus" to start scanning. Then press Abort to stop. 
    %    Disable the user funtion for focusStart or focusDone and repeat.
    % 2)
    % - Set up a short acquisition, such as 3 Acqs each with 10 frames. 
    % - Press loop. You should see something like this at the command line:
    % Acquiring 256 x 256 images at 8.41 FPS
    % -> acqDone fired
    % -> acqDone fired
    % -> The acquisition took 6.88 seconds
    %
    %
    % Remove all the user functions when you're done by clicking on rows
    % and pressing the "Del" button.


    hSI = src.hSI; % get the handle to the ScanImage model

    persistent acqModeTime

    switch event.EventName

        case 'acqModeStart'

            % Report some settings to screen
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