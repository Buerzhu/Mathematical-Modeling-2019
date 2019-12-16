%问题2的输出，输出路径总长，切线点三维坐标，最小转弯半径圆心坐标

% %数据1
% points=xlsread('data_1.xlsx','A3:F615');
% a1=25;a2=15;b1=20;b2=25;c=30;unit=0.001;
% %

%数据2
points=xlsread('data_2.xlsx','A3:F329');
a1=20;a2=10;b1=15;b2=20;c=20;unit=0.001;
%
points(:,1)=points(:,1)+1;%从1开始索引


point_size=size(points,1);
distances=get_distance_matrix(points);%获取距离矩阵，大小为point_size*point_size
save('points.mat','points')
save('distances.mat','distances')


%填入想输出的路径点
array=[1   164   115    9    310   306   124   46   161   93   94 62 293  327];

[length_sum,point_num]=get_result(array,distances);
original_length_sum=length_sum;
r=200;
point_size=size(array,2);

original_dis_array=[];
for i=1:point_size-1
    original_dis_array(end+1)=distances(array(i),array(i+1));
end

tanget_array=zeros(point_size-1,3);
circle_array=zeros(point_size-2,3);
tanget_array(1,1:3)=points(1,2:4);
dis_array=[];
dis_array(end+1)=distances(array(1),array(2))
for i=2:point_size-1
    point_index=array(i);
    point_index_next=array(i+1);
    point_tangent_coordinate=tanget_array(i-1,1:3);
    
    point_index_next_coordinate=points(point_index_next,2:4);
    point_index_coordinate=points(point_index,2:4);
    d=distances(point_index,point_index_next);
    oa=point_index_coordinate-point_tangent_coordinate;
    ab=point_index_next_coordinate-point_index_coordinate;
    oa_l=sqrt((point_index_coordinate(1)-point_tangent_coordinate(1))^2+(point_index_coordinate(2)-point_tangent_coordinate(2))^2+(point_index_coordinate(3)-point_tangent_coordinate(3))^2);
    ab_l=d;
    temp=sum(oa.*ab);
    angle=acos((temp/(oa_l*ab_l)));
    type=1;
    if temp>0
        type=1;
    else
        type=-1;
    end
    r=200;
    [tangent_x tangent_y length]=get_tangent_info(d,r,angle,type);
    coordinate_change=get_coordinate_change(oa_l,ab_l,r,angle,point_tangent_coordinate,point_index_coordinate,point_index_next_coordinate,tangent_x,tangent_y);
    point_tangent_coordinate_next=coordinate_change(1:3);
    point_circle_coordinate=coordinate_change(4:6);
    distance_ant_ran=length;
    tanget_array(i,1:3)=point_tangent_coordinate_next;
    circle_array(i-1,1:3)= point_circle_coordinate;
    dis_array(end+1)=distance_ant_ran;
end
format long g



results=get_final_result(points,dis_array,array)%输出各点对应的水平和垂直误差
length_sum=sum(dis_array)%输出路径总长度
circle_array%输出圆心坐标
tanget_array%输出切点点坐标


