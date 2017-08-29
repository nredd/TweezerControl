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
        
        % .NET assembly created from Basler Camera driver files
        NETAssembly
        
        % Height of image produced by BaslerCamera in pixels
        Height
        
        % Width of image produced by BaslerCamera in pixels
        Width
        
        % X-axis offset of image produced by BaslerCamera in pixels
        OffsetX
        
        % Y-axis offset of image produced by BaslerCamera in pixels
        OffsetY
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
            obj.NETAssembly = NET.addAssembly(dllName);
            
            % Create the CameraHandle
            obj.CameraHandle = Basler.Pylon.Camera();
            
            % Open the camera
            obj.CameraHandle.Open();
            
            % Define camera parameters
            obj.CameraHandle.Parameters.Item(...
                'Height').SetValue(obj.Height);
            obj.CameraHandle.Parameters.Item(...
                'OffsetY').SetValue(obj.OffsetY);
            obj.CameraHandle.Parameters.Item(...
                'Width').SetValue(obj.Width);
            obj.CameraHandle.Parameters.Item(...
                'OffsetX').SetValue(obj.OffsetX);
            
             % temp
            obj.Initialized = false;
            obj.shutdownDevice();
        end
        
        % Setter method for setting obj.Height. Includes error checking
        % based on the actual Basler Ace Camera model (acA3800-14um)
        function set.Height(obj, height)
        end
        
        % Setter method for setting obj.Width. Includes error checking
        % based on the actual Basler Ace Camera model (acA3800-14um)
        function set.Width(obj, width)
        end
        
        % Setter method for setting obj.OffsetX. Includes error checking
        % based on the actual Basler Ace Camera model (acA3800-14um)
        function set.OffsetX(obj, offsetx)
        end
        
        % Setter method for setting obj.OffsetY. Includes error checking
        % based on the actual Basler Ace Camera model (acA3800-14um)
        function set.OffsetY(obj, offsety)
        end
        
        % Get image from BaslerCamera object, given
        function [success, image] = getImage(obj)
            if (obj.CameraHandle.IsOpen)
                timeout=int32(500); % 500
                
                % Initialize acquisition
                obj.CameraHandle.StreamGrabber.Start();
                grabResult=obj.CameraHandle.StreamGrabber.RetrieveResult(...
                    timeout, Basler.Pylon.TimeoutHandling.ThrowException);
                obj.CameraHandle.StreamGrabber.Stop();

                % Convert pixel buffer data to uint8 image
                image=vec2mat(uint8(grabResult.PixelData),3840);
                
                % Return success
                success = true;
            else
                success = false;
                image = [];
                fprintf('Warning: camera not open, no image acquired\n');
            end
        end
        
        % Display device info (inherited from Device class)
        function displayDeviceInfo(obj)
            % Extend inherited displayDeviceInfo() function
            displayDeviceInfo@Device(obj);
        end
        
        % Shutdown device (inherited from Device class)
        function shutdownDevice(obj)
            % Delete BaslerCamera so that we can open it up again
            obj.CameraHandle.Close();
            disp('BaslerCamera stopped')
        end
    end
    
end

