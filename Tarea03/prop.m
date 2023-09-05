% Cuenca 5710001 - Rio Maipo En El Manzano (Lat. -33.59, Lon. -70.38)
% Área: 4839 km². Precip. anual media CR2MET: 840 mm. Indice áridez: 0.8
% Cota (máx., media, punto salida): 6550, 3181, 875 m s.n.m.

a=importdata('riomaipo.txt')

load("cautotal.mat")

cauTolten=cautotal

cauMaipo=a.data

maiporden=sort(cauMaipo,'descend')

%% Ambos caudales son para el mismo periodo

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







%Plot de Caudal Anual
figure(2)
plot([fecha1 ;fecha2],cauTolten,'Linewidth',2,'Color',[0.1986, 0.7214, 0.6310])
hold on
plot([fecha1 ;fecha2],cauMaipo,'Linewidth',2,'Color','g')
xlabel('Tiempo [Días]','Fontsize',10)
ylabel('Caudal diario [m^3/s]','Fontsize',10)
title('Caudales diarios de los ríos Tolten y Maipo','FontSize',15)
datetick('x','mmm yyyy')
% xticks('dd')
% xticklabels('dd')
% xtickformat('dd')
set(gcf,'color','w')  % color de fondo grafico
set(gca,'FontSize',10)  % tamaño de numeros 
legend('Caudal Río Tolten','Caudal Río Maipo')
%  saca contorno de legend
grid on
grid minor


%% Ahora vemos como se distribuyen sus caudales con un histograma

figure
subplot 121
histogram(cauord,'FaceColor','m','EdgeColor','c')
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
subplot 122
histogram(maiporden,'FaceColor','c','EdgeColor','m')
xlabel('Caudal m^3/s','Fontsize',10)
ylabel('Frecuencia','Fontsize',10)
title(' Río Maipo En El Manzano [Abr2010-Abr2011]','FontSize',10)
% xticks('dd')
% xticklabels('dd')
% xtickformat('dd')
set(gcf,'color','w')  % color de fondo grafico
set(gca,'FontSize',10)  % tamaño de numeros 
%  saca contorno de legend
grid on

