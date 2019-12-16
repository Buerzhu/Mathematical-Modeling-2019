%获取两点之间的距离
function distance=get_point_distance(point_a,point_b)
distance=sqrt((point_a(2)-point_b(2))^2+(point_a(3)-point_b(3))^2+(point_a(4)-point_b(4))^2);