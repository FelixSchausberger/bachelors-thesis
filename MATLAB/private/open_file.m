
% --------------------------------------------------
% Filename:     open_file.m
% Features:     Open Excel (*.xlsx) file to show waypoints.
% Requirements: MATLAB 2013b or higher
% Author:       Felix Schausberger
% Date:         MAY 2019
% --------------------------------------------------

function open_file
    fname = 'waypoints.xlsx';
    fpath = 'C:\Users\fscha\Documents\FHTW\BMR6_SS19\Bachelorarbeit\MATLAB\';

    if exist(fullfile(fpath, fname), 'file') == 2
        winopen(fullfile(fpath, fname))
    else
        [fname, fpath] = uigetfile('*.xlsx');
        if isequal(fname,0)               
           msgbox('Please provide a valid Excel (*.xlsx) file')
        else
           winopen(fullfile(fpath, fname))
        end
    end