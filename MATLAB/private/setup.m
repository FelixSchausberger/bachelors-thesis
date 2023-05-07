
% --------------------------------------------------
% Filename:     setup.m
% Features:     Read Excel (*.xlsx) file to provide waypoints.
% Requirements: MATLAB 2013b or higher
% Author:       Felix Schausberger
% Date:         MAY 2019
% --------------------------------------------------

function [group, kin] = setup

    HebiLookup.initialize(); % Just in case something changed on the network

    % Creating group by serial numbers
    serials = {
        'X-00328'
        'X-00348'
        'X-00354' };
    group = HebiLookup.newGroupFromSerialNumbers(serials);

    % Load the kinematics from HRDF file
    fname = 'delta.hrdf';
    fpath = 'C:\Users\fscha\Documents\FHTW\BMR6_SS19\Bachelorarbeit\MATLAB\hdrf';

    if exist(fullfile(fpath, fname), 'file') == 2
            kin = HebiKinematics(fullfile(fpath, fname));
    else
       [fname, fpath] = uigetfile('*.hrdf');
       if isequal(fname,0)               
            msgbox('Please provide a valid HEBI robotics description file (*.hrdf)')
       else
            kin = HebiKinematics(fullfile(fpath, fname));
       end
    end