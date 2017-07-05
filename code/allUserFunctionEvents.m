classdef allUserFunctionEvents < handle
    % Attaches listeners to all user-function events and reports their occurance to the command line
    %
    % Instructions
    % * Start ScanImage 
    % * Start an instance of this class: F=allUserFunctionEvents;
    % * Press Focus, set up grabs and z-stack, etc. Note messages at command line.
    % * To clean up run: delete(F)
    %
    % 
    % Rob Campbell - 2017


    properties
        hSI % The ScanImage API
        listeners={}
    end % close properties block


    methods

        function obj = allUserFunctionEvents
            % Pull in ScanImage API handle
            scanimageObjectName='hSI';
            W = evalin('base','whos');
            if ~ismember(scanimageObjectName,{W.name})
                fprintf('Can not find ScanImage API handle in base workspace. Please start ScanImage\n')
                obj.delete
                return
            end

            obj.hSI = evalin('base',scanimageObjectName); % get hSI from the base workspace

            % Add listeners to the UserFunction notifiers. These fire when 
            % certain events happen (info from +scanimage/+components/UserFunctions)
            obj.listeners{end+1} = addlistener(obj.hSI.hUserFunctions ,'acqModeArmed', @obj.fAcq);
            obj.listeners{end+1} = addlistener(obj.hSI.hUserFunctions ,'acqModeStart', @obj.fAcq);
            obj.listeners{end+1} = addlistener(obj.hSI.hUserFunctions ,'acqModeDone', @obj.fAcq);
            obj.listeners{end+1} = addlistener(obj.hSI.hUserFunctions ,'acqStart', @obj.fAcq);
            obj.listeners{end+1} = addlistener(obj.hSI.hUserFunctions ,'acqDone', @obj.fAcq);
            obj.listeners{end+1} = addlistener(obj.hSI.hUserFunctions ,'acqAbort', @obj.fAcq);
            obj.listeners{end+1} = addlistener(obj.hSI.hUserFunctions ,'sliceDone', @obj.fAcq);
            obj.listeners{end+1} = addlistener(obj.hSI.hUserFunctions ,'focusStart', @obj.fAcq);
            obj.listeners{end+1} = addlistener(obj.hSI.hUserFunctions ,'focusDone', @obj.fAcq);
            obj.listeners{end+1} = addlistener(obj.hSI.hUserFunctions ,'frameAcquired', @obj.fAcq);
            obj.listeners{end+1} = addlistener(obj.hSI.hUserFunctions ,'overvoltage', @obj.fAcq);
            % obj.listeners{n}  % More listeners can be added here. 
        end % close constructor


        function delete(obj)
            %Detach from the listeners (they won't be cleaned up unless they are explicitly deleted)
            cellfun(@delete,obj.listeners)
        end % close destructor


        function fAcq(obj,~,evnt)
            % Print even name and time to screen
            fprintf('%s - %s\n', datestr(now), evnt.EventName) 
        end % fAcq

    end % close methods block

end % close classdef
