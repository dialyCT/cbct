function [distance_array] =compute_distance(source_x,source_y,pad_x,pad_y)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
distance_array=sqrt((pad_x-source_x).^2+(pad_y-source_y).^2);
end

