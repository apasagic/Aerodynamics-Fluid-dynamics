[X,Y] = meshgrid(-1:0.025:1);
%fi_1 = 10/(2*pi)*log(sqrt(X.^2+(Y+0.05).^2));
%fi_2 = -10/(2*pi)*log(sqrt(X.^2+(Y-0.05).^2));
%fi_1(find(isinf(fi_1)))=-10;
%fi_2(find(isinf(fi_2)))=10;
fi_doublet = 5/(2*pi).*cos(atan2(Y,X))./(sqrt(X.^2+Y.^2))
fi_doublet(find(fi_doublet==inf)) = 10;
fi_doublet(find(fi_doublet==-inf)) = -10;
fi_uniform = 5*X+0*Y;
fi_vortex = -0/(2*pi)*atan2(Y,X);
%fi = fi_1+fi_2+fi_3;
fi = fi_doublet + fi_uniform+fi_vortex;
[U,V] = gradient(fi);
Vn = 0.5*V./(sqrt(U.^2+V.^2));
Un = 0.5*U./(sqrt(U.^2+V.^2));
figure
%contour(X,Y,fi)
hold on; grid on;
%quiver(X,Y,Un,Vn)
streamslice(X,Y,Un,Vn)
xlim([-1 1])
ylim([-1 1])