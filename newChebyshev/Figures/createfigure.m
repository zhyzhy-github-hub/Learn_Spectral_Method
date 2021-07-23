function createfigure(X1, Y1, XData1, YData1, X2, Y2, YData2)
%CREATEFIGURE(X1, Y1, XDATA1, YDATA1, X2, Y2, YDATA2)
%  X1:  x ���ݵ�ʸ��
%  Y1:  y ���ݵ�ʸ��
%  XDATA1:  line xdata
%  YDATA1:  line ydata
%  X2:  x ���ݵ�ʸ��
%  Y2:  y ���ݵ�ʸ��
%  YDATA2:  line ydata

%  �� MATLAB �� 21-Jul-2021 12:20:24 �Զ�����

% ���� figure
figure1 = figure;

% ���� subplot
subplot1 = subplot(1,2,1,'Parent',figure1);
hold(subplot1,'on');

% ���� plot
plot(X1,Y1,'Parent',subplot1,'MarkerSize',8,'Marker','o','LineStyle','none');

% ���� line
line(XData1,YData1,'Parent',subplot1);

% ���� text
text('Parent',subplot1,'String','max error = 26.9471',...
    'Position',[-0.5 -0.5 0]);

% ���� xlabel
xlabel('x','FontSize',11);

% ���� title
title('Equidistant point','FontSize',11);

% ���� ylabel
ylabel('u(x)','FontSize',11);

% ȡ�������е�ע���Ա���������� X ��Χ
% xlim(subplot1,[-1.1 1.1]);
% ȡ�������е�ע���Ա���������� Y ��Χ
% ylim(subplot1,[-1 1.5]);
box(subplot1,'on');
% ���� subplot
subplot2 = subplot(1,2,2,'Parent',figure1);
hold(subplot2,'on');

% ���� plot
plot(X2,Y2,'Parent',subplot2,'MarkerSize',8,'Marker','o','LineStyle','none');

% ���� line
line(XData1,YData2,'Parent',subplot2);

% ���� text
text('Parent',subplot2,'String','max error = 0.0066681',...
    'Position',[-0.5 -0.5 0]);

% ���� xlabel
xlabel('x','FontSize',11);

% ���� title
title('Chebyshev point','FontSize',11);

% ���� ylabel
ylabel('u(x)','FontSize',11);

% ȡ�������е�ע���Ա���������� X ��Χ
% xlim(subplot2,[-1.1 1.1]);
% ȡ�������е�ע���Ա���������� Y ��Χ
% ylim(subplot2,[-1 1.5]);
box(subplot2,'on');
