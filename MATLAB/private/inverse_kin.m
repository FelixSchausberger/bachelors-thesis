
% --------------------------------------------------
% Filename:     inverse_kin.m
% Features:     Calculate inverse kinematics of 3 DOF DELTA kinematic.
% Requirements: MATLAB 2013b or higher
% Author:       Felix Schausberger
% Date:         MAY 2019
% --------------------------------------------------

function [theta11, theta12, theta13, fl] = inverse_kin(X, Y, Z)

    x0 = X;
    y0 = Y;
    z0 = Z;
    theta11 = inverse_kin_theta(x0,y0,z0);
    %.......................................................
    x0 = X*cos(2*pi/3) - Y*sin(2*pi/3);
    y0 = X*sin(2*pi/3) + Y*cos(2*pi/3);
    z0 = Z;
    theta12 = inverse_kin_theta(x0,y0,z0);
    %.......................................................
    x0 = X*cos(4*pi/3) - Y*sin(4*pi/3);
    y0 = X*sin(4*pi/3) + Y*cos(4*pi/3);
    z0 = Z;
    theta13 = inverse_kin_theta(x0,y0,z0);
    %.......................................................
    if (~isnan(theta11) && ~isnan(theta12) && ~isnan(theta13))
        fl = 0;
    else
        fl = -1; % non-existing
    end
    
    
function [theta] = inverse_kin_theta(x0, y0, z0)    
    
    % --- Dimensions --- % 
    R = 70.05; % [mm]
    r = 44.06;
    b = 332;
    a = 140;

    % --- Inverse Kinematics --- %

    Fi = -R;
    Ei = y0-r; % shift center to edge
    
    e = (x0^2 + Ei^2 + z0^2 + a^2 - b^2 - Fi^2)/(2*z0);
    f = (Fi-Ei)/z0;
    
    D = -(e + f*Fi)^2 + a^2*(f^2+1); % discriminant
    if D < 0 
        theta = nan; % non-existing     
    else  
        yBi = (Fi - e*f - sqrt(D)) / (f^2 + 1); 
        zBi = e + f*yBi;
        theta = atan(-zBi/(Fi-yBi));
        if (yBi>Fi)
            theta = theta + pi;
        end
%       theta = rad2deg(theta);
    end
