 d=readmatrix('data_ej3.txt') %GWh ojo que matlab lee los ptos como coma
name={'Hidraulica','Solar PV + CSP','Eólica','Biomasa','Geotérmica','Cogeneración','Carbón','Gas Natural','Petroleo','Total Renovable'}

%Vemos los datos y notamos que hay un problema con la lectura de matlab a
%esos datos ya que los que tienen punto los toma como decimal

[filas, columnas] = size(d);

for i = 1:filas
    for j = 1:columnas
        valor = d(i, j);
        
        % vemos si tiene punto decimal con el resto de la division por 1
        if mod(valor, 1) ~= 0
         
        valor=1000*valor
        end
        sincoma(i,j)=valor
    end
end




x=[1996:2022]

data=sincoma(:,3:end)


% Pasamos a porcentajes nuestros datos
for i=1:27
    nuevo(:,i)=data(:,i)/data(end,i)*100
end

%datos finales en porcentajes
final_data=nuevo([1:6,9:11],:)


%% Grafico de Participacion relativa por fuente de generación
% bar(final_data','stacked')
figure()
ba = bar([1996:2022],final_data','stacked', 'FaceColor','flat');
xticks([1996:2022])
xtickangle(45)
ba(1).FaceColor = [0, 0, 1]
ba(2).CData = [1, 0.92, 0.016]
ba(3).CData = [0.565, 0.933, 0.565]
ba(4).CData = [0.435, 0.749, 0.435]
ba(5).CData = [1, 0.647, 0]
ba(6).CData = [0.0, 0.4, 0.0]
ba(7).CData = [0.5, 0.5, 0.5]
ba(8).CData = [0.8, 0.8, 0.8]
ba(9).CData = [0.2, 0.2, 0.2]
% ba(10).CData = []

hold on
%linea verde de total renovable
total_renovavles=nuevo(8,:)
plot(x,total_renovavles,'-','LineWidth',2,'Color','#008000')
yticks([0 25 50 75 100]) %valores del eje y 
ytickformat('percentage') %eje y en porcentajes
% Esta parte es para el total renovable k aparezcan los porcentajes
labels = cellstr(num2str(total_renovavles', '%0.1f%%')); % Crear etiquetas en el formato (x,y)
text([1996:2022],total_renovavles+1, labels,'VerticalAlignment', 'bottom','HorizontalAlignment', 'center','FontSize',10,'Color', 'g');
legend('Hidraulica','Solar PV + CSP','Eólica','Biomasa','Geotérmica','Cogeneración','Carbón','Gas Natural','Petroleo','Total Renovable')
axis tight
title('Participación relativa por fuente de generación [%]','FontSize',19)
set(gcf,'color','w')  % color de fondo grafico
set(gca,'FontSize',10)  % tamaño de numeros

%% Grafico Volumen generada por fuente

%usamos data ya que son los datos limpios y en GWh (le sacamo los totales)
data2=data([1:6,9:11],:)
figure()
ba = bar([1996:2022],data2','stacked', 'FaceColor','flat');
ba(1).FaceColor = [0.0, 0.45, 0.73]
ba(2).CData = [1, 0.92, 0.016]
ba(3).CData = [0.565, 0.933, 0.565]
ba(4).CData = [0.435, 0.749, 0.435]
ba(5).CData = [1, 0.647, 0]
ba(6).CData = [0.0, 0.4, 0.0]
ba(7).CData = [0.5, 0.5, 0.5]
ba(8).CData = [0.8, 0.8, 0.8]
ba(9).CData = [0.2, 0.2, 0.2]
xticks([1996:2022])
xtickangle(45)
ax = gca;
ax.YAxis.Exponent = 0; % esto desactiva la notacion cientifica y muestra los valores reales
yticks([0 20000 40000 60000 80000]) % valores que quiero que se vean
yline([0 20000 40000 60000 80000],'Color',[0.8, 0.8, 0.8]) %trazamos lineas en esos ptos en y
% como grillas igual que las de la pag generadoras de Chile
hold on
plot(x,data(8,:),'-','LineWidth',2,'Color','#008000') % esta es la curva de total renovable
title('Volumen de energía generada por fuente [GWh]','FontSize',19)
legend('Hidraulica','Solar PV + CSP','Eólica','Biomasa','Geotérmica','Cogeneración','Carbón','Gas Natural','Petroleo','','','','','','Total Renovable','Location','northwest')
grid on
set(gcf,'color','w')  % color de fondo grafico
set(gca,'FontSize',10)  % tamaño de numeros

