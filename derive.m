function dy = derive(y,dx);
% DERIVE dy=derive(y,dx) computes dy/dx

% Reference:
%    G. Engelen-Muellges / F. Reutter
%    Formelsammlung zur numerischen Mathematik
%    mit Turbo-Pascal-Programmen
%    BI Wissenschaftsverlag Mannheim, 1987
%    p.181-182

% (c) Lehrstuhl fuer allg. Elektrotechnik und Akustik
% Ruhr-Universitaet Bochum
% (p) 27.06.1994 A. Raab

t = 0;
mn = size(y);
if (min(mn) == 1) & (mn(2) > 1)      % if column or row vector
  y = y';                            % make sure its a row vector
  t = 1;                             % set flag for final transposition
  mn = size(y);
end;    
m = mn(1);
n = mn(2);
dy = zeros(mn);
for c = 1 : n                         % for all columns
  if m > 6                            % more than six rows
    dy(1:3,c) = [-147,+360,-450,+400,-225,+72,-10;
                 -10,  -77,+150,-100, +50,-15, +2;
                  +2,  -24, -35, +80, -30, +8, -1] * y(1:7,c)/60;
    dy(4:(m-3),c) = (-1*y(1:(m-6),c) ...
                     +9*y(2:(m-5),c) ...
                    -45*y(3:(m-4),c) ...
                    +45*y(5:(m-2),c) ...
                     -9*y(6:(m-1),c) ...
                     +1*y(7:m,c) )/ 60;
    dy((m-2):m,c) = [ +1, -8, +30, -80, +35, +24,  -2;
                      -2,+15, -50,+100,-150, +77, +10;
                     +10,-72,+225,-400,+450,-360,+147] * y((m-6):m,c) / 60;
  elseif m == 6
    dy(:,c) = [-137,+300,-300,+200, -75, +12 ;
               -12,  -65,+120, -60, +20,  -3 ;
                +3,  -30, -20, +60, -15,  +2 ;
                -2,  +15, -60, +20, +30,  -3 ;
                +3,  -20, +60,-120, +65, +12 ;
               -12,  +75,-200,+300,-300, +137] * y(:,c)/60;
  elseif m == 5
    dy(:,c) = [ -25, +48, -36, +16, -3 ;
                 -3, -10, +18,  -6, +1 ;
                 +1,  -8,   0,  +8, -1 ;
                 -1,  +6, -18, +10, +3 ;
                 +3, -16, +36, -48,+25 ] * y(:,c)/12;
  elseif m == 4
    dy(:,c) = [-11,+18, -9, +2;
                -2, -3, +6, -1;
                +1, -6, +3, +2;
                -2, +9,-18,+11] * y(:,c)/6;
  elseif m == 3
    dy(:,c) = [-3,+4,-1;
               -1, 0,+1;
               +1,-4,+3] * y(:,c)/2;
  elseif m == 2
    dy(1,c) = y(2) - y(1);
    dy(2,c) = dy(1,c);
  else error('less then two data points');
  end;
end;
if t == 1
  dy = dy';
end;
dy = dy/dx;
