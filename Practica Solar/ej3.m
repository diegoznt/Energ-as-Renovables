%% Ejercicio 3 guía

% mikasa
location.latitude=33.4934482
location.longitude=-70.7773707
location.altitude=463 %techo de la casa
% -33.4934482-70.7773707
%inclinacion del suelo=0 (aunque esto lo podria poner en la incli del techo?)
year=2023;
mes=[07];
dia=[16];
hora=[8 9 10 11 12 13 14 15 16 17];
minuto=[1];

% suma=0
% for i=1:24
%             suma=suma+1;
%           [zenith(suma), azimuth(suma)]=sun_position(year,mes,dia,hora(i),minuto,location);
% end
% figure
% plot(zenith)
% figure
% plot(azimuth)

%% a) dirección Norte-Sur

%% Norte
elevaciont=40
alpat=0 %(alpha de terreno) es el azimut del terreno (es el angulo con respecto al norte de la inclinaciom)
n=[sind(alpat)*sind(elevaciont), cosd(alpat)*sind(elevaciont),cosd(elevaciont)] %este es el vector unitario perpendicular al plano del panel solar


suma=0
for i=1:10
    [zenith(i), azimuth(i)]=sun_position(year,mes,dia,hora(i),minuto,location)
    alpas(i)=azimuth(i) % azimut solar
    elevacions(i)=90-zenith(i)
    s=[sind(alpas(i))*cosd(elevacions(i)),cosd(alpas(i))*cosd(elevacions(i)),sind(elevacions(i))] %los angulos solares los da la funcio
    suma=suma+1
    hola(suma,:)=s
    teta_north(i)=acosd(dot(s,n)) %este es el angulo entre el rayo incidente y el plano del panel solar
end

%% Sur
elevaciont=40
alpat=180 %(alpha de terreno) es el azimut del terreno (es el angulo con respecto al norte de la inclinaciom)
n1=[sind(alpat)*sind(elevaciont), cosd(alpat)*sind(elevaciont),cosd(elevaciont)] %este es el vector unitario perpendicular al plano del panel solar

 for i=1:10
    [zenith(i), azimuth(i)]=sun_position(year,mes,dia,hora(i),minuto,location)
    alpas(i)=azimuth(i) % azimut solar
    elevacions(i)=90-zenith(i)
    s=[sind(alpas(i))*cosd(elevacions(i)),cosd(alpas(i))*cosd(elevacions(i)),sind(elevacions(i))] %los angulos solares los da la funcion
    teta_sur(i)=acosd(dot(s,n1)) %este es el angulo entre el rayo incidente y el plano del panel solar
end


%% b) dirección Este-Oeste

%% Este
elevaciont=40
alpat=90 %(alpha de terreno) es el azimut del terreno (es el angulo con respecto al norte de la inclinaciom)
n2=[sind(alpat)*sind(elevaciont), cosd(alpat)*sind(elevaciont),cosd(elevaciont)] %este es el vector unitario perpendicular al plano del panel solar

 for i=1:10
    [zenith(i), azimuth(i)]=sun_position(year,mes,dia,hora(i),minuto,location)
    alpas(i)=azimuth(i) % azimut solar
    elevacions(i)=90-zenith(i)
    s=[sind(alpas(i))*cosd(elevacions(i)),cosd(alpas(i))*cosd(elevacions(i)),sind(elevacions(i))] %los angulos solares los da la funcion
    teta_este(i)=acosd(dot(s,n2)) %este es el angulo entre el rayo incidente y el plano del panel solar
 end

 %% Oeste
elevaciont=40
alpat=270 %(alpha de terreno) es el azimut del terreno (es el angulo con respecto al norte de la inclinaciom)
n3=[sind(alpat)*sind(elevaciont), cosd(alpat)*sind(elevaciont),cosd(elevaciont)] %este es el vector unitario perpendicular al plano del panel solar

 for i=1:10
    [zenith(i), azimuth(i)]=sun_position(year,mes,dia,hora(i),minuto,location)
    alpas(i)=azimuth(i) % azimut solar
    elevacions(i)=90-zenith(i)
    s=[sind(alpas(i))*cosd(elevacions(i)),cosd(alpas(i))*cosd(elevacions(i)),sind(elevacions(i))] %los angulos solares los da la funcion
    teta_oeste(i)=acosd(dot(s,n3)) %este es el angulo entre el rayo incidente y el plano del panel solar
 end

 figure
 subplot(1,2,1)
 plot(teta_oeste,'r','LineWidth',1)
 hold on
 plot(teta_este,'k','LineWidth',1)
 xlabel('Hora','FontSize',11,'FontWeight','bold')
 xticks(1:10)
 xticklabels(8:17);
 ylabel('\theta_{inc} [°]', 'Fontsize',11,'FontWeight','bold')
 title('Techo Este-Oeste','FontSize',11,'FontWeight','bold')
 legend('Oeste','Este')
 axis tight
 grid on
 subplot(1,2,2)
 plot(teta_north,'m','LineWidth',1)
 hold on
 plot(teta_sur,'c','LineWidth',1)
 xlabel('Hora','FontSize',11,'FontWeight','bold')
 xticks(1:10)
 xticklabels(8:17);
 ylabel('\theta_{inc} [°]', 'Fontsize',11,'FontWeight','bold')
 title('Techo Norte-Sur','FontSize',11,'FontWeight','bold')
 axis tight
 grid on
legend('Norte','Sur')
sgtitle('Ángulo de incidencia con respecto al techo','FontSize',20,'FontWeight','bold')


