function createfigure(X1, Y1, XData1, YData1, X2, Y2, YData2)
%CREATEFIGURE(X1, Y1, XDATA1, YDATA1, X2, Y2, YDATA2)
%  X1:  x 数据的矢量
%  Y1:  y 数据的矢量
%  XDATA1:  line xdata
%  YDATA1:  line ydata
%  X2:  x 数据的矢量
%  Y2:  y 数据的矢量
%  YDATA2:  line ydata

%  由 MATLAB 于 21-Jul-2021 12:20:24 自动生成

% 创建 figure
figure1 = figure;

% 创建 subplot
subplot1 = subplot(1,2,1,'Parent',figure1);
hold(subplot1,'on');

% 创建 plot
plot(X1,Y1,'Parent',subplot1,'MarkerSize',8,'Marker','o','LineStyle','none');

% 创建 line
line(XData1,YData1,'Parent',subplot1);

% 创建 text
text('Parent',subplot1,'String','max error = 26.9471',...
    'Position',[-0.5 -0.5 0]);

% 创建 xlabel
xlabel('x','FontSize',11);

% 创建 title
title('Equidistant point','FontSize',11);

% 创建 ylabel
ylabel('u(x)','FontSize',11);

% 取消以下行的注释以保留坐标轴的 X 范围
% xlim(subplot1,[-1.1 1.1]);
% 取消以下行的注释以保留坐标轴的 Y 范围
% ylim(subplot1,[-1 1.5]);
box(subplot1,'on');
% 创建 subplot
subplot2 = subplot(1,2,2,'Parent',figure1);
hold(subplot2,'on');

% 创建 plot
plot(X2,Y2,'Parent',subplot2,'MarkerSize',8,'Marker','o','LineStyle','none');

% 创建 line
line(XData1,YData2,'Parent',subplot2);

% 创建 text
text('Parent',subplot2,'String','max error = 0.0066681',...
    'Position',[-0.5 -0.5 0]);

% 创建 xlabel
xlabel('x','FontSize',11);

% 创建 title
title('Chebyshev point','FontSize',11);

% 创建 ylabel
ylabel('u(x)','FontSize',11);

% 取消以下行的注释以保留坐标轴的 X 范围
% xlim(subplot2,[-1.1 1.1]);
% 取消以下行的注释以保留坐标轴的 Y 范围
% ylim(subplot2,[-1 1.5]);
box(subplot2,'on');
