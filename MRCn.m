clear X Z Y PHI z1 z2
close all

T=0.005;
tf=10;

n=76;%76
a=5;
x=a*(2*rand(n,1)-1);
xf=a*(2*rand(n,1)-1);
y=a*(2*rand(n,1)-1);
yf=a*(2*rand(n,1)-1);

%We want to drive the robots to the following formation
xf=[linspace(-4,-3,9) linspace(-3,-2,9) [-3.15 -2.85] -.5*ones(1,9) ...
    .75 1*ones(1,7) .75 [-1:.5:0.5] [-1:.5:0.5] 3*ones(1,9) [2:.5:4] [2:.5:4]...
    [5.2:.5:5.2] [5.2:.5:5.2] 6.3-.05*linspace(4,-4,9).^2]';
yf=[linspace(-4,4,9) linspace(4,-4,9) zeros(1,2) linspace(4,-4,9)...
    3.5 linspace(3,-3,7) -3.5 -4*ones(1,4) 4*ones(1,4) linspace(4,-4,9) -4*ones(1,5) 4*ones(1,5)...
    0.5*ones(1,1) -0.5*ones(1,1) linspace(4,-4,9)]';


phi=a*(2*rand(n,1)-1);
l=[1:n]'/sqrt(n);
L=diag(l);
wo=1.5*sqrt(n);
w1=2*sqrt(n);
w2=2.5*sqrt(n);
A=[zeros(n), -L; L, zeros(n)];
B=[zeros(n,1);ones(n,1)];
Q=120*eye(2*n); R=1;

K0=lqr(wo*A,B,Q,R);
K1=lqr(w1*A,B,Q,R);
K2=lqr(w2*A,B,Q,R);

it=(1:tf/T)*T;
itY=it;
simp=0;
%%
for j=1:tf/T
        z1=-(x-xf).*sin(phi)+(y-yf).*cos(phi);
        z2=(x-xf).*cos(phi)+(y-yf).*sin(phi);
        h=1/(2*n)*sum((x-xf).^2+(y-yf).^2);
        %u=-7*a^2+(3*zf*a^3-g*a)/b-10*a^3*b/g;
        %u=max(u,0);u=mi2(u,1);
    
%       xd(i)=v*cos(phi(i));
%       yd(i)=v*sin(phi(i));
%       phid(i)=l(i)*w;
        
        z=[z1;z2];
%         if h>10
%             v=-K0*z;
%             w=wo;
%         elseif h>2
%             v=-K1*z;
%             w=w1;
%         else
%             v=-K2*z;
%             w=w2;
%         end
        w=wo;
        v=-K0*z;
        x=x+T*v*cos(phi);
        y=y+T*v*sin(phi);
        phi=phi+T*l*w;
        hold off,
        plot([x x+a/20*[cos(phi)]]',[y y+a/20*[sin(phi)]]','r'), hold on
        plot(x,y,'or')
        %plot(xf,yf,'xb','LineWidth',2)
        %plot(0,0,'xb')
        axis([-a 7 -a a])
        pause(0.00000001)
        Z(:,j)=[z1;z2];
        X(:,j)=x;
        Y(:,j)=y;
        PHI(:,j)=phi;
        H(:,j)=h;
        %Xd(:,i)=[xd;zd];
        %U(i)=u;
end
%
figure(2)
plot(Z(1,:));hold on;
plot(Z(2,:));
legend('z1','z2')
figure(3)
plot(H);
figure(4)
plot(H-1/2*(Z(1,:).^2+Z(2,:).^2));
