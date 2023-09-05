%% ejercicio 2
%Baje un ano de datos de vientos de algun lugar costero de Chile centro-sur.
%(a) Dibuje una rosa de los vientos para el periodo octubre a marzo y otra
%para el periodo abril a septiembre.
%(b) Haga un diagrama de vector progresivo de los vientos durante todo el
%ano.
%(c) Muestre graficamente la distribucion de Weibull para esos datos.
%(d) ¿Que porcentaje del tiempo la intensidad del viento es mayor a 3 m/s?
%(e) ¿Que porcentaje del tiempo la intensidad del viento esta entre 3 y 12
%m/s?


% leo los datos de la pag 
% https://agrometeorologia.cl/#
% donde elijo la estación de Austral, Valdivia

datos = xlsread('agrometeorologia-20230407223024.xlsx');

%aca tenemos los datos de viento cada una hora durante un año

%para comodidad los datos son:

%desde el 1 de octubre del 2022 a las 00:00
%hasta el 30 de septiembre a las 23:00 

%para de esta forma tener un año de dato es decir 8760 filas 


% la primera columna corresponde a la velocidad en km/h
% la segunda columna corresponde a Dirección de Viento º
% la tercera columna corresponde a Velocidad de Viento % de datos
% la cuarta columna corresponde a Dirección de Viento % de datos 



%pero para esta tarea importaran la primera columna con la velocidad en
%km/h y la tercera columna con la direccion de viento en grados 

%por lo que guardamos los datos con los datos relevantes 

datos = [datos(:,1),datos(:,2)];

%vh esta en km/h lo paso a m/s divide el valor de velocidad entre 3.6
vh = datos(:,1)./3.6;
dh = datos(:,2);

%además de forma manual extraemos las fechas (solo la primera columna) de
%nuestro xlsx en formato string para luego convertirlo en formato fechas de
%matlab
load('TiempoUTC4.mat')%hecho manualmente 
% Convertir a objeto de fecha y hora de Matlab


%% (a) Dibuje una rosa de los vientos para el periodo octubre a marzo y otra 
%para el periodo abril a septiembre.

%octubre a marzo 
%vemos fecha de octubre a marzo desde la fecha_matlab  
%asi obtenemos la posicion de las filas que nos interesan 

%hasta 4367 que es la posicion del ultimo dia de marzo 
wind_rose(dh(1:4368),vh(1:4368));

%de abril a septiembre 
wind_rose(dh(4369:end),vh(4369:end));

%% (b) Haga un diagrama de vector progresivo de los vientos durante todo el ano.
%hacemos un diagrama de vector progresivo
%como hacemos esto en matlab 
%tenemos que descomponer la velocidad en x y en y 
%el angulo que tenemos esta en grados y tiene que estar en radianes

vo = vh;
vx = - vo.*sind(dh); 
vy = - vo.*cosd(dh);

%despues lo sumamos la suma reiterativa tiene funcion en matlab y se llama
%cumsum(vx) suma de los elementos anteriores

x = cumsum(vx)*3600; %multiplico por 3600 para así tener distancia
y = cumsum(vy)*3600;

%multiplico por 3600 para asi tener distancia por que el vector progresivo
%nos dice hacia donde se mueven los vientos 

figure()
plot(x,y)
title('Diagrama de vector progresivo')
xlim([-1800000 8500000])
ylim([-1800000 8500000])
xlabel('metros')
ylabel('metros')
grid on 

%% c Muestre graficamente la distribucion de Weibull para esos datos.
clear all 
clc 
load('vh');
load('dh');
%su formula es 
%p(x) =  k/c * [x/c]^(k-1)*e^-(x/c)^k

%con x la velocidad normalizada 

%ordenamos los datos
d_ord=sort(vh);

%normalizamos los datos ordenados 
x=d_ord./(mean(d_ord));

%calculamos k y c
%la k se calcula con los datos normalizados 
k = (std(x)./mean(x))^-1.086;

% c se calcula con la funcion gamma

c = 1/gamma(1+1/k);

p = (k/c).*(x/c).^(k-1).*exp(-(x./c).^k); 

figure()
plot(x,p)
title('Distribución de Weibull')
%ylim([0 1])
ylabel('probabilidad')
xlabel('probabilidad normalizada')

%% (d) ¿Que porcentaje del tiempo la intensidad del viento es mayor a 3 m/s?
wind_rose(dh,vh);

%2d
t= 1-exp(-(3/mean(vh))*gamma(1+(1/k)))^k;
%este t esta en cifra decimal, hay que multiplicarlo por 100
tporcentaje=t*100;


%2e %tiempo v
t2 = (exp(-(3/mean(vh))*gamma(1+(1/k)))^k) - (exp(-(12/mean(vh))*gamma(1+(1/k)))^k);
%este t2 esta en decimal, hay que multiplicarlo por 100
t2porcentaje=t2*100;

%revisar la distribucion de weibull por que no da 
%el oscar lo hizo asi 
%load('datosviento.mat')
ordenado=sort(vh);
x=ordenado/mean(ordenado);
k = (std(x)/mean(x))^-1.086;
c=1/gamma(1+1/k);
P=k/c.*(x./c).^(k-1).*exp(-(x./c).^k);
figure()
plot(x,P)
%ylabel('probabilidad')
%xlabel('probabilidad normalizada')

%% 3
%Calcule los promedios mensuales de la intensidad de los mismos vientos
%usados en el ejercicio anterior, y luego haga una esquema de como varían
%esos vientos con la altura, hasta 80 m de altura, si la medicion hubiese
%sido hecha en un potrero con pasto corto, y si hubiese sido hecha en un
%bosque. Si no hay informacion al respecto, asuma que sus datos fueron
%obtenidos a 8 metros del suelo. Para cada caso encuentre los MWh que
%generaria un aerogenerador tipico de tres aspas, si cada aspa mide 35 m
%(asuma usted otros par ́ametros del aerogenerador que puede necesitar).
%Traspase ese monto a millones de pesos al año

%como pasar a porcentaje mensuales
%datos que toma datos cada hora por un año como pasamos ese vector a dias
%por un año, es decir 364 datos con los promedios

%pasamos vh en horas a dias

n=0;
for i=1:365 %dias
    vd(i)=mean(vh(n+1:n+24)); %velocidad diaria
    n=n+24;
end

%ahora lo pasamos a meses
%ordenamos los dias de los meses desde octubre a septiembre 

dm=[0 31 30 31 31 28 31 30 31 30 31 31 30]; %dias del mes 
%y empiezo del cero pq tiene que empezar del dato 1
dms=cumsum(dm); %se va sumando los dias del mes 
%esta suma indica la posicion del mes que viene


%ahora lo pasamos a valores mensuales 
for i=1:12
    vm(i)=mean(vd(dms(i)+1:dms(i+1))); %valores mensuales
end

figure()
plot(vm,'linewidth',3)
title('Promedios Mensuales de la intensidad de los vientos')
ylabel('M/S')
xlabel('Meses')
axis tight
grid on 

%% haga un esquema como varían
%esos vientos con la altura, hasta 80 m de altura, si la medicion hubiese
%sido hecha en un potrero con pasto corto, y si hubiese sido hecha en un
%bosque.

%existe una formula para determinar eso 
%describen la variacion de la componente paralela al suelo, en la direccion
%perpendicular al suelo
 
%V(z2)/V(z1) = log(z2/z0) / log(z1/z0);

%donde
%v(z2) queremos conocer
%v(z1) lo tenemos (vh)
%z2 altura a lo que queremos conocer la velocidad esta dado en este caso 80
%z1 altura dd se tomaron los datos en este caso 8 altura dd se tomaron los datos(lo dice el enunciado)
%z0 es sacado de la tablita 
% z0 = 1 en bosques
% z0 = 0.03 en pasto

%z1= 8 %[m]

%z2 altura a la que quiero saber la velocidad del viento

%como se relacionan las alturas 
%en este ejercicio trabajamos con la media de los vientos por meses

%pasto


%V(z2)/V(z1) = log(z2/z0) / log(z1/z0);
%V(z2) = log(z2/z0) / log(z1/z0) * V(z1);


%z1=8;
%z2=80;
%z0=0.03;
%vz1=vm;



%bosque



%en bosque lo unico que varía es z0 que corresponde a 
%z0 = 1 en bosques 

%V(z2) = log(z2/z0) / log(z1/z0) * V(z1);



%z1=8;
%z2=80;
%z0=1;
%vz1=vm;
%%
%creamos un vector de altura

%para pasto 

H=[10 20 30 40 50 60 70 80] %metros 
%tenemos las variaciones mensuales vm 
for j=1:12 
    for i=1:8
        vz2_p(i,j)=(log(H(i)/0.03))/(log(8/0.03))*vm(j);
    end
end

%con esto obtengo una matriz de 8x12 donde cada columna representa un mes y
%cada fila como varia la velocidad cada 10 [m] de altura 

%figure()
%hold on 
%plot(vz2_p(1,:)) %al graficar toda la fila 1 veo como varia el viento durante un año a la misma altura [10m]
%plot(vz2_p(2,:)) %grafico toda la fila 2 para ver como varia a 20 m 
%plot(vz2_p(3,:))
%plot(vz2_p(4,:))
%plot(vz2_p(5,:))
%plot(vz2_p(6,:))
%plot(vz2_p(7,:))
%plot(vz2_p(8,:))
%legend('10[m]','20[m]','30[m]','40[m]','50[m]','60[m]','80[m]')
%axis tight 
%grid on 

%automatizamos 

figure()
hold on
for  i=1:8
    plot(vz2_p(i,:))
end
title('variaciones de velocidad c/r a diferentes alturas durante el año pasto')
legend('10[m]','20[m]','30[m]','40[m]','50[m]','60[m]','80[m]')
xlabel('meses')
ylabel('m/s')
axis tight 
grid on 

%ahora para bosque (lo unico que cambia es de 0.03 a 1)

%para bosque  

H=[10 20 30 40 50 60 70 80] %metros 
%tenemos las variaciones mensuales vm 
for j=1:12 
    for i=1:8
        vz2_b(i,j)=(log(H(i)/1))/(log(8/1))*vm(j);
    end
end


figure()
hold on
for  i=1:8
    plot(vz2_b(i,:))
end
title('variaciones de velocidad c/r a diferentes alturas durante el año bosque')
legend('10[m]','20[m]','30[m]','40[m]','50[m]','60[m]','80[m]')
xlabel('meses')
ylabel('m/s')
axis tight 
grid on 


%% ahora los mwh
%Para cada caso encuentre los MWh que
%generaria un aerogenerador tipico de tres aspas, si cada aspa mide 35 m
%(asuma usted otros parametros del aerogenerador que puede necesitar).
%Traspase ese monto a millones de pesos al año


%la potencia del aerogenerador será

% potencia_aereo = potencia_natural * eficiencia 

%el valor de eficiencia nos lo damos nosotros 0.4 por ej 

%donde la potencia natural se define como 

%potencia natural= (1/2)*densidad_aire*((velocidad)^3)*area

%y la velocidad que se usa en la potencia natural es el promedio de los
%valores mensuales de velocidad vh, es decir tenemos un solo numero con el
%promedio de velocidad 

%el problema es que a medida que aumento la altura el area que va abarcando
%mi aerogenerador es diferente 

%como resuelvo esto? voy a promediar dos veces para así obtener una
%velocidad promedio, primero voy a promediar por fila asi obtener el
%promedio por cada altura, (deberia tener 8 velocidades promedio por altura)
%y luego esos 8 datos de promedio los vuelvo a promediar para sacar un solo
%valor promedio de la velocidad, de esa forma despreciare el problema del
%area asumiendo que es la misma y asi usar el area del circulo 


%para pasto 
H=[10 20 30 40 50 60 70 80] %metros 
%tenemos las variaciones mensuales vm 
for j=1:12 
    for i=1:8
        vz2_p(i,j)=(log(H(i)/0.03))/(log(8/0.03))*vm(j);
    end
end

%en esta matriz de 8x12 saco los promedios por fila y asi obtener promedios
%por altura 

for i=1:8
  vm_filap(i) = mean(vz2_p(i,:)); %aca obtengo un vector con los promedios por altura
end

%ahora saco el promedio de las filas y asi obtener un solo valor promedio
%de velocidad
vm_totalp=mean(vm_filap);

%con esto obtengo la velocidad promedio ahora calculare la potencia 

%la potencia del aerogenerador será

% potencia_aereo = potencia_natural * eficiencia 

%el valor de eficiencia nos lo damos nosotros 0.4 por ej 

%donde la potencia natural se define como 

%potencia natural= (1/2)*densidad_aire*((velocidad)^3)*area


%definimos nuestros valores 
area=pi*(35^2);
densidad=1.25;
eficiencia=0.4;
potencia_naturalp=0.5*densidad*(vm_totalp)^3*area;
potencia_aereop=potencia_naturalp*eficiencia;


%para bosque

for i=1:8
  vm_filab(i) = mean(vz2_b(i,:)); %aca obtengo un vector con los promedios por altura
end

%ahora saco el promedio de las filas y asi obtener un solo valor promedio
%de velocidad
vm_totalb=mean(vm_filab);
potencia_naturalb=0.5*densidad*(vm_totalb)^3*area;
potencia_aereob=potencia_naturalb*eficiencia;


%como lo paso a mwh falta solo sacarlo a mwh
%la potencia va a estar en watt, es decir joule/seg 
%pasaremos los watts a megawatts MWH

%es decir pasaremos la potencia a megawatss
% 1 000 000 w = 1 mwh
%por lo tanto 

p_aereopmega=potencia_aereop/1000000;

dineropasto=p_aereopmega*8760*80000;

%ahora para  mwh para bosque
p_aereobmega=potencia_aereob/1000000;

dinerobosque=p_aereobmega*8760*80000;




%% ahora sacaremos el perfil de velocidad ejercicio a eleccion
%donde graficaremos los meses 
%en el eje x estan las velocidades
%en el eje y estan las alturas
%y cada linea graficada el perfil de velocidad del respectivo mes 

%pasto
figure()
hold on
for i=1:12
    plot(vz2_p(:,i),H)
end
title('perfil de velocidad mensual pasto')
legend('octubre','noviembre','diciembre','enero','febrero','marzo','abril','mayo','junio','julio','agosto','septiembre')
xlabel('m/s')
ylabel('metros')
axis tight 
grid on

%bosque
figure()
hold on
for i=1:12
    plot(vz2_b(:,i),H)
end
title('perfil de velocidad mensual bosque')
legend('octubre','noviembre','diciembre','enero','febrero','marzo','abril','mayo','junio','julio','agosto','septiembre')
xlabel('m/s')
ylabel('metros')
axis tight 
grid on







