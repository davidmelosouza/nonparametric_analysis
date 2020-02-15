function [x,y] = ASHmethods(DATA,M,inter,BIN)
% [x,y] = ashN(DATA,M,inter,BIN);
% disp(['Area=' num2str(area2d(x,y))])
[x.fd,y.fd] = ashN(DATA,M,inter,BIN.fd);
[x.scott,y.scott] = ashN(DATA,M,inter,BIN.scott);
[x.sturges,y.sturges] = ashN(DATA,M,inter,BIN.sturges);
[x.doane,y.doane] = ashN(DATA,M,inter,BIN.doane);
[x.knuth,y.knuth] = ashN(DATA,M,inter,BIN.knuth);
[x.wand,y.wand] = ashN(DATA,M,inter,BIN.wand);
[x.shimazaki,y.shimazaki] = ashN(DATA,M,inter,BIN.shimazaki);
[x.rudemo,y.rudemo] = ashN(DATA,M,inter,BIN.rudemo);
[x.LHM,y.LHM] = ashN(DATA,M,inter,BIN.LHM);
[x.truth,y.truth] = ashN(DATA,M,inter,BIN.truth);
end