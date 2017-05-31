function meanFrame(src,event,varargin)
    % Tutorial ScanImage user function - extracting data from a frame
    %
    % function meanFrame(src,event,varargin)
    %
    % Purpose
    % Makes a Plots mean frame intensity over time for channel 1.
    % Chart is cleared every time focus is pressed. Chart scrolls 
    % once 50 data points have been acquired. 
    %
    %
    % Instructions:
    %
    % * Add the directory containing this function to your path
    % * In ScanImage go to Settings > User Functions and
    %   assign "meanFrame" to the events:
    %   focusStart
    %   frameAcquired
    %
    % * Ensure all are enabled
    % * Set up to acquire data on channel 1
    % * Press Focus
    % * Try pressing Abort then focus again. See how the figure is cleared
    %   first before data are added. 
    %
    % In simulated mode you will see a sine wave.

    hSI = src.hSI; % get the handle to the ScanImage model
    maxPoints=50;  % chart starts to scroll once this many points have been acquired

    persistent plotData %Retains data between function calls

    switch event.EventName

        case 'focusStart'
            % Look for a figure window that contains data from a previous
            % run of meanFrame. Make one if it doesn't exist, wipe it if it
            % does. 
            hFig = findobj(0,'Name','meanFramePlot');
            if isempty(hFig)
                hFig = figure;
                hFig.Name='meanFramePlot';
            end
            figure(hFig)
            tmpC = cla;

            plotData=plot(tmpC, nan, '-r', 'LineWidth', 2); %Plot a nan
            grid on
            xlim([0,maxPoints+1])

        case 'frameAcquired'
            % Pull in data from the first depth of the first channel
            lastFrame = hSI.hDisplay.stripeDataBuffer{1}.roiData{1}.imageData{1}{1};
            plotData.YData(end+1)=mean(lastFrame(:));
            if length(plotData.YData)>maxPoints
                plotData.YData = plotData.YData(end-maxPoints+1:end);
            end
    end % switch

end
