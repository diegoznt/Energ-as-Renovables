
% Tau parametro adimensional Γ, llamado numero de forma (ashape
% numberñ) de la turbina, el que permite calcular su tamaño
pot=160000 %160kW
H=[5] %5 y 81
rho=1000
g=9.81

w=[0:0.1:10] %debiese ser la rapidez con que gira %relcion con v tangencial?
gam=(sqrt(pot).*w)./(sqrt(rho).*(g.*H).^(5/4))

R=1/2*(sqrt(2*g*H)./w)

H2=81
 %debiese ser la rapidez con que gira %relcion con v tangencial?
gam2=(sqrt(pot).*w)./(sqrt(rho).*(g.*H2).^(5/4))

R2=1/2*(sqrt(2*g*H2)./w)

figure(1)
plot(w,gam)
% hold on
%plot(w,gam2)



figure(2)
plot(w,R)
hold on
plot(w,R2)
