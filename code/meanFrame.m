function meanFrame(src,event,varargin)
    % Instructions:
    %
    % * Add the directory containing this function to your path
    % * In ScanImage go to Settings > User Functions and
    %   assign "meanFrame" to the events:
    %   focusStart
    %   frameAcquired
    %
    % * Ensure all are enabled
    % * Acquire data on channel 1
    % * Press Focus
    %
    % In simulated mode you will see a sine wave.
    
    hSI = src.hSI; % get the handle to the ScanImage model
    
    persistent plotData
    switch event.EventName
           
        case 'focusStart'
            % Look for a figure window that contains data from a previous
            % run of meanFrame. Make one if it doesn't exist
            hFig = findobj(0,'Name','meanFramePlot');
            if isempty(hFig)
                hFig = figure;
                hFig.Name='meanFramePlot';
            end
            figure(hFig)
            tmpC = cla;
            
            plotData=plot(tmpC, nan); %Plot a nan
            grid on
            fprintf('Focus mode started\n')
            
        case 'frameAcquired'
            % Pull in data from the first depth of the first channel
            lastFrame = hSI.hDisplay.stripeDataBuffer{1}.roiData{1}.imageData{1}{1};
            plotData.YData(end+1)=mean(lastFrame(:));
            if length(plotData.YData)>50
                plotData.YData = plotData.YData(end-49:end);
            end
    end % switch

end
