
% que consiste en tres elementos de diferente �rea seccional sometidos 
%a una carga de compresi�n de valor 1200 kN. Las �reas de los elementos son
% A1 = 0,25, A2 = 0,16 y A3 = 0,09m2
% , mientras que el m�dulo de elasticidad es E = 2�107kN/m2
% para todos ellos. Por tanto, las matrices de rigidez son 
% ke = EAe/le *[1 -1
%               -1 1]
% con le = 1 m para e = 1, 2, 3. 
%%
clc
clear all
close all
%% Datos

E = 1;

A_1=1;

A_2=1;

A_3=1;

Le=1;




%% Grados de libertad asociados a los elementos
g_1=[1 2];      %elemento 1
g_2=[2 3];      %elemento 2
g_3=[3 4];      %elemento 3

%% Definimos ke
ke_1=Barra_Axial(E,A_1,Le);      %elemento 1
ke_2=Barra_Axial(E,A_2,Le);      %elemento 2
ke_3=Barra_Axial(E,A_3,Le);      %elemento 3

%% Ensamblamos la matriz de rigidez
K=zeros(4,4);     %inicializamos la matriz global
Delta_K_1=zeros(4,4);
Delta_K_1(g_1,g_1)=ke_1;
K=K+Delta_K_1;

Delta_K_2=zeros(4,4);
Delta_K_2(g_2,g_2)=ke_2;
K=K+Delta_K_2;

Delta_K_3=zeros(4,4);
Delta_K_3(g_3,g_3)=ke_3;
K=K+Delta_K_3;

a=1 ; b=[2 3 4];

K_aa=K(a,a) ; K_ab=K(a,b); K_ba=K(b,a); K_bb=K(b,b);

%% Definimos el vector de fuerzas externas
P=[0 0 0 -12]';
P_b=P(b);

%% Encontramos los desplazamientos para los grados de libertad no restringidos
D_b=K_bb\P_b;

%% Reaccion en el apoyo
P_a=K_ab*D_b;

% Obs�rvese que los desplazamientos de los grados de libertad que forman el vector Db son negativos, lo
% que indica el estado de compresi�n de la estructura en su conjunto. Adem�s, crecen en valor absoluto,
% debido al decrecimiento del �rea seccional hacia arriba. Por otra parte, n�tese que el valor de la
% reacci�n es igual al de la fuerza externa aplicada y de signo positivo, lo que demuestra que la estructura
% se encuentra en perfecto equilibrio.

%% Fuerzas internas
D=zeros(4,1);
D(b)=D_b;

d_1=D(g_1)
p_1=ke_1*d_1

d_2=D(g_2)
p_2=ke_2*d_2

d_3=D(g_3)
p_3=ke_3*d_3




