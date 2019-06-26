function [A, B, sA, sB] = LeastSquares_fit(xdata,ydata,xerr,yerr)
%Least-Squares Fitting function 
%Author: Kurt Burdick
%date modified: 2/27/2019
%
%Make sure to change the labels of your graph
%
%Inputs:
%   xdata - array of xdata
%   ydata - array of ydata
%   xerr - array of x error 
%   yerr - array of y error
%
%Outputs: 
%   B - slope
%   A - intercept
%   sB - error in slope
%   sA - error in intercept
%   use disp(x) to print data
y=ydata;
x=xdata;

% N is changed for the number of measurements
%do all the sums first
%S(x)
sumX = sum(x,1);

%S(y)
sumY = sum(y,1);

%S(x^2)
sumXsquared = sum(x.*x);

%do i need this?
sumofX_squared = (sum(x)^2);

%S(xy)
sumXY = sum(x.*y);

%get correct N value
N = length(x);

%delta denominator
delta = (N*(sumXsquared)-(sumofX_squared));     

%Y-intercept
A = (((sumXsquared*sumY)-(sumX*sumXY))/delta);     

%slope
B = (((N*sumXY)-(sumX*sumY))/delta);              

%sigma y calculation
%S5=sum((y-a-b.*x).^2);
sum5 = sum((y-A-B.*x).^2);                    
yerr = sqrt(sum5/(N-2));    %fixed sigma y calculation 3/2  

%Make sure to change the size of the error array
sigmaY = zeros(274,1);
for k=1:274
    sigmaY(k) = yerr;
end

%uncertainty in y-int
sA = (sigmaY*(sqrt(sumXsquared/delta))); 

%uncertainty in slope
sB = (sigmaY*(sqrt(N/delta)));

%begin plotting
close all
figure

%plot data with horizontal and vertical error bars
%errorbar(xdata, ydata, sigmaY, 'o', 'MarkerSize', 4);
%herrorbar(xdata, ydata, xerr, 'o');
xlabel('Time (s)', 'FontSize', 16, 'FontWeight', 'Bold');
ylabel('Ln(V) (mV)', 'FontSize', 16, 'FontWeight', 'Bold');
set(gca, 'FontSize', 14, 'FontWeight', 'Bold');
hold on

%plot best fit lines format [x,x],[y,y]
%plot([-4, 4],[14, 55])     % min
%plot([-4, 4],[12, 57])     % max
%plot([-4, 4],[13, 56])    %best fit

%plot Linear fit
p = polyfit(x,y,1);
plot(x, p(1,1)*x + p(1,2));

%plot basic y vs. x graph
plot(x,y);

%Display slope and intercept in command window
slope = p(1,1);
display(slope);
intercept = p(1,2);
display(intercept);
display(A);
display(sA);
display(B);
display(sB);
display(yerr);

%LeastSquares_fit(t,x,terr,xerr)
end

