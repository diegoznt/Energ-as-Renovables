%% a)

location.latitude=-33.4934482
location.longitude=-70.7773707
location.altitude=463 %techo de la casa
% -33.4934482-70.7773707
%inclinacion del suelo=0 (aunque esto lo podria poner en la incli del techo?)
year=2023;
mes=[1:12];
dia=[31 28 31 30 31 30 31 31 30 31 30 31];
hora=[1:24];
minuto=[1];

suma=0;
for k=1:12;
    for j=1:dia(k)
        for i=1:24;
            suma=suma+1;
          
            [zenith(suma), azimuth(suma)]=sun_position(year,mes(k),j,hora(i),minuto,location);
        end
    end
end

% fecha_inicio1 = datetime('0-Jan-2023'); %aqui me lee las fechas
% fecha_fin1 = datetime('31-Dec-2023')

fecha_inicio1 = datetime(2023,1,1,0,0,0); %aqui me lee las fechas
fecha_fin1 = datetime(2023,12,31,23,0,0)

times=fecha_inicio1:hours(1):fecha_fin1


figure(1)
plot(times,90-zenith,'r','Linewidth',1)
% xticks(fecha_inicio1:month(1):fecha_fin1)
xlabel('Fecha','Fontsize',10)
ylabel('Grados [°]','Fontsize',10)
title('Variación del ángulo de elevación año 2023 ','FontSize',20)
set(gcf,'color','w')  % color de fondo grafico
set(gca,'FontSize',10)  % tamaño de numeros 
legend('Elevación')
datetick('times','mm')


figure(2)
plot(times,azimuth,'b','Linewidth',1)
xlabel('Fecha','Fontsize',10)
ylabel('Grados [°]','Fontsize',10)
title('Variación del azimuth año 2023','FontSize',10)
set(gcf,'color','w')  % color de fondo grafico
set(gca,'FontSize',10)  % tamaño de numeros 
legend('Azimuth')
datetick('times','mmm')

%% 

l=0
for i=1:12
    for j=1:dia(i)
    l=l+1
[zenith1(l), azimuth1(l)]=sun_position(year,i,j,12,1,location)
    end
end





theta=zenith1
% masa atmosferica
AM=1./(cosd(theta)+0.50572.*(96.07995-theta).^(-1.6364))
%


% perdida de radiacion solar (que sufre AM) esta dada por el factor FAM
FAM=0.7.^(AM).^(0.678)

%F_ts cuantifica la perdida de radiacion segun la distancia
J=[1:365]
y=2.*pi.*(J-1)./(365.25)
F_ts=1+0.034*cos(y)
%Con J día juliano 1 de enero =0 y 31 diciembre 365
I_cs=1361  % constante solar
%Irradiancia
elevacion=90-zenith1
I=FAM.*I_cs.*sind(elevacion).*F_ts

plot(I,'c','Linewidth',3)
xlabel('Días','Fontsize',10)
ylabel('Radiación [W/m^2]','Fontsize',10)
title('Radiación directa año 2023','FontSize',20)
set(gcf,'color','w')  % color de fondo grafico
set(gca,'FontSize',10)  % tamaño de numeros 
legend('Maipú, Santiago de Chile ')
axis tight
grid on
grid minor











