classdef basicListenerDemo < handle
    % Reports actions taking place within ScanImage 
    %
    % Instructions
    % * Start ScanImage 
    % * Start an instance of this class
    % * Press Focus


    properties
        hSI % The ScanImage API
        listeners
    end % close properties block


    methods
        function obj = basicListenerDemo
            % Pull in ScanImage API handle
            scanimageObjectName='hSI';
            W = evalin('base','whos');
            if ~ismember(scanimageObjectName,{W.name});
                fprintf('Can not find ScanImage API handle in base workspace. Please start ScanImage\n')
                obj.delete
                return
            end

            obj.hSI = evalin('base',scanimageObjectName); % get hSI from the base workspace


            %Add some listeners
            obj.listeners{1} = addlistener(obj.hC, 'active', 'PostSet', @obj.isAcquiring);
            % obj.listeners{n}  % More listeners can be added here. 
        end


        function delete
            %Detach from the listeners (they won't be cleaned up unless they are explicitly deleted)
            cellfun(@delete,obj.listeners)
        end


        function isAcquiring(obj,~,~)
            % Callback function that runs when the ScanImage acquisition state changes
            if obj.hSI.active == true
                fprintf('ScanImage started is acquiring frames\n')
            else
                fprintf('ScanImage stopped acquiring frames\n')
            end
        end %isAcquiring


    end %close methods block

end % close classdef
