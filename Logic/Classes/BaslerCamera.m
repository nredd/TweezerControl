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
            % Call Superclass constructor firt to avoid redundancies
            obj = obj@Device(index, verbosity);
            
            % Get driver dll for Basler Camera and create an assembly out
            % of it
            dllName=['C:\Users\Endres Lab\Desktop\TweezerControl\'...
                'Dependencies\Devices\Basler Ace camera'...
                '\Drivers\Basler.Pylon.dll'];
            asm=NET.addAssembly(dllName);
            
            % Create the CameraHandle
            %obj.CameraHandle = Basler.Pylon.Camera();
            
            % Open the camera
            %obj.CameraHandle.Open();
            
             % temp
            obj.Initialized = true;
            
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

