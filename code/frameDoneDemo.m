classdef frameDoneDemo < handle
    % Reports actions taking place within ScanImage 
    %
    % Instructions
    % * Start ScanImage 
    % * Start an instance of this class: F=frameDoneDemo;
    % * Press Focus
    %
    % To clean up run: delete(F)



    properties
        hSI % The ScanImage API
        listeners={}
    end % close properties block


    methods

        function obj = frameDoneDemo
            % Pull in ScanImage API handle
            scanimageObjectName='hSI';
            W = evalin('base','whos');
            if ~ismember(scanimageObjectName,{W.name})
                fprintf('Can not find ScanImage API handle in base workspace. Please start ScanImage\n')
                obj.delete
                return
            end

            obj.hSI = evalin('base',scanimageObjectName); % get hSI from the base workspace

            % Add a listener to the the notifier that fires when a frame is acquired. 
            % This is the same notifier used for user functions.
            obj.listeners{1} = addlistener(obj.hSI.hUserFunctions ,'frameAcquired', @obj.fAcq);
            % obj.listeners{n}  % More listeners can be added here. 
        end % close constructor


        function delete(obj)
            %Detach from the listeners (they won't be cleaned up unless they are explicitly deleted)
            cellfun(@delete,obj.listeners)
        end % close destructor


        function fAcq(obj,~,~)
            % Callback fAcq that runs when the ScanImage acquisition state changes
            dataBuffer = obj.hSI.hDisplay.stripeDataBuffer{1};
            fprintf('Acquired frame %d\n',dataBuffer.frameNumberAcq)
        end % fAcq

    end % close methods block

end % close classdef
