function [x_t ,y_t, length]=get_tangent_info(d,r,angle,type)%angle�Ի����Ʊ�ʾ,type=1��ʾ��ǣ�-1Ϊ�۽ǣ��ó����ȡ��ά���е������
% d�ǵ�ǰ���У����A����һ���У����B�ľ��룬rΪ��Сѡ��뾶��angleΪ����CA������AB֮��ļнǣ�C����һ���е�
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
if type==1%���
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
else%�۽�
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

