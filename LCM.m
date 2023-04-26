clc
clear all
format short
%Least Cost Method
cost = [11 20 7 8; 21 16 10 12; 8 12 18 9];
A = [50; 40; 70];
B = [30 25 35 40];

%Check balanced/unbalanced
if sum(A) == sum(B)
    fprintf('Given TP is balanced')
else
    fprintf('Given TP is unbalanced')
    if sum(A) > sum(B)
        cost(:, end + 1) = zeros(size(A,1), 1);
        B(end + 1) = sum(A) - sum(B);
    elseif  sum(A) < sum(B)
        cost(end + 1, :) = zeros(1, size(B,2));
        A(end + 1) = sum(B) - sum(A);
        end
end
Icost = cost;
[m, n] = size(Icost);
BFS = m + n - 1;
X = zeros(size(Icost));
for i = 1: size(Icost, 1)
    for j = 1:size(Icost, 2)
    hh = min(Icost(:));
    [Row_index, Col_index] = find(hh == Icost);
      x11 = min(A(Row_index)',B(Col_index));
   [Value, index] = max(x11);
     ii = Row_index(index);
     jj = Col_index(index);
     y11 = min(A(ii), B(jj));
     X(ii, jj) = y11;
     A(ii) = A(ii) - y11;
     B(jj) = B(jj) - y11;
     Icost(ii, jj) = inf;
    end 
end

%To print BFS
IBFS = array2table(X)

%To check degenerate/nodegenerate
TotalBFS = length(nonzeros(X))
if TotalBFS == BFS
    fprintf('The IBFS is nondegenrate')
else
     fprintf('The IBFS is degenrate')
end

%To calculate initial objective function value
InitialCost = sum(sum(cost.*X))