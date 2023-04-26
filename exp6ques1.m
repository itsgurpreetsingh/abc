clc
clear all
format short
% To solve the LPP by Simplex Method
% Maximize z=-2x1-x3
% Subject to x1+x2-x3>=5
% x1-2x2+4x3>=0
Variables={'x_1','x_2','x_3','s_1','s_2','sol'};
Cost=[-2,0,-1,0,0,0];
Info=[-1,-1,1;-1,2,-4];
b=[-5;-8];
s=eye(size(Info,1));
A=[Info s b]
%% To find the starting BFS
BV=[];
for j=1:size(s,2)
    for i=1:size(A,2)
        if A(:,i)==s(:,j)
            BV=[BV i];
        end 
    end
end
fprintf('The Basic Variables (BV)');
disp(Variables(BV))
%% To compute Z-Row(zj-cj)
ZjCj=Cost(BV)*A-Cost;
%% To print the table
ZCj=[ZjCj;A];
SimpTable=array2table(ZCj);
SimpTable.Properties.VariableNames(1:size(ZCj,2))=Variables;
%% Dual Simplex Starts 
Run=true;
while  Run 
sol=A(:,end);
if any(sol<0)
    fprintf('The current BFS is not Feasible \n');
%% Finding the leaving Variable 
[Leaving_Value Pvt_Row]=min(sol);
fprintf('Leaving Row=%d \n',Pvt_Row);
%% Finding the Entering Variable
Row=A(Pvt_Row,1:end-1);
ZRow= ZjCj(:,1:end-1);
for i=1:size(Row,2)
    if Row(i)<0
        ratio(i)=abs(ZRow(i)./Row(i));
    else
        ratio(i)=inf;
    end 
end 
[MinRatio, Pvt_Col]=min(ratio);
fprintf('Entering Variable is %d \n',Pvt_Col)
BV(Pvt_Row)=Pvt_Col;
fprintf('Basic Variable (BV) =')
disp(Variables(BV))
Pvt_Key=A(Pvt_Row,Pvt_Col)
A(Pvt_Row,:)=A(Pvt_Row,:)./Pvt_Key
for i=1:size(A,1)
    if i~=Pvt_Row
        A(i,:)=A(i,:)-A(i,Pvt_Col).*A(Pvt_Row,:);
    end
    ZjCj=ZjCj-ZjCj(Pvt_Col).*A(Pvt_Row,:);
    ZCj=[ZjCj;A];
    SimpTable=array2table(ZCj);
    SimpTable.Properties.VariableNames(1:size(ZCj,2))=Variables
end
else
    Run=false
    fprintf('Current BFs is feasible \n')
end 
end
Final_BFS=zeros(1,size(A,2))
Final_BFS(BV)=A(:,end)
Final_BFS(end)=sum(Final_BFS.*Cost)
OptimalBFS=array2table(Final_BFS)
OptimalBFS.Properties.VariableNames(1:size(OptimalBFS,2))=Variables