load('points.mat')%注意加载的数据1的距离矩阵还是数据2的距离矩阵
%[index x y z type extra]

array=[1   164   115    9    310   306   124   46   161   93   94 62 293  327];%此处的路径跟上面的数据要一一对应
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