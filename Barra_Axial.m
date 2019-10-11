function [k]=Barra_Axial(E,A,Le)

k=E*A/Le*[1 -1;-1 1];