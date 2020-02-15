function [h] = h_methods_TEST(DATA)
[h] = h_plugin(DATA.sg.evt);
[h] = h_CVfast_TEST(DATA,h);
end