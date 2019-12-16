function coordinate_change=get_coordinate_change(d1,d2,r,angle,o,a,b,tangent_x,tangent_y)%������Բ�ĺ����ߵ�Ķ�ά����ת��Ϊ��ά���ꣻ
%oΪ��һ���ߵ���ά���꣬aΪ��ǰ���У�������ά���꣬bΪ��һ���У������ά���꣬[tangent_x,tangent_y]Ϊ��ǰ��ǰ���У��������һ���У����֮������ߵ�Ķ�ά����

coordinate_change=[];

%����ά��ͶӰ����άƽ��
o_t=[-d1 0 0]';
a_t=[0 0 0]';
b_t=[d2*cos(angle) d2*sin(angle) 0]';

%������ת��ϵ��
syms p1 p2 p3 p4 p5 p6
 [p1 p2 p3 p4 p5 p6] = solve(p1*o_t(1)+p2*o_t(2)-o(1)+a(1),p3*o_t(1)+p4*o_t(2)-o(2)+a(2),p5*o_t(1)+p6*o_t(2)-o(3)+a(3),p1*a_t(1)+p2*a_t(2)-a(1)+a(1),p3*a_t(1)+p4*a_t(2)-a(2)+a(2),p5*a_t(1)+p6*a_t(2)-a(3)+a(3),p1*b_t(1)+p2*b_t(2)-b(1)+a(1),p3*b_t(1)+p4*b_t(2)-b(2)+a(2),p5*b_t(1)+p6*b_t(2)-b(3)+a(3));

%��ȡ���ߵ����ά����,���ߵ�Ķ�ά����Ϊ��tangent_x��tangent_y��
coordinate_change(end+1)=p1*tangent_x+p2*tangent_y+a(1);
coordinate_change(end+1)=p3*tangent_x+p4*tangent_y+a(2);
coordinate_change(end+1)=p5*tangent_x+p6*tangent_y+a(3);

%��ȡԲ�ĵ���ά�������꣬������滭Բ����Բ�ĵĶ�ά����Ϊ��0��r��
coordinate_change(end+1)=p2*r+a(1);
coordinate_change(end+1)=p4*r+a(2);
coordinate_change(end+1)=p6*r+a(3);




