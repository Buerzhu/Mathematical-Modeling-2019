%更新路径的信息素浓度
function densitys=get_density_new(point_ant_ran_array,densitys,Q,vol,distances)

% densitys=ones(613);
% Q=1;
% vol=0.2;


densitys=densitys*(1-vol);
point_size=size(densitys,1);
density_increase=zeros(point_size);
ant_num=size(point_ant_ran_array,1);
for i=1:ant_num
    array=find(point_ant_ran_array(i,:)~=0);
    array=point_ant_ran_array(i,array);
    [length_sum,point_num]=get_result(array,distances)
    unit=Q/length_sum;
    for j=1:point_num-1
        point_index=array(j);
        point_index_next=array(j+1);
        distance=distances(point_index,point_index_next);
        density_increase(point_index,point_index_next)=density_increase(point_index,point_index_next)+distance*unit;
    end
end
densitys=densitys+density_increase+density_increase;