
% --------------------------------------------------
% Filename:     traj_exe_blocking.m
% Features:     Executes a blocking trajectory with automatic waypoint timing.
% Requirements: MATLAB 2013b or higher
% Author:       Felix Schausberger
% Date:         MAR 2019
% --------------------------------------------------

function traj_exe_blocking( group, trajectory, trajGen )

    % This function executes the trajectory using the 'blocking' API. 
    trajGen.executeTrajectory( group, trajectory );
    
    