clear
format compact
% -----------------------
m2 = 4.00e-03;
l2 = 7.10e-02;
g  = 9.81e+00;
Tf2 = 0.025;
% -----------------------
load ident_pend_data
% -----------------------
t_data = t;
phi2_data = phi2;
clear t phi2
% -----------------------
k = 0;
tmin = 5;
tmax = 10;
for i = 1:length(t_data)
    if t_data(i) >= tmin & t_data(i) <= tmax
        k = k + 1;
        t(k)    = t_data(i) - tmin;
        phi2(k) = phi2_data(i);
    end
end

% ++++++++++ Step 2 ++++++++++
h = t(2) - t(1);
k = length(t);
% -----------------------
dphi2(1) = (- 3*phi2(1) + 4*phi2(2) - phi2(3))/(2*h);
for i = 2:k-1
    dphi2(i) = (phi2(i+1) - phi2(i-1))/(2*h);
end
dphi2(k) = (phi2(k-2) - 4*phi2(k-1) + 3*phi2(k))/(2*h);
% -----------------------
ddphi2(1) = (- 3*dphi2(1) + 4*dphi2(2) - dphi2(3))/(2*h);
for i = 2:k-1
  ddphi2(i) = (dphi2(i+1) - dphi2(i-1))/(2*h);
end
ddphi2(k) = (dphi2(k-2) - 4*dphi2(k-1) + 3*dphi2(k))/(2*h);

% ++++++++++ Step 3 ++++++++++
t = t';
phi2   = phi2';
dphi2  = dphi2';
ddphi2 = ddphi2';
% ---------------------
sim('pend_MN_sim')

% ++++++++++ Step 4 ++++++++++
p2 = inv(Mfs2'*Mfs2)*Mfs2'*Nfs2;
J2b = p2(1);
c2  = p2(2);
J2  = J2b - m2*l2^2;

fprintf('J2 = %3.2e\n',J2)
fprintf('c2 = %3.2e\n',c2)

% ---------------------
[A1 imax] = max(phi2);

imax_last = imax;
for i = imax:length(t)
    if phi2(i) == A1
        imax_last = i;
    end
    if phi2(i) < A1
        break
    end
end
tb1 = (t(imax) + t(imax_last))/2;

phi20 = A1;
sim('pend_free_sim')

figure(1)
stairs(t,phi2*180/pi,'b','linewidth',2)
hold on
plot(t_sim+tb1,phi2_sim*180/pi,'r')
plot(tb1,phi20*180/pi,'ko','linewidth',2,'markersize',10)
hold off

xlim([0 tmax-tmin]); ylim([-100 100])

set(gca,'fontname','arial','fontsize',20)
xlabel('$$t$$ [s]', 'interpreter', 'latex','fontsize',24)
ylabel('$${\phi}_{2}(t)$$ [deg]', 'interpreter', 'latex','fontsize',24)

legend({'Experiment','Nonlinear Simulation'}, 'interpreter', 'latex', 4)
set(legend,'fontsize',22)

set(gca,'xtick',0:1:tmax-tmin)
set(gca,'ytick',-90:45:90)

% print -deps figure_ident_pend_least_square.eps

