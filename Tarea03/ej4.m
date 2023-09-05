load('EC_series.mat') %Rio Tolten Villarica
%Caudal Rio Tolten Villarica en -39.2667,-72.2333 250m [DGA] 



% % tiempo=datevec(time)
% % year=(tiempo(:,1))
% 
% %%Plotear caudal de todos los años y uno solo del año
% %%Caudal equipamiento Calculamos el promedio y sacamos el (multiplicamos *0.1)10%
% %Caudal clasificado es el caudal en orden de mayor a menor 
% 
% fecha_inicio = datetime('01-Jan-2010'); %aqui me lee las fechas
% fecha_fin = datetime('31-Dec-2010'); % luego datenum lo pasa a juliano y ve entre que valores esta esa fecha
% fecha = time(time >= datenum(fecha_inicio) & time <= datenum(fecha_fin));
% 
% 
% pos=find(time >= datenum(fecha_inicio) & time <= datenum(fecha_fin))
% 
% caudal=value(pos)
% figure(1)
% plot(fecha,caudal)
% 
%% Por periodo

%Abr-Sep
fecha_inicio1 = datetime('01-Apr-2010'); %aqui me lee las fechas
fecha_fin1 = datetime('30-Sep-2010'); % luego datenum lo pasa a juliano y ve entre que valores esta esa fecha
fecha1 = time(time >= datenum(fecha_inicio1) & time <= datenum(fecha_fin1));


pos1=find(time >= datenum(fecha_inicio1) & time <= datenum(fecha_fin1))
caudal1=value(pos1)

%Oct-Mar

fecha_inicio2 = datetime('01-Oct-2010'); %aqui me lee las fechas
fecha_fin2= datetime('31-Mar-2011'); % luego datenum lo pasa a juliano y ve entre que valores esta esa fecha
fecha2 = time(time >= datenum(fecha_inicio2) & time <= datenum(fecha_fin2));


pos2=find(time >= datenum(fecha_inicio2) & time <= datenum(fecha_fin2))



caudal2=value(pos2)

fech=[fecha1 ;fecha2]
cautotal=[caudal1 ;caudal2]

save('cautotal')

%Plot de Caudal Anual
figure(2)
plot([fecha1 ;fecha2],[caudal1 ;caudal2],'Linewidth',2,'Color',[0.1986, 0.7214, 0.6310])
xlabel('Tiempo [Días]','Fontsize',10)
ylabel('Caudal diario [m^3/s]','Fontsize',10)
title('Rio Tolten Villarica','FontSize',10)
datetick('x','mmm yyyy')
% xticks('dd')
% xticklabels('dd')
% xtickformat('dd')
set(gcf,'color','w')  % color de fondo grafico
set(gca,'FontSize',10)  % tamaño de numeros 
legend('Caudal diario')
%  saca contorno de legend
grid on
grid minor

%% Caudal clasificado es el caudal en orden de mayor a menor 
%representa los 365 caudales del año ordenados de mayor a menor
%Plot de Cfigure(2)

cauord=sort(cautotal,'descend') %caudal ordenado
ecologic=mean(value)*0.10;

figure
plot([1:365],cauord,'LineWidth',3,'Color',[0.0244, 0.4350, 0.8755])
xlabel('Datos','Fontsize',10)
ylabel('Caudal Clasificado [m^3/s]','Fontsize',10)
title(' Río Tolten Villarica','FontSize',10)
% xticks('dd')
% xticklabels('dd')
% xtickformat('dd')
set(gcf,'color','w')  % color de fondo grafico
set(gca,'FontSize',10)  % tamaño de numeros 
legend('Caudal Clasificado')
%  saca contorno de legend
grid on
grid minor


%% Entre Q80 y Q100 sacanos el Q_equipamiento

equipa=cauord(90)

%% Caudal clasificado es el caudal en orden de mayor a menor 
%representa los 365 caudales del año ordenados de mayor a menor
%Plot de Cfigure(2)

cauord=sort(cautotal,'descend') %caudal ordenado
ecologic=mean(value)*0.10;

for i=1:365
x(i,1)=80
x2(i,2)=100
end

y=linspace(80,406,365)

figure
plot([1:365],cauord,'LineWidth',3,'Color','g')
hold on
plot([1:365],cauord-ecologic,'LineWidth',3,'Color','k')
plot(x,y,'--r','LineWidth',1,'Color','c')
plot(x2,y,'--r','LineWidth',1,'Color','c')
xlabel('Datos','Fontsize',10)
ylabel('Caudal Clasificado [m^3/s]','Fontsize',10)
title(' Río Tolten Villarica','FontSize',10)
% xticks('dd')
% xticklabels('dd')
% xtickformat('dd')
set(gcf,'color','w')  % color de fondo grafico
set(gca,'FontSize',10)  % tamaño de numeros 
legend('Caudal Clasificado','Clasificado-Ecológico','Q_{80}','Q_{100}')
legend('boxoff')  
grid on
grid minor
axis tight









%% Parte b podemos obtener parametros con google earth 
%(estan las relaciones en el apunte)

%Caudal ecologico es el 10% de la media = mean(value)*0.1
%Caudal equipamiento es el caudal ordenado menos el caudal ecologico
ecologic=mean(value)*0.10;
%Calculamos el caudal ecologico como el 10 por ciento del promedio de datos
%diarias de caudal desde el 16 abril del año 1941 hasta 1 de marzo del 2020


%Area (A)
%Perimetro mojado(P)
%Radio hidráulico(Rh)
%Espejo de agua()

%Obtenido de google earth T=7.1 metros
%La profundidad Y=2 metros estimado

T=7.1
Y=2

A=(2/3)*T*Y
P=T+8*Y^2/(3*T)
Rh=(2*T^2*Y)/(3*T^2+8*Y^2)
espejo=(3*A)/(2*Y)

%% El potencial de generación hidroeléctrico puede ser calculado como
%Desnivel del agua antes y después
Q=mean(cautotal)
H=3
potencial=8.2*Q*H

% HACER UN GRAFICO DE DISPERSION DEL CAUDAL donde se ubica la media
% figure()
% bar(cautotal)
% plot(cautotal,[1:365])



figure
histogram(cauord,'FaceColor','m','EdgeColor','m')
xlabel('Caudal m^3/s','Fontsize',10)
ylabel('Frecuencia','Fontsize',10)
title(' Río Tolten Villarica [Abr2010-Abr2011]','FontSize',10)
% xticks('dd')
% xticklabels('dd')
% xtickformat('dd')
set(gcf,'color','w')  % color de fondo grafico
set(gca,'FontSize',10)  % tamaño de numeros 
%  saca contorno de legend
grid on


