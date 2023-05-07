
% --------------------------------------------------
% Filename:     traj_cubic_spline.m
% Features:     Generate a (non) blocking linear trajectory with automatic waypoint timing.
% Requirements: MATLAB 2013b or higher
% Author:       Felix Schausberger
% Date:         MAR 2019
% --------------------------------------------------

function [ trajectory, trajGen ] = traj_cubic_spline( kin, waypoints, plot_traj, plot_inter )

    x = table2array( waypoints(:, 2) );       
    y = table2array( waypoints(:, 3) );
    z = table2array( waypoints(:, 4) );
    
    for n = 1:length(z)-1
        if z(n) > 280
            warning('Warning. Z value too high. Set to default value (-260).')
        	z(n) = -260;
        end
    end
    
    % time
    t = 0:1:(size(waypoints, 1)-1);
    % interpolation
    tq = 0:0.03:(size(waypoints, 1)-1); 
    
    slope0 = 0;
    slopeF = 0;
    xq = spline( t, [slope0; x; slopeF], tq );
    yq = spline( t, [slope0; y; slopeF], tq );
    zq = spline( t, [slope0; z; slopeF], tq );
    
    if plot_inter
        plot3( x, y, z, 'o', xq, yq, zq, ':.' );
        title('cubic spline data interpolation');
        axis( [-300 300 -300 300 -280 -200] );
        xlabel('X')
        ylabel('Y')
        zlabel('Z')
        grid on
        drawnow;
    end
    
    %% Trajectory
    trajGen = HebiTrajectoryGenerator(kin);
    trajGen.setAlgorithm('UnconstrainedQp'); % MinJerk trajectories
    
%     trajGen.setMinDuration(0.1);  
    trajGen.setSpeedFactor(0.3);
    
    % Create trajectory       
    for i = 1:length(xq)
        [ theta(i, 1), theta(i, 2), theta(i, 3), f1(i) ] = inverse_kin( xq(i), yq(i), zq(i) );

        if f1(i) == -1
            error( ['Error. Position [ ', num2str(xq(i)),' ' num2str(yq(i)),' ' num2str(zq(i)), ' ] not attainable.'] )  
        end
    end
    trajectory = trajGen.newJointMove(theta);
    
    if plot_traj
        % Visualize points along the trajectory
        HebiUtils.plotTrajectory(trajectory);
        drawnow;
    end