clc
clear
format long g
%[index x y z type extra]

%points=xlsread('data_1.xlsx','A3:F615');%加载数据1
%a1=25;a2=15;b1=20;b2=25;c=30;unit=0.001;%数据1相关参数

points=xlsread('data_2.xlsx','A3:F329');%加载数据2
a1=20;a2=10;b1=15;b2=20;c=20;unit=0.001;%数据2相关参数

points(:,1)=points(:,1)+1;%从1开始索引


point_size=size(points,1);
distances=get_distance_matrix(points);%获取距离矩阵，大小为point_size*point_size


ant_num=25;%蚂蚁数量
vol=0.1;%信息素挥发因子
Q=10;%一只蚂蚁的信息素浓度
point_ran_num_max=50;

densitys=ones(point_size,point_size);
length_sum_smallest=10^10;
point_num_smallest=10^10;
length_sum_smallest_array=[];
point_num_smallest_array=[];


iteration_size=400;%迭代次数
alpha=1;%alpha是信息素浓度因子，alpha越大选择以往经过次数多的点可能性越大；beta是启发函数因子，beta越大选择离目标点最近的点可能性越大
beta=3;

for i=1:iteration_size
    point_ant_ran_array=zeros(ant_num,point_ran_num_max);
    for j=1:ant_num
        point_index=1;%在这里输入初始路径点
        point_ran_array=[];
        point_unavailable_array=[];
        error_cumulative_array=[];
        point_ran_num=1;
        point_ran_array(end+1)=point_index;
        point_unavailable_array(end+1)=point_index;
        error_cumulative_array(end+1)=0;%在这里输入初始误差
        error_cumulative=0;
        while point_index~=point_size && point_ran_num<point_ran_num_max &&point_ran_num>0
            [point_index,error_cumulative]=get_next_point(point_index,error_cumulative,point_unavailable_array,points,distances,densitys,alpha,beta);
            if point_index~=-1%如果通过当前点能获得满足硬约束的下一点
                point_ran_array(end+1)=point_index;%满足硬约束的下一点成为当前点
                point_ran_num=point_ran_num+1;
                point_unavailable_array(end+1)=point_index;
                error_cumulative_array(end+1)=error_cumulative;
            else%如果不存在满足约束的下一点，回退到上一步,选择其他点作为当前点
                point_ran_array(end)=[];%将当前点从路径表中清空
                error_cumulative_array(end)=[];
                point_ran_num=point_ran_num-1;
                point_index=point_ran_array(end);%把上一点作为当前点，由于原先的点已经被添加到禁忌搜索路径表，所以避免了同样的情况再次出现
                error_cumulative=error_cumulative_array(end);
            end
        end
        [length_sum,point_num]=get_result(point_ran_array,distances)
        point_ant_ran_array(j,1:point_num)=point_ran_array;%将蚂蚁路径添加到蚁群路径中去
        if length_sum<length_sum_smallest
            length_sum_smallest_array=point_ran_array;
            length_sum_smallest=length_sum;
            alpha_copy=alpha;
            beta_copy=beta;
        end
        if point_num<point_num_smallest
            point_num_smallest_array=point_ran_array;
            point_num_smallest=point_num;
        end
    end
    densitys=get_density_new(point_ant_ran_array,densitys,Q,vol,distances);
end


length_sum_smallest_array
[length_sum,point_num]=get_result(length_sum_smallest_array,distances)
% test_d=unique(densitys)
