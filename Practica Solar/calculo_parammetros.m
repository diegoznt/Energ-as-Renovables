year=2023
mes=5
dia=15
hora=15
minuto=23
location.latitude=-36.830616
location.longitude=-73.037327
location.altitude=25

%se mide en sentido horario el azimut (es el angulo c/r al norte)
%zenit (es entre el arriba y el sol) el complemento es el angulo de
%elevacion


[zenith, azimuth]=sun_position(year,mes,dia,hora,minuto,location)


%%Vemos como varia segun la hora
hora=[1:24]

for i=1:24
    
[zenith(i), azimuth(i)]=sun_position(year,mes,dia,hora(i),minuto,location)
end

plot(zenith,'-+b')
hold on
plot(azimuth, '-+r');
xlabel('hora');
ylabel('Angulo');
legend('zenith', 'azimut');

%% Ahora vemos como varia segun el minuto a las 12 horas

minuto=[1:60]
hora=12
for i=1:60
    
[zenith(i), azimuth(i)]=sun_position(year,mes,dia,hora,minuto(i),location)
end

plot(zenith,'-+b')
hold on
plot(azimuth, '-+r');
xlabel('hora');
ylabel('Angulo');
legend('zenith', 'azimut');

% se ve un salto xq se mide con respecto al norte entonces cuando pasa el
% primer cuadrante es 300 y algo el angulo xq se mide cr al norte

hora=16
minuto=18
dia=29

[zenith, azimuth]=sun_position(year,mes,dia,hora,minuto,location)

theta=zenith %(theta=90-gamma_s) 90 menos la elevacion

% masa atmosferica
AM=1/(cosd(theta)+0.50572*(96.07995-theta)^(-1.6364))
% perdida de radiacion solar (que sufre AM) esta dada por el factor FAM
FAM=0.7^(AM)^(0.678)

%F_ts cuantifica la perdida de radiacion segun la distancia
J=148
y=2*pi*(J-1)/365.25
F_ts=1+0.034*cos(y)
%Con J día juliano 1 de enero =0 y 31 diciembre 365
I_cs=1361
%Irradiancia
elevacion=90-zenith
I=FAM*I_cs*sind(elevacion)*F_ts

%%AM es la masa atmosferica toma en cuenta la atm que atraviesan los rayos
%%del sol

%Elevación =90-zenith
%angulo de incidencia nos va servir para calcular la irradiancia que llega
%al panel solar (es el angulo con que está el panel solar con respecto a la horizontal)
%primero hay que saber para dd esta inclinada la superficie, para donde cae
%el agua si corre por el panel (N-S-E-O))

%Luego sacamos el angulo unitario perpendicular al panel y luego obtenemos el 
%angulo de incidencia que es con que llegan los rayos del sol al panel
%cuando son iguales ese angulo entre los dos si es cero es xq llegan
%parallos el unitario y el de incidencia 
elevaciont=45
alpat=30 %(alpha de terreno) es el azimut del terreno (es el angulo con respecto al norte de la inclinaciom)
n=[sind(alpat)*sind(elevaciont), cosd(alpat)*sind(elevaciont),cosd(elevaciont)] %este es el vector unitario perpendicular al plano del panel solar

location.latitude=-36.830616
location.longitude=-73.037327
location.altitude=28

[zenith, azimuth]=sun_position(2023,06,05,16,12,location)
alpas=azimuth % azimut solar
elevacions=90-zenith 
s=[sind(alpas)*cosd(elevacions),cosd(alpas)*cosd(elevacions),sind(elevacions)] %los angulos solares los da la funcion
teta=acosd(dot(s,n)) %este es el angulo entre el rayo incidente y el plano del panel solar


%S solar y T del terreno
%Elevacion t (elevacion del terreno del plano c/r a la horizontal) y
%Elevacion S (elevacion del sol)
%alpha son los azimut


%Irradiancia directa, difusa y reflectada

I_inclinada=I_directa*cosd(teta)/sind(elevacions)

I_reflectancia=(I_directa*Albedo*(1-cosd(elevacion)))/2
%Albedo va de 0 a 1
%I_total=I_inclinada+I_reflectancia+I_inclinada_difusa

%I_inclinada_difusa= calcular kt y dependiendo de kt (es la irradiancia que rebota y llega) 

k_t=I_inclinada/(1361*sind(elevacions))

%si k_t<0.3 , k_1>0.3, k_t=<0.78,k_t=>0.78 dependiendo del k_t que nos de 


