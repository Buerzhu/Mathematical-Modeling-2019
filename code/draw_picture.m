load('points.mat')%ע����ص�����1�ľ������������2�ľ������
%[index x y z type extra]

array=[1   164   115    9    310   306   124   46   161   93   94 62 293  327];%�˴���·�������������Ҫһһ��Ӧ
point=points(array,2:4);
x=points(array,2);
y=points(array,3);
z=points(array,4);

plot3(x,y,z)
hold on 
plot3(x(1),y(1),z(1),'yo')
hold on 
plot3(x(end),y(end),z(end),'ro')
xlabel('x');
ylabel('y');
zlabel('z');
grid on