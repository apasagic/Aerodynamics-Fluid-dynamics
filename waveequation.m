figure('units','normalized','outerposition',[0 0 1 1])

x_max = 10;
y_max = 10;

k = 0;
err = 0;
dt = 0.1;
h = 0.1;

T = zeros(x_max/h,y_max/h);

%T(4/h:6/h,4/h:6/h) = 1;
%T(4.8/h:5.2/h,4.8/h:5.2/h) = cos([-2:h:2]*pi/4).*cos([-2:h:2]*pi/4);
%T(5/h,5/h) = 1;

[X,Y] = meshgrid(-1:h:1);
Z = 2*cos(X*pi/2).*cos(Y*pi/2);
T(4.5/h:6.5/h,4.5/h:6.5/h) = Z;

D = 0.1;

v = [0 0.25];
%surf(T)
contour(T)
grid on
xlim([10 100])
ylim([10 100])
zlim([-2.5 2.5])
view([40 40 90])

vidObj = VideoWriter('wave_equation');
vidObj.Quality = 25;
open(vidObj);

T_k1 = T;
T_k2 = T;


plotT = [];

while (k<500)

k = k+1;    
    
T_k2 = T_k1;
T_k1 = T;
    
for y = [2:size(T,2)-1]
   for x = [2:size(T,1)-1] 
       

       diffContribution = (T_k1(x-1,y)-2*T_k1(x,y)+T_k1(x+1,y))/(h^2) + (T_k1(x,y-1)-2*T_k1(x,y)+T_k1(x,y+1))/(h^2);
       
       T(x,y) = 2*T_k1(x,y) - T_k2(x,y) + dt^2*D*diffContribution;
      
   end
end

plotT = [plotT T(50,50)];

% 
T(2,:) = 0;
T(x_max-1,:) = 0;T_k1(2,:) = 0;
T_k1(x_max-1,:) = 0;
T_k2(2,:) = 0;
T_k2(x_max-1,:) = 0;

T(:,2) = 0;
T(:,y_max-1) = 0;
T_k1(:,2) = 0;
T_k1(:,y_max-1) = 0;
T_k2(:,2) = 0;
T_k2(:,y_max-1) = 0;


%contour(T)
surf(T)
xlim([10 100])
ylim([10 100])
zlim([-2.5 2.5])
view([40 40 90])
%view([0 0 90])
currFrame = getframe;
%writeVideo(vidObj,currFrame);
%pause(0.01)
%err = max(max(abs(T-T_old)));

end

close(vidObj);

close