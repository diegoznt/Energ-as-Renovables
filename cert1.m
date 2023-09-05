a=readmatrix('agrometeorologia-20230608191929.csv') %01-10-2021 to 30-09-2022
% station Mejillones, Mejillones DMC
lat=-23.10
lon=-70.44 % elev=31m (DMC)
% Vel del viento en km/h
% figure
% geoplot(lat,lon,'or',"MarkerSize",10,"MarkerEdgeColor","k", ...
%     "MarkerFaceColor",'c')
% geobasemap topographic
% geolimits([-24 -22.30],[-71.6 -69.7])
% legend('Estación Mejillones DMC')
% title('Mapa zona de estudio','FontSize',15)

%Pasamos las velocidades de km/h a m/s

viento=a(7:371,2)/3.6
direccion=a(7:371,3)

ma=max(viento)
me=min(viento)
mea=mean(viento)

octmar_vent=viento(1:188)
octmar_dir=direccion(1:188)
abrsep_vent=viento(189:end)
abrsep_dir=direccion(189:end)

figure ()
wind_rose(octmar_dir,octmar_vent)


figure ()
wind_rose(abrsep_dir,abrsep_vent)


% cn = ceil(7);                                             
% cm = colormap(jet(cn));
% figure(2)
% polarscatter(deg2rad(octmar_dir),octmar_vent, [], cm(fix(octmar_vent),:), 'filled')
% colormap(jet(cn))
% colorbar
% caxis([min(octmar_vent), max(octmar_vent)+1]);
% grid on


%% Este sii
% Crear un rango de valores continuos para el color
c_values = linspace(min(octmar_vent), max(octmar_vent), 8); % Ajusta el número de pasos (100) según tus necesidades
ax = polaraxes
% Crear el gráfico polar con colores continuos
figure
subplot(1,2,1)
polarscatter(deg2rad(octmar_dir), octmar_vent, [], octmar_vent, 'filled')
pax.ThetaDir = 'clockwise'
colormap("jet") % Selecciona la paleta de colores deseada (en este caso, 'jet')
caxis([0, 8]) % Ajusta los límites de los valores de color
cb = colorbar;
title(cb, 'v [m/s]')
ax.ThetaDir = 'clockwise'
set(gca, 'ThetaZeroLocation', 'top')
title('Viento en Mejillones, Oct 2021 - Mar 2022')

%% Este sii
c_values = linspace(min(abrsep_vent), max(abrsep_vent), 8); % Ajusta el número de pasos (100) según tus necesidades
ax = polaraxes
subplot(1,2,2)
polarscatter(deg2rad(abrsep_dir), abrsep_vent, [], abrsep_vent, 'filled')
pax.ThetaDir = 'clockwise'
colormap("jet") % Selecciona la paleta de colores deseada (en este caso, 'jet')
caxis([0, 8]) % Ajusta los límites de los valores de color
cb = colorbar;
title(cb, 'v [m/s]')
ax.ThetaDir = 'clockwise'
set(gca, 'ThetaZeroLocation', 'top')
title('Viento en Mejillones, Abr 2022 - Sept 2022')




%% Histograma 
figure()
hist(viento,12,'FaceColor','red')
h = findobj(gca,'Type','patch');
h.FaceColor = [0, 0, 0.5]  
h.EdgeColor = 'k';
xlabel('Velocidad del viento [m/s]','Fontsize',10)
ylabel('Frecuencia','Fontsize',10)
title('Histograma de viento en Mejillones','FontSize',17)
set(gcf,'color','w')  % color de fondo grafico
set(gca,'FontSize',10)  % tamaño de numeros  %  saca contorno de legend
grid on
grid minor      
%axis tight % ajusta la figura

%% c)
vx=-viento.*sind(direccion)
vy=-viento.*cosd(direccion)

ejex=cumsum(vx)*86400
ejey=cumsum(vy)*86400

figure()
plot(ejex,ejey,'m','LineWidth',1)
xlabel('Distancia en x [m]','FontSize',10)
ylabel('Distancia en y [m]','FontSize',10)
title('Diagrama de Vector Progresivo ','FontSize',15)
axis square
axis tight
grid on
grid minor
ytickformat('%.0')
ax = gca;
ax.YAxis.Exponent = 0; % esto desactiva la notacion cientifica y muestra los valores reales
% yticks([0 20000000 40000000 60000000 80000000]) % valores que quiero que se vean
% yline([0 20000 40000 60000 80000],'Color',[0.8, 0.8, 0.8]) %trazamos lineas en esos ptos en y
% % como grillas igual que las de la pag generadoras de Chile
%% d) Distribucion de Weibull

%ordenamos los datos
orden=sort(viento) % ordenamos los datos de menor a mayor
orden_norma=(orden)./(mean(orden)) % datos normalizados y ordenados

% figure()
% plot(orden)
% figure()
% plot(orden_norma)
%normalizamos los datos ordenados 

%para los datos normalizados calculamos de otra forma el k
k1 = ((0.9874)/(std(orden)/mean(orden)))^1.0983; % Datos SIN normalizar


k2 =(std(orden_norma)./mean(orden_norma))^-1.086 %2.6 %((0.9874)/(std(orden_norma)/mean(orden_norma)))^1.0983;%(std(orden_norma)./mean(orden_norma))^-1.086; % Datos normalizados

c1 = mean(orden)/gamma(1+1/k1);
c2 = 1/gamma(1+1/k2);

p1 = (k1/c1).*(orden./c1).^(k1-1).*exp(-(orden./c1).^k1)
p2 = (k2/c2).*(orden_norma./c2).^(k2-1).*exp(-(orden_norma./c2).^k2)

figure()
subplot(2,1,1)
plot(orden,p1,'-k','Linewidth',1)
xlabel('Velocidad [m/s]','Fontsize',10)
ylabel('f(x)','Fontsize',10)
title('Distribución de Weibull (no normalizado)','FontSize',10)
set(gcf,'color','w')  % color de fondo grafico
set(gca,'FontSize',10)  % tamaño de numeros 
legend('k=3.9830')

%%NO sirve para los NO normalizados

subplot(2,1,2)
plot(orden_norma,p2,'-r','Linewidth',1)
xlabel('Velocidad Normalizada [m/s]','Fontsize',10)
ylabel('f(x)','Fontsize',10)
title('Distribución de Weibull (normalizado)','FontSize',10)
set(gcf,'color','w')  % color de fondo grafico
set(gca,'FontSize',10)  % tamaño de numeros 
legend('k=3.9762')

% plot(orden)
% hold on
% plot(orden_norma)
% plot(log(orden))

plot(log(orden))


%% Tiempo entre 3 y 12

%2d
t= 1-exp(-(3/mean(viento))*gamma(1+(1/k1)))^k1;
%este t esta en cifra decimal, hay que multiplicarlo por 100
tporcentaje=t*100;


a=3
b=8
tem=(exp(-(a/c1)^k1)-exp(-(b/c1)^k1))*100

n=length(find(viento>=3 & viento<12))
porcentaje=n/365*100

wei=@(orden) (k1/c1).*(orden./c1).^(k1-1).*exp(-(orden./c1).^k1)

inte=integral(wei,3,9)
