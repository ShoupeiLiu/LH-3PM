clc;
clear;
tic;

theta = linspace(0,110,100);
collection_efficiency = (1-cos(theta/180*pi))/2*100;
figure;
plot(theta,collection_efficiency);


ylim([-5 70]);
xlim([-5 110]);
xlabel('Half angle of light cone (°)');
ylabel('Photon collection efficiency (%)');
h1=legend('');
set(h1,'box','off');
set(gca,'Box','off');
set(gca,'tickdir','out');
set(gca,'FontSize',14);