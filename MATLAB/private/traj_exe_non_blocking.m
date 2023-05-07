
% --------------------------------------------------
% Filename:     traj_exe_non_blocking.m
% Features:     Executes a non blocking trajectory with automatic waypoint timing.
% Requirements: MATLAB 2013b or higher
% Author:       Felix Schausberger
% Date:         MAR 2019
% --------------------------------------------------

function traj_exe_non_blocking( group, trajectory )

    % Execute trajectory open-loop in position and velocity
    cmd = CommandStruct();
    t0 = tic();
    t = toc(t0);
    while t < trajectory.getDuration()

        t = toc(t0);
        fbk = group.getNextFeedback();  % limits loop rate
        % Get target state at current point in time
        [cmd.position, cmd.velocity, ~] = trajectory.getState(t);
        
        pause(.01); % Use pause to limit loop rate

        group.send(cmd);
    end
    
    