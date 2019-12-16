clc
clear
format long g
%[index x y z type extra]

%points=xlsread('data_1.xlsx','A3:F615');%��������1
%a1=25;a2=15;b1=20;b2=25;c=30;unit=0.001;%����1��ز���

points=xlsread('data_2.xlsx','A3:F329');%��������2
a1=20;a2=10;b1=15;b2=20;c=20;unit=0.001;%����2��ز���

points(:,1)=points(:,1)+1;%��1��ʼ����


point_size=size(points,1);
distances=get_distance_matrix(points);%��ȡ������󣬴�СΪpoint_size*point_size


ant_num=25;%��������
vol=0.1;%��Ϣ�ػӷ�����
Q=10;%һֻ���ϵ���Ϣ��Ũ��
point_ran_num_max=50;

densitys=ones(point_size,point_size);
length_sum_smallest=10^10;
point_num_smallest=10^10;
length_sum_smallest_array=[];
point_num_smallest_array=[];


iteration_size=400;%��������
alpha=1;%alpha����Ϣ��Ũ�����ӣ�alphaԽ��ѡ����������������ĵ������Խ��beta�������������ӣ�betaԽ��ѡ����Ŀ�������ĵ������Խ��
beta=3;

for i=1:iteration_size
    point_ant_ran_array=zeros(ant_num,point_ran_num_max);
    for j=1:ant_num
        point_index=1;%�����������ʼ·����
        point_ran_array=[];
        point_unavailable_array=[];
        error_cumulative_array=[];
        point_ran_num=1;
        point_ran_array(end+1)=point_index;
        point_unavailable_array(end+1)=point_index;
        error_cumulative_array(end+1)=0;%�����������ʼ���
        error_cumulative=0;
        while point_index~=point_size && point_ran_num<point_ran_num_max &&point_ran_num>0
            [point_index,error_cumulative]=get_next_point(point_index,error_cumulative,point_unavailable_array,points,distances,densitys,alpha,beta);
            if point_index~=-1%���ͨ����ǰ���ܻ������ӲԼ������һ��
                point_ran_array(end+1)=point_index;%����ӲԼ������һ���Ϊ��ǰ��
                point_ran_num=point_ran_num+1;
                point_unavailable_array(end+1)=point_index;
                error_cumulative_array(end+1)=error_cumulative;
            else%�������������Լ������һ�㣬���˵���һ��,ѡ����������Ϊ��ǰ��
                point_ran_array(end)=[];%����ǰ���·���������
                error_cumulative_array(end)=[];
                point_ran_num=point_ran_num-1;
                point_index=point_ran_array(end);%����һ����Ϊ��ǰ�㣬����ԭ�ȵĵ��Ѿ�����ӵ���������·�������Ա�����ͬ��������ٴγ���
                error_cumulative=error_cumulative_array(end);
            end
        end
        [length_sum,point_num]=get_result(point_ran_array,distances)
        point_ant_ran_array(j,1:point_num)=point_ran_array;%������·����ӵ���Ⱥ·����ȥ
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
