%获取路径点之间的距离矩阵
function distances=get_distance_matrix(points)

point_size=size(points,1)
distances=ones(point_size)*10^10;%这一步是为了让distances(i,i)=10^10

for i=1:point_size-1
    point_a=points(i,:);
    for j=i+1:point_size
        point_b=points(j,:);
        distance=get_point_distance(point_a,point_b);
        distances(i,j)=distance;
        distances(j,i)=distance;
    end
end

