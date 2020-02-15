function [hv] = SETrangeH(n)
hv=logspace(-2,1.2,100); 
if n == 25; hv=logspace(-2,1.2,100); end 
if n == 50; hv=logspace(-1.8,1.1,100); end
if n == 100; hv=logspace(-2,1,100); end
if n == 500; hv=logspace(-2,0,50); end
if n == 1000; hv=logspace(-2,1.2,50); else


    



% switch name
%     case 'D1a'
%         hv=linspace(0.01,hf.PI.SV*5,100);
%     case 'D1b'
%         hv=linspace(0.01,hf.PI.SV*5,100);
%     case 'D1c'
%         hv=linspace(0.01,hf.PI.SV*5,100);
%     case 'D1d'
%         hv=linspace(0.01,hf.PI.SV*5,100);
%     case 'D2a'
%         hv=linspace(0.01,hf.PI.SV*5,100);
%     case 'D2b'
%         hv=linspace(0.01,hf.PI.SV*5,100);
%     case 'D2c'
%         hv=linspace(0.01,hf.PI.SV*5,100);
%     case 'D2d'
%         hv=linspace(0.01,hf.PI.SV*5,100);
%     case 'D3a'
%         hv=linspace(0.01,hf.PI.SV*5,100);
%     case 'D3b'
%         hv=linspace(0.01,hf.PI.SV*5,100);
%     case 'D3c'
%         hv=linspace(0.01,hf.PI.SV*5,100);
%     case 'D3d'
%         hv=linspace(0.01,hf.PI.SV*5,100);
%     case 'D4a'
%         hv=logspace(-1.5,1,50);
%     case 'D4b'
%         hv=logspace(-1.5,1,50);
%     case 'D4c'
%        hv=logspace(-1.5,1,50);
%     case 'D4d'
%         hv=logspace(-1.5,1,50);
%     otherwise
%         hv=linspace(0.01,hf.PI.SV*5,100);
% end

end