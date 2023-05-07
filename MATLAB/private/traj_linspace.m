
% --------------------------------------------------
% Filename:     traj_linspace.m
% Features:     Generate a (non) blocking linear trajectory with automatic waypoint timing.
% Requirements: MATLAB 2013b or higher
% Author:       Felix Schausberger
% Date:         MAR 2019
% --------------------------------------------------

function [ trajectory, trajGen ] = traj_linspace( kin, waypoints, plot_traj, plot_inter )

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
    
    trajGen.setMinDuration(2);  
    trajGen.setSpeedFactor(0.3);
    
    for idx = 1:length(x)-1
        
        if z(idx+1) == z(idx)
            nPnts = sqrt( (x(idx+1) - x(idx))^2 + (y(idx+1) - y(idx))^2 ) * 0.15;
        else
            nPnts = sqrt( (x(idx+1) - x(idx))^2 + (y(idx+1) - y(idx))^2 + (z(idx+1) - z(idx))^2 ) * 0.5;
        end 
        
        xs{idx} = linspace( x(idx), x(idx + 1), nPnts );
        ys{idx} = linspace( y(idx), y(idx + 1), nPnts ); 
        zs{idx} = linspace( z(idx), z(idx + 1), nPnts );
    end
    
    xtmp = [ xs{:} ];
    ytmp = [ ys{:} ];
    ztmp = [ zs{:} ];
    
    if plot_inter
        plot3( x, y, z, 'o', xtmp, ytmp, ztmp, ':.' );
        title('linearly spaced vector');
        axis( [-300 300 -300 300 -280 -200] );
        xlabel('X')
        ylabel('Y')
        zlabel('Z')
        grid on
        drawnow;
    end
    
    % Create trajectory       
    for i = 1:length( [xs{:}] )
            
        [ theta(i, 1), theta(i, 2), theta(i, 3), f1(i) ] = inverse_kin( xtmp(i), ytmp(i), ztmp(i) );
            
        if f1(i) == -1
            error( ['Error. Position [ ', num2str(xtmp(i)),' ' num2str(ytmp(i)),' ' num2str(ztmp(i)), ' ] not attainable.'] ) 
        end
	end
    trajectory = trajGen.newJointMove(theta);
  
    if plot_traj
        % Visualize points along the trajectory
        HebiUtils.plotTrajectory(trajectory);
        drawnow;
    end
    
    