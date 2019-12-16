function [x_t ,y_t, length]=get_tangent_info(d,r,angle,type)%angle以弧度制表示,type=1表示锐角，-1为钝角，该程序获取二维面切点的坐标
% d是当前误差校正点A与下一误差校正点B的距离，r为最小选择半径，angle为向量CA与向量AB之间的夹角，C是上一个切点
a=[0 0];
b=[d*cos(angle) d*sin(angle)];
o=[0 r];
oa=a-o;
ob=b-o;
oa_l=sqrt(sum(oa.^2));
ob_l=sqrt(sum(ob.^2));
angle_aob=acos(sum(oa.*ob)/(oa_l*ob_l));
angle_boc=acos(r/ob_l);
x_t=0;
y_t=0;
if type==1%锐角
    angle_aoc=angle_aob-angle_boc;
    if b(1)>r
        angle_cod=angle_aoc;
        x_t=r*sin(angle_cod);
        y_t=r-r*cos(angle_cod);
    else
        angle_cod=pi-angle_aoc;
        x_t=r*sin(angle_cod);
        y_t=r+r*cos(angle_cod);
    end
else%钝角
    angle_aoc=2*pi-(angle_aob+angle_boc);
    if b(1)<-r
        angle_cod=angle_aoc-pi;
        x_t=-r*sin(angle_cod);
        y_t=r+r*cos(angle_cod);
    else
        angle_cod=pi-angle_aoc;
        x_t=r*sin(angle_cod);
        y_t=r+r*cos(angle_cod);
    end
end
c=[x_t y_t];
cb=b-c;
cb_l=sqrt(sum(cb.^2));
length=angle_aoc*r+cb_l;

