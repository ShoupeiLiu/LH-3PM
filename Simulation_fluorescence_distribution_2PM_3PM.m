clc;
clear;
close all;
 
wavelength_2P = 0.92; % The two-photon excitation wavelength is set to 920 nm.
wavelength_3P = 1.3; % The three-photon excitation wavelength is set to 1300 nm.
le_2P = 150; % The effective attenuation length at 920 nm is set at 150 μm.
le_3P = 300; % The effective attenuation length at 1300 nm is set at 300 μm.
w0 = 3.5; % The beam waist is set to 3.5 μm.
r = linspace(-120,120,4001); % The length of the canvas is 240 μm.
z = linspace(-1000,300,5204); % The width of the canvas is 1300 μm.

P0 = 1; % Set the excitation power at the surface.
P_z_2P = P0*exp(-z/le_2P); % Calculate the power at different depths under two-photon excitation.
P_z_3P = P0*exp(-z/le_3P); % Calculate the power at different depths under three-photon excitation.
z_r_2P = pi*w0^2/wavelength_2P; % Calculate Rayleigh length.
w_z_2P = w0*sqrt(1+(z/z_r_2P).^2); % Calculate the beam radius at different depths.
I_z_2P = zeros(length(z),length(r)); % Set excitation intensity matrix under two-photon excitation.
for i = 1:length(z)
    I_z_2P(i,:) = (2*P_z_2P(i)./(pi.*w_z_2P(i).^2)).*exp(-2*r.^2./w_z_2P(i).^2);
end % Calculate excitation intensity matrix under two-photon excitation.
fluorescence_2P = I_z_2P.^2;% Calculate signal intensity matrix under two-photon excitation.
fluorescence_2P = (fluorescence_2P-min(min(fluorescence_2P)))/(max(max(fluorescence_2P))-min(min(fluorescence_2P)));
% The fluorescence intensity profiles under two-photon excitation are normalized.
figure,imshow(fluorescence_2P,[]);
colormap('turbo');
caxis([0 1]); % Set the range of caxis and adjust the relationship between color mapping and data values.

%%% Set the vertical axis.
ax = gca;
ax.Visible = 'on';
ax.YTick = [800,1600,2400,3200,4000,4800];
ax.YTickLabel = {'200','400','600','800','1000',''};
ylabel('Depth (μm）');
ax.XTick = [];
ax.XTickLabel = {};

h1=legend('');
set(h1,'box','off');
set(gca,'Box','off');
set(gca,'tickdir','out');
set(gca,'FontSize',12);

fluorescence_2P_sum = sum(fluorescence_2P,2); % Calculate the sum of fluorescence intensity at each depth.
signal = sum(fluorescence_2P_sum(3500:4500)); % Calculate the signal intensity of the focus.
SBR_2P = []; % Construct the signal-to-noise ratio matrix.
depth_2P = []; % Construct the depth matrix.

for i = 1:850
    depth_2P(i) = 150+i;
    start_number = 4001-depth_2P(i)*4;
    background = sum(fluorescence_2P_sum(start_number:3500));
    SBR_2P(i) = signal/background; % Calculate the signal-to-noise ratio.
end

z_r_3P = pi*w0^2/wavelength_3P; % Calculate Rayleigh length.
w_z_3P = w0*sqrt(1+(z/z_r_3P).^2); % Calculate the beam radius at different depths.
I_z_3P = zeros(length(z),length(r)); % Set excitation intensity matrix under three-photon excitation.
for i = 1:length(z)
    I_z_3P(i,:) = (2*P_z_3P(i)./(pi.*w_z_3P(i).^2)).*exp(-2*r.^2./w_z_3P(i).^2);
end % Calculate excitation intensity matrix under three-photon excitation.
fluorescence_3P = I_z_3P.^3; % Calculate signal intensity matrix under three-photon excitation.
fluorescence_3P = (fluorescence_3P-min(min(fluorescence_3P)))/(max(max(fluorescence_3P))-min(min(fluorescence_3P)));
% The fluorescence intensity profiles under three-photon excitation are normalized.
figure,imshow(fluorescence_3P,[]);
colormap('turbo');
caxis([0 1]);
%%% Set the vertical axis.
ax = gca;
ax.Visible = 'on';
ax.YTick = [800,1600,2400,3200,4000,4800];
ax.YTickLabel = {'200','400','600','800','1000',''};
ylabel('Depth (μm）');
ax.XTick = [];
ax.XTickLabel = {};

h1=legend('');
set(h1,'box','off');
set(gca,'Box','off');
set(gca,'tickdir','out');
set(gca,'FontSize',12);
figure

fluorescence_3P_sum = sum(fluorescence_3P,2); % Calculate the sum of fluorescence intensity at each depth.
signal = sum(fluorescence_3P_sum(3500:4500)); % Calculate the signal intensity of the focus.
SBR_3P = []; % Construct the signal-to-noise ratio matrix.
depth_3P = []; % Construct the depth matrix.

for i = 1:850
    depth_3P(i) = 150+i;
    start_number = 4001-depth_3P(i)*4;
    background = sum(fluorescence_3P_sum(start_number:3500));
    SBR_3P(i) = signal/background; % Calculate the signal-to-noise ratio.
end
SBR_3P = 10*log(SBR_3P);
SBR_2P = 10*log(SBR_2P);
plot(depth_2P,SBR_2P,'LineWidth',1.5);
hold on
plot(depth_3P,SBR_3P,'LineWidth',1.5);
ylabel('Signal-to-background ratio (dB)');
h1=legend('Two-photon','Three-photon');
xlabel('Depth (μm)');
set(h1,'box','off');
set(gca,'Box','off');
set(gca,'tickdir','out');
set(gca,'FontName','Arial','FontSize',12);
xlim([150 1000]);
