
% --------------------------------------------------
% Filename:     read_file.m
% Features:     Read Excel (*.xlsx) file to provide waypoints.
% Requirements: MATLAB 2013b or higher
% Author:       Felix Schausberger
% Date:         MAY 2019
% --------------------------------------------------

function [waypoints] = read_file
    fname = 'waypoints.xlsx';
    fpath = 'C:\Users\fscha\Documents\FHTW\BMR6_SS19\Bachelorarbeit\MATLAB\';

    if exist(fullfile(fpath, fname), 'file') == 2
        waypoints = readtable(fullfile(fpath, fname), 'ReadVariableNames', false);
    else
        [fname, fpath] = uigetfile('*.xlsx');
        if isequal(fname,0)               
           msgbox('Please provide a valid Excel (*.xlsx) file')
        else
           waypoints = readtable(fullfile(fpath, fname), 'ReadVariableNames', false);
        end
    end