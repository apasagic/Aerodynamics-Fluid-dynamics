figure('units','normalized','outerposition',[0 0 1 1])

T = zeros(100,500);
T(25:75,50:90) = 200;

k = 0;
err = 0;
dt = 1;
h = 1;

v = [0 0.25];
surf(T)
grid on

vidObj = VideoWriter('heat_transfer');
vidObj.Quality = 25;
open(vidObj);

while (k<200)

k = k+1;
T_old = T;
    
for y = [2:size(T,2)-1]
   for x = [2:size(T,1)-1] 
       
      if((T(x,y)-T(x-1,y)) ~= 0)
       x;
       y;
      end

       velContribution = (v(1)*(T(x+1,y)-T(x-1,y)) + v(2)*(T(x,y+1)-T(x,y-1)));
       diffContribution = (T(x-1,y)-2*T(x,y)+T(x+1,y))/h + (T(x,y-1)-2*T(x,y)+T(x,y+1))/h;
       T(x,y) = T_old(x,y) + 0.1*diffContribution - velContribution;
      
   end
end
surf(T)
view([0 90])
currFrame = getframe;
writeVideo(vidObj,currFrame);
%pause(0.01)
%err = max(max(abs(T-T_old)));

end

close(vidObj);