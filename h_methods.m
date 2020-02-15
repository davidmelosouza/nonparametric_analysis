function [h] = h_methods(setup,DATA)
tic
[h] = h_plugin(DATA.sg.evt);
plugin_time=toc;
tic
[h] = h_CVfull(setup,DATA,h);
CV_time=toc;
disp(['EVT:' num2str(length(DATA.sg.evt)) '<|>PI-TIME:' num2str(plugin_time) '<|>CV-TIME:' num2str(CV_time) ' ->SIZE[' num2str(size(DATA.sg.evt,1)) 'x' num2str(size(DATA.sg.evt,2)) ']' ])
% tic
% [hu] = h_CVultrafast(DATA,h);
% % h.CV
% % hu.CV
% CVultra_time=toc
end