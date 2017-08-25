classdef (Abstract) Device < handle & matlab.mixin.Heterogeneous
    %DEVICE Summary of this class goes here
    %   Parent class representing Device object. All devices used by
    %   the TweezerControl program are Devices and thus must descend from
    %   the Device class. Note that the Device class shouldn't be
    %   explicitly instantiated--just it's descendants--as it is an
    %   Abstract class. We inherit also from matlab.mixin.Heterogeneous to
    %   allow for us to create heterogenous arrays of different objects
    
    properties 
        % Boolean value representing if device was discovered 
        Discovered
        
        % Boolean value representing if device was initialized 
        Initialized
        
        % Index of device object--each device of a specific type must have
        % a unique index!
        Index
        
        % Enumeration object representing type of device (Enumeration class
        % defined as DeviceType.m)
        Type
    end
    
    methods
        % Setter for index property of device. Includes error checking for 
        % input argument 
        function setIndex(obj, index)
            if (isnumeric(index) && index >= 0)
                obj.Index = uint16(index);
            else 
                fprintf(['Error: expected nonnegative integer variable'...
                    'for index. No device of type %s was created.\n' ...
                    'Received:'], obj.Type)
                disp(index)
                return;
            end 
        end
        
        % Method for displaying the respective device's
        % information--note that each subclass of Device should
        % individually extend this method such that each device can add its
        % own relevant device information
        function displayDeviceInfo(obj)
            fprintf('Type: %s\n', obj.Type)
            fprintf('Index: %d\n', obj.Index)
            fprintf('Discovered: %d\n', obj.Discovered)
            fprintf('Initialized: %d\n', obj.Initialized)
            fprintf('\n')
        end
        
    end
    methods (Abstract)
        % Abstract method for shutting down the device object; should
        % include any logic or code required to shutdown the device via
        % software (i.e., releasing/deleting the handle and any claimed
        % system resources) such that if necessary, the device may be
        % recreated or reinitialized without error in the future
        shutdownDevice(obj)
        
    end
end

