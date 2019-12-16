%针对问题2，路径点输出水平误差与垂直误差
function results=get_final_result(points,distance_array,point_ran_array)
%   1   2 3 4  5     6        
%[index x y z type extra]

%数据1参数
%a1=25;a2=15;b1=20;b2=25;c=30;unit=0.001;
%

%数据2参数
a1=20;a2=10;b1=15;b2=20;c=20;unit=0.001;

judge=1;
error=0;
point_ran_size=size(point_ran_array,2);
results=zeros(point_ran_size,4);
results(1,1:4)=[0 0 0 -1];
 for i=1:point_ran_size-2
     point_index=point_ran_array(i);
     point_index_next=point_ran_array(i+1);
     point_type=points(point_index,5);
     point_type_next=points(point_index_next,5);
     error_increase=distance_array(i)*unit;
     if point_type==1
         error_v=error_increase;
         error_l=error_increase+error;
     else
         error_v=error_increase+error;
         error_l=error_increase;
     end
     if point_type_next==1 && (error_v>a1 || error_l>a2)
         judge=0;
     end
     if  point_type_next==0 && (error_v>b1 || error_l>b2)
         judge=0;
     end
     if point_type_next==1
         error=error_l;
         results(i+1,1:4)=[point_index_next-1 error_v error_l 11];
     else
         results(i+1,1:4)=[point_index_next-1 error_v error_l 1];
         error=error_v;
     end
 end
 error_increase=distance_array(end)*unit;
 point_type=points(point_ran_array(end-1),5);
 if point_type==1
     error_v=error_increase;
     error_l=error_increase+error;
 else
     error_v=error_increase+error;
     error_l=error_increase;
 end
 results(point_ran_size,1:4)=[point_ran_array(end)-1 error_v error_l -2];
 if error_v>=c || error_l>=c
     judge=0;
 end