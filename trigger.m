function [ output_args ] = trigger(  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
fname = 'trigger.txt';
fid = fopen(fname, 'r');
A = fscanf(fid, '%d');
fclose(fid);
while ~isempty(A) && A(1) == 0
    A(1)
    fname = 'trigger.txt';
    fid = fopen(fname, 'r');
    A = fscanf(fid, '%d');
    fclose(fid);
end
end

