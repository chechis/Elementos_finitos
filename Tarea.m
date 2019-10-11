%%
clc

close all
%% Datos

cantidadBarras = input('Ingrese numero de barras: ');
gradosLib = zeros(1,cantidadBarras+1);
aux = 1;
g_1 = zeros(cantidadBarras, 2);
[n,m]= size(g_1);

k = zeros(cantidadBarras+1 , cantidadBarras+1);
deltak = zeros(cantidadBarras+1 , cantidadBarras+1);
ke_1 = zeros(2 , cantidadBarras*2);
cambio = zeros(cantidadBarras+1 , cantidadBarras+1);

for p= 1:n
    for j= 1:m
       g_1(p,j) = p+j-1;
    end
end

while(aux <= n)
   
   area = input('Ingrese area: ');
   elasti = input('Ingrese modulo de young: ');
   longitud = input('Ingrese longitud: ');
   ke = Barra_Axial (elasti, area, longitud);
  
   deltak(g_1(aux,:),g_1(aux,:)) =ke;
   ke_1(1:2, aux*2-1:aux*2)= ke;
   
   aux = aux +1;
end

p=1;

if(cantidadBarras > 1)
    while(p <= cantidadBarras-1)
    primero = deltak(p,p);

    cambio(p+1,p+1) = primero;
    
    k = deltak+ cambio;
    p= p+1;
    end
else
    k=deltak;
end

a=1;
b = zeros(1,cantidadBarras);
q=1;
while(q <= cantidadBarras)
   b(q)=q+1;
   q=q+1;
end

k_aa=k(a,a) ; k_ab=k(a,b); k_ba=k(b,a); k_bb=k(b,b);

carga = input('Ingrese carga: ');
p= zeros(1, cantidadBarras+1)';
p(cantidadBarras+1, 1)=carga;

p_b = p(b);

d_b = k_bb\p_b;

p_a=k_ab*d_b;



D=zeros (cantidadBarras+1, 1);
D(b)=d_b;

[s,c]=size(g_1);
graficaD = zeros(cantidadBarras*2,1);
graficaP = zeros(cantidadBarras*2,1);

for i = 1:s
    
    d_1=D(g_1(i,:))
    p_1= ke_1(1:2,i*2-1:i*2)*d_1
    
    graficaD(i*2-1:i*2 , 1) = d_1;
    graficaP(i*2-1:i*2 , 1) = p_1;
    
    

end

    figure;
    bar(1:cantidadBarras*2 , graficaD);
    title('Grafica de deformaciones por grados de libertad');
    figure;
    
    bar(1:cantidadBarras*2 , graficaP);
    title('Grafica de Carga por grados de libertad');
   
