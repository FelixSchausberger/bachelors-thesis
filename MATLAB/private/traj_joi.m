
% --------------------------------------------------
% Filename:     traj_joi.m
% Features:     Generate a blocking trajectory with automatic waypoint timing.
% Requirements: MATLAB 2013b or higher
% Author:       Felix Schausberger
% Date:         MAR 2019
% --------------------------------------------------

function [ trajectory, trajGen ] = traj_joi( kin, waypoints, plot_traj )

    x = table2array( waypoints(:, 2) );       
    y = table2array( waypoints(:, 3) );
    z = table2array( waypoints(:, 4) );

    %% Trajectory
    trajGen = HebiTrajectoryGenerator(kin);
    trajGen.setAlgorithm('UnconstrainedQp'); % MinJerk trajectories
    
    trajGen.setMinDuration(1.0);  
    trajGen.setSpeedFactor(0.5);

    % Create trajectory       
    for i = 1:size(waypoints, 1)

        [ theta(i, 1), theta(i, 2), theta(i, 3), f1(i) ] = inverse_kin( x(i), y(i), z(i) );

        if f1(1) == -1
            error('Error. \nPosition not attainable.')
        end
    end
    trajectory = trajGen.newJointMove(theta);
    
    if plot_traj
        % Visualize points along the trajectory
        HebiUtils.plotTrajectory(trajectory);
        drawnow;
    end