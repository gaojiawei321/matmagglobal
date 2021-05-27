clear; close; clc

%{
fileID = fopen('CALS7k.2');
A = fgetl(fileID);
A = fgetl(fileID);

formatSpec = '%c' ;

fs1 = fscanf(fileID,formatSpec)
%A = fgetl(fileID);
%B = fgetl(fileID);
% = fgetl(fileID);
%}


%%

% read the data from CALS7k.2 (delimited and numeric matrix)

C0=CALS7K(2,4:6);


C1=CALS7K(3:35,1:4);
%C1(33,4)=0;

C2=reshape(C1',[],1);


CALS_knots=[C0  C2'];

% last one is zero
CALS_knots=CALS_knots(1:134);


save CALS_knots CALS_knots
%%


C3=CALS7K(36:end,1:4);

C4=reshape(C3',[],1);

n1=isnan(C4);

z1=find(n1==1);

C5=C4;
C5(z1)=[];

C6=reshape(C5,120,130);

CALS_coeffs=C6';


save CALS_coeffs CALS_coeffs

%%
