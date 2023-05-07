
% --------------------------------------------------
% Filename:     traj_joi.m
% Features:     Generate a blocking trajectory with automatic waypoint timing.
% Requirements: MATLAB 2013b or higher
% Author:       Felix Schausberger
% Date:         MAR 2019
% --------------------------------------------------

clc;
clear *;
close all;

[ group, kin ] = setup();
waypoints = read_file();

plot_traj = 1; % Plot trajectory

[ trajectory, trajGen ] = traj_joi( kin, waypoints, plot_traj );

% blocking trajectory
traj_exe_blocking( group, trajectory, trajGen );

% non blocking trajectory
% traj_exe_non_blocking( group, trajectory );