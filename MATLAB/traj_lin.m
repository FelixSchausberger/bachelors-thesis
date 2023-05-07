
% --------------------------------------------------
% Filename:     traj_lin.m
% Features:     Generate a (non) blocking linear trajectory with automatic waypoint timing.
% Requirements: MATLAB 2013b or higher
% Author:       Felix Schausberger
% Date:         MAR 2019
% --------------------------------------------------

clc;
clear *;
close all;

[ group, kin ] = setup();
waypoints = read_file();

plot_traj = 1; % Plot trajectory profile
plot_inter = 1; % Plot interpolated trajectory

[ trajectory, trajGen ] = traj_interp1( kin, waypoints, plot_traj, plot_inter );
% [ trajectory, trajGen ] = traj_linspace( kin, waypoints, plot_traj, plot_inter );
% [ trajectory, trajGen ] = traj_cubic_spline( kin, waypoints, plot_traj, plot_inter );

% blocking trajectory
% traj_exe_blocking( group, trajectory, trajGen );

% non blocking trajectory
% traj_exe_non_blocking( group, trajectory );
