classdef basicListenerDemo < handle
    % Reports actions taking place within ScanImage to the command line
    %
    % Instructions
    % * Start ScanImage 
    % * Start an instance of this class: L = basicListenerDemo;
    % * Press Focus then Abort. Note messages at command line.
    % * To clean up run: delete(L)
    %
    % 
    % Rob Campbell - 2017


    properties
        hSI % The ScanImage API
        listeners={}
    end % close properties block


    methods

        function obj = basicListenerDemo
            % Pull in ScanImage API handle
            scanimageObjectName='hSI';
            W = evalin('base','whos');
            if ~ismember(scanimageObjectName,{W.name})
                fprintf('Can not find ScanImage API handle in base workspace. Please start ScanImage\n')
                obj.delete
                return
            end

            obj.hSI = evalin('base',scanimageObjectName); % get hSI from the base workspace

            %Add a listener to the observable property "acqState" of the hSI object. 
            obj.listeners{1} = addlistener(obj.hSI, 'acqState', 'PostSet', @obj.isAcquiring);
            % obj.listeners{n}  % More listeners can be added here. 
        end % close constructor


        function delete(obj)
            %Detach from the listeners (they won't be cleaned up unless they are explicitly deleted)
            cellfun(@delete,obj.listeners)
        end % close destructor


        function isAcquiring(obj,~,~)
            % Callback function that runs when the ScanImage acquisition state changes
            fprintf('Current acquisition state is: %s\n', obj.hSI.acqState)
        end % close isAcquiring

    end % close methods block

end % close classdef
