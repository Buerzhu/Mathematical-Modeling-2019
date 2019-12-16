%��������һ��·����
function [point_index_next,error_cumulative_next]=get_next_point(point_index,error_cumulative,point_unavailable_array,points,distances,densitys,alpha,beta)

%   1   2 3 4  5     6        
%[index x y z type extra]
%a1=25;a2=15;b1=20;b2=25;c=30;unit=0.001;%����1��ز���
a1=20;a2=10;b1=15;b2=20;c=20;unit=0.001;%����2��ز���
param=0.02;%ģ���˻�ϵ������ϵ��Խ����һ��ѡ���෴���͵ĵ������Խ��

point_size=size(points,1);
points(:,end+1)=0;%���ӵ����У��洢�ִ�õ�ǰһ���ۼƵĴ�ֱ���
points(:,end+1)=0;%���ӵڰ��У��洢�ִ�õ�ǰһ���ۼƵ�ˮƽ���
point_vertical_index=(find(points(:,5)==1))';
point_level_index=(find(points(:,5)==0))';

point_type=points(point_index,5);

distance_to_point=distances(point_index,:);
errors=distance_to_point*unit;

if point_type==1
    points(:,7)=errors';
    points(:,8)=errors'+error_cumulative;
else
    points(:,7)=errors'+error_cumulative;
    points(:,8)=errors';
end
index_0=(intersect(find(points(:,7)<c),find(points(:,8)<c)))';%ת��Ϊ������
index_1_a=find(points(point_vertical_index,7)<=a1);
index_1_b=find(points(point_vertical_index,8)<=a2);
index_2_a=find(points(point_level_index,7)<=b1);
index_2_b=find(points(point_level_index,8)<=b2);
index_1=intersect(point_vertical_index(index_1_a),point_vertical_index(index_1_b));%�󽻼�
index_2=intersect(point_level_index(index_2_a),point_level_index(index_2_b));%�󽻼�

index_3=(union(index_1,index_2));%������
index_available=get_index_available(point_index,index_3,point_unavailable_array);%���õ������ļ���,������
if size(find(index_0==point_size),2)~=0
    point_index_next=point_size;
    error_cumulative_next=0;
else
    index_size=size(index_available,2);
    if index_size==0
        point_index_next=-1;
        error_cumulative_next=-1;
    else
         density_array=[];
        inspire_array=[];
        for i=1:index_size
            inspire_array(end+1)=1/distances(index_available(i),point_size);
            density_array(end+1)=densitys(point_index,index_available(i));
        end
         if point_type==0
             index_vertical=find(points(index_available,5)==1);
             inspire_array(index_vertical)=inspire_array(index_vertical)*exp(param*error_cumulative);%ģ���˻�������ѡ���뵱ǰ���෴��У������Ϊ��һ��
         else
             index_level=find(points(index_available,5)==0);
             inspire_array(index_level)=inspire_array(index_level)*exp(param*error_cumulative);
         end
         
        [inspire_array,temp]=mapminmax(inspire_array);%��������Ƿ��������ж��Ƿ�Ҫ���й�һ��
        [density_array,temp]=mapminmax(density_array);
        inspire_array=inspire_array+2.1;
        density_array=density_array+2.1;%��һ���ǹ�һ������
        expectation_array=[];
        expectation_sum=sum((inspire_array.^beta).*(density_array.^alpha));
        temp_sum=0;
        for i=1:index_size
            temp=(density_array(i)^alpha*inspire_array(i)^beta)/expectation_sum;
            temp_sum=temp_sum+temp;
            expectation_array(end+1)=temp_sum;
        end
        index_final=find(expectation_array>rand);
        point_index_next=index_available(index_final(1));
        point_type_next=points(point_index_next,5);
        if point_type_next==0
            error_cumulative_next=points(point_index_next,7);
        else
            error_cumulative_next=points(point_index_next,8);
        end
    end
end
