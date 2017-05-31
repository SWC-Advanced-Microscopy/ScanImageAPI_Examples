classdef frameProfile < handle
    % Reports actions taking place within ScanImage to the command line
    %
    % Instructions
    % * Start ScanImage 
    % * Start an instance of this class: F = frameProfile;
    % * Press Focus then Abort. Note messages at command line.
    % * To clean up run: delete(F)
    %
    % 
    % Rob Campbell - 2017


    properties
        hSI   % The ScanImage API
        hFig  % Handle to the figure window
        hAx   % Handle to the plot axes
        hP    % Handle to the plotted data
        listeners={}

    end % close properties block


    methods

        function obj = frameProfile

            % Pull in ScanImage API handle
            scanimageObjectName='hSI';
            W = evalin('base','whos');
            if ~ismember(scanimageObjectName,{W.name})
                fprintf('Can not find ScanImage API handle in base workspace. Please start ScanImage\n')
                obj.delete
                return
            end

            obj.hSI = evalin('base',scanimageObjectName); % get hSI from the base workspace


            % Create the figure window:
            obj.hFig = figure;
            obj.hFig.Name='Frame Profile';
            obj.hFig.CloseRequestFcn = @obj.closeFigCallback; %Closing the window will also run the destructor
            obj.hAx = cla;

            obj.hP = plot(obj.hAx, nan, '-r', 'LineWidth', 2); %Plot a nan
            grid on
            axis tight


            % ==> Have ScanImage enter focus mode here (HINT: do "methods(hSI)" at command line)


            % Add a listener to the the notifier that fires when a frame is acquired. 
            % This is the same notifier used for user functions.
            obj.listeners{1} = addlistener(obj.hSI.hUserFunctions ,'frameAcquired', @obj.fAcq);


            % ==> Once your class is working, come back here and add a listener to the LUT 
            %     property for chan 1 so that changing this slider changes the Y axis scale on
            %     your plot. The property is: hSI.hDisplay.chan1LUT
            %     You will need to add a callback function. 
            %     Remember to include the "PostSet" in the listener creation, since you're adding a 
            %     listener to an observable property.
            % obj.listeners{2} = 
        end % close constructor


        function delete(obj)

            % ==> Have ScanImage leave focus mode here (use the abort method)

            %Detach from the listeners (they won't be cleaned up unless they are explicitly deleted)
            cellfun(@delete,obj.listeners)

        end % close destructor


        function fAcq(obj,~,~)
            % Callback that runs when a frame is acquired
            % This method should pull out one column of image data plot it. 

            % ==> Complete this line (see meanFrame)
            % lastFrame = 

            % ==> Complete this line so you plot a cross-section (rows or columns, you choose, of the image)
            % obj.hP.YData = 

        end % close isAcquiring


        function closeFigCallback(obj,~,~)
            % Window close callback function
            delete(obj.hFig)
            obj.delete
        end % close closeFigCallback

    end % close methods block

end % close classdef
