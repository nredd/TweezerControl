classdef BaslerCamera < Device
    %BASLERCAMERA Summary of this class goes here
    %   Class representing BaslerCamera object. Any sort of communcation
    %   between the physical Basler Camera installed in the user's
    %   computer environment and the TweezerControl application is done
    %   through the BaslerCamera device object.
    
    properties
        % Set device type using DeviceType enumeration class
        Type = DeviceType.BaslerCamera;
        
        % Handle to Camera object (from MATLAB driver)
        CameraHandle
    end
    
    methods
        % Constructor for BaslerCamera object; attempts to discover and
        %   initialize the first Basler Camera that is discovered by the
        %   program
        %
        % index: index of device of type BaslerCamera; all indices for
        %   devices of a specific type should be unique; start the indexing
        %   at 0 for all devices
        function obj = BaslerCamera(index, verbosity)
            obj = obj@Device(index, verbosity);
            dllName=['Dependencies\Devices\Basler Ace camera'...
                '\Drivers\Basler.Pylon.dll'];
            asm=NET.addAssembly(dllName);
            
             % temp
            obj.Discovered = false;
            obj.Initialized = false;
            
            
        end
        
        function displayDeviceInfo(obj)
            % Extend inherited displayDeviceInfo() function
            displayDeviceInfo@Device(obj);
        end
        
        function shutdownDevice(obj)
            disp('shutting down')
        end
    end
    
end
