%%POLO SUR

year=2023
mes=[1:12]
dia=15
hora=12
minuto=1
location.latitude=-90
location.longitude=0
location.altitude=0

%se mide en sentido horario el azimut (es el angulo c/r al norte)
%zenit (es entre el arriba y el sol) el complemento es el angulo de
%elevacion

for i=1:12
[zenith1(i), azimuth1(i)]=sun_position(year,mes(i),dia,hora,minuto,location)
end


%% -45
location.latitude=-45
for i=1:12
[zenith2(i), azimuth2(i)]=sun_position(year,mes(i),dia,hora,minuto,location)
end


%% 0
location.latitude=0
for i=1:12
[zenith3(i), azimuth3(i)]=sun_position(year,mes(i),dia,hora,minuto,location)
end

%% 45
location.latitude=45
for i=1:12
[zenith4(i), azimuth4(i)]=sun_position(year,mes(i),dia,hora,minuto,location)
end


%% 90
location.latitude=90
for i=1:12
[zenith5(i), azimuth5(i)]=sun_position(year,mes(i),dia,hora,minuto,location)
end

figure(1)
plot(zenith5,'-c+','LineWidth',1)
hold on
plot(zenith4,'-m+','LineWidth',1)
plot(zenith3,'-go','LineWidth',1)
plot(zenith2,'-r*','LineWidth',1)
plot(zenith1,'-k*','LineWidth',1)
xlabel('Mes','FontSize',11,'FontWeight','bold')
 ylabel('Zenith [°]', 'Fontsize',11,'FontWeight','bold')
 title('Variación del zenith con la latitud','FontSize',15,'FontWeight','bold')
 axis tight
 grid on
lgd=legend('90° Polo Norte','45°','0° Ecuador','-45°','-90 Polo Sur')
title(lgd, 'Latitudes');

figure(2)
plot(azimuth5,'-c','LineWidth',1)
hold on
plot(azimuth4,'-m','LineWidth',1)
plot(azimuth3,'-g','LineWidth',1)
plot(azimuth2,'-r','LineWidth',1)
plot(azimuth1,'-k','LineWidth',1)
xlabel('Mes','FontSize',11,'FontWeight','bold')
 ylabel('Azimuth [°]', 'Fontsize',11,'FontWeight','bold')
 title('Variación del azimuth con la latitud','FontSize',15,'FontWeight','bold')
 axis tight
 grid on
lgd=legend('90° Polo Norte','45°','0° Ecuador','-45°','-90 Polo Sur')
title(lgd, 'Latitudes');

