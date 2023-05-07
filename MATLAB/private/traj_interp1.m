
% --------------------------------------------------
% Filename:     traj_interp1.m
% Features:     Generate a (non) blocking linear trajectory with automatic waypoint timing.
% Requirements: MATLAB 2013b or higher
% Author:       Felix Schausberger
% Date:         MAR 2019
% --------------------------------------------------

function [ trajectory, trajGen ] = traj_interp1( kin, waypoints, plot_traj, plot_inter )

    x = table2array( waypoints(:, 2) );       
    y = table2array( waypoints(:, 3) );
    z = table2array( waypoints(:, 4) );
    
    for n = 1:length(z)-1
        if z(n) > 280
            warning('Warning. Z value too high. Set to default value (-260).')
        	z(n) = -260;
        end
    end
    
    %% Trajectory
    trajGen = HebiTrajectoryGenerator(kin);
    trajGen.setAlgorithm('UnconstrainedQp'); % MinJerk trajectories
    
    trajGen.setMinDuration(1.0);  
    trajGen.setSpeedFactor(0.5);

    xs = interp1( 1:length(x), x, linspace(1, length(x), 100) );
    ys = interp1( 1:length(x), y, linspace(1, length(y), 100) );
    zs = interp1( 1:length(z), z, linspace(1, length(z), 100) );
        
    if plot_inter
        plot3( x, y, z, 'o', xs, ys, zs, ':.' );
        title('1-D data interpolation');
        axis( [-300 300 -300 300 -280 -200] );
        xlabel('X')
        ylabel('Y')
        zlabel('Z')
        grid on
        drawnow;
    end
    
    % Create trajectory       
    for i = 1:length(xs)
        [ theta(i, 1), theta(i, 2), theta(i, 3), f1(i) ] = inverse_kin( xs(i), ys(i), zs(i) );

        if f1(i) == -1
            error( ['Error. Position [ ', num2str(xs(i)),' ' num2str(ys(i)),' ' num2str(zs(i)), ' ] not attainable.'] ) 
        end
    end
    trajectory = trajGen.newJointMove(theta);
    
    if plot_traj
        % Visualize points along the trajectory
        HebiUtils.plotTrajectory(trajectory);
        drawnow;
    end