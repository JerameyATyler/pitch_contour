function [ t ] = appendTime( oldT, newT )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

if isempty(oldT) 
    t = newT;
else
    tmpT = newT + oldT(end);
    t = [oldT, tmpT];
end

