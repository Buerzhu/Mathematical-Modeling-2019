%获取路径总长和路径点个数，仅适用于问题1
function [length_sum,point_num]=get_result(point_ran_array,distances)

point_num=size(point_ran_array,2);
length_sum=0;
for i=1:point_num-1
    index_1=point_ran_array(i);
    index_2=point_ran_array(i+1);
    distance=distances(index_1,index_2);
    length_sum=length_sum+distance;
end