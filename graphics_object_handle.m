set(0, 'DefaultFigureCreateFcn', 'disp(''Hello world'')');

fig = figure();
ax(1) = subplot(1,2,1);
ax(2) = subplot(1,2,2, 'Parent',fig);

x = linspace(0,2,20);
o1 = plot(x,exp(x));
[~,o2] = contour(ax(1),peaks);
set(ax(2), 'nextplot', 'add');
o3 = plot(ax(2),x, exp(2*x));

type_o3 = get(o3, 'type');
allChildFig = allchild(fig);
anc_o1 = ancestor(o1, 'axes');
anc_o2 = ancestor(o2, 'figure');

%% Tasks
% Resize figure
set(fig, 'Position', [440 205 883 573]);
% Use log scale on y-axis for ax(2)
set(ax(2), 'YScale', 'log');
% Reverse direction of x-axis for ax(2)
set(ax(2), 'Xdir', 'reverse');
% Remove ticks and labels from ax(1)
set(ax(1), 'xtick', []);
set(ax(1), 'ytick', []);
% Change colormap on ax(1) to bone
colormap(ax(1), bone);
% For o2 remove lines between contour levels
set(o2, 'LineStyle', '--');
% For o1 make line thick and dashed
set(o1, 'LineWidth', 2, 'LineStyle', '-.');
% For o3 use o markers with faces of color and black edges
set(o3, 'marker', 'o','markeredgecolor', 'k', 'markerfacecolor', [0.8,0.8,0.8]);

%% Add Legends / Labels
% Add xlabel firstx to ax1 with size 16 font
xlabel(ax(1), 'first x', 'FontSize', 16);
% add ylabel second y to ax(2) in blue
ylabel(ax(2), 'second y', 'Color', 'b');
% add title "contour plot" to ax(1) in font Times
title(ax(1), 'contour plot', 'FontName', 'Times New Roman');

leg = legend([o3,o1], '$exp(2x)$', '$exp(x)$');
set(leg, 'interpreter', 'latex');

%% callbacks
set(o2, 'ButtonDownFcn', @morelines);
set(o2, 'DeleteFcn', 'disp(''Goodbye cruel world'');');
set(o1, 'ButtonDownFcn', @cyclecolor);

%% reset root
set(0,'DefaultFigureCreateFcn', []);