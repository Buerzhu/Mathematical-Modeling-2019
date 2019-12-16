function judge=if_trajectory_right(points,distances,point_ran_array)%判断该路径是否满足硬约束条件，适用于问题1
%   1   2 3 4  5     6        
%[index x y z type extra]

%数据1指标
%a1=25;a2=15;b1=20;b2=25;c=30;unit=0.001
%

 %数据2指标
a1=20;a2=10;b1=15;b2=20;c=20;unit=0.001;


error=0;
judge=1;
point_ran_size=size(point_ran_array,2);
 for i=1:point_ran_size-2
     point_index=point_ran_array(i);
     point_index_next=point_ran_array(i+1);
     point_type=points(point_index,5);
     point_type_next=points(point_index_next,5);
     error_increase=distances(point_index,point_index_next)*unit;
     if point_type==1
         error_v=error_increase;
         error_l=error_increase+error;
     else
         error_v=error_increase+error;
         error_l=error_increase;
     end
     if point_type_next==1 && (error_v>a1 || error_l>a2)
         judge=0;
         return;
     end
     if  point_type_next==0 && (error_v>b1 || error_l>b2)
         judge=0;
         return;
     end
     if point_type_next==1
         error=error_l
     else
         error=error_v
     end
 end
 error_increase=distances(point_ran_array(end-1),point_ran_array(end))*unit;
 point_type=points(point_ran_array(end-1),5);
 if point_type==1
     error_v=error_increase;
     error_l=error_increase+error;
 else
     error_v=error_increase+error;
     error_l=error_increase;
 end
 if error_v>=c || error_l>=c
     judge=0;
 end