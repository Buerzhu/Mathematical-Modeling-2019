%������ӲԼ��������������һ����·����ļ���
function index_available=get_index_available(point_index,index_3,point_unavailable_array)

% point_unavailable_array=[1 4]
% index_3=[1 3 4 5 7]

index_unavailable=[];
index_size=size(index_3,2);

index_available=[];
for i=1:index_size
    temp=find(point_unavailable_array==index_3(i));%�жϵ�ʱ��Ҫ�ر�ע����������������
    if size(temp,2)~=0
        index_unavailable(end+1)=i;
    end
end
index_3(index_unavailable)=[];
index_available=index_3;
