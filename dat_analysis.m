clear, close all

%% Read Data in

bode_ninv = readtable('bodeplot_20240924_180229_noninvert.csv');
bode_instr = readtable('bode_20240927_115300_Instrument.csv');

%% Vars

dbgain_ninv = 20*log10(bode_ninv.Mag_Response1);
ninv_maxG = max(dbgain_ninv);
[~,cutoff_freq_idx] = min(abs(dbgain_ninv - (ninv_maxG-3)));

freq_log = log10(bode_ninv.X__Trace1___AC_FREQUENCY_);
fprintf("Cutoff Frequency at %.f with gain %.2f and phase %.2f\n", ...
    bode_ninv.X__Trace1___AC_FREQUENCY_(cutoff_freq_idx), ...
    dbgain_ninv(cutoff_freq_idx), ...
    bode_ninv.Phase_Response1(cutoff_freq_idx));

%% Plotting Figures

subplot(3,1,1);
hold;
plot(freq_log,dbgain_ninv,'k','LineWidth',2);
plot(freq_log,ones(length(freq_log)) * (dbgain_ninv(cutoff_freq_idx)),'b','LineWidth',2);
plot(ones(length(freq_log)) * freq_log(cutoff_freq_idx),dbgain_ninv,'--r','LineWidth',2);

legend("","","Cutoff Frequency (-3 dB)");
ylim([min(dbgain_ninv) - 5,max(dbgain_ninv) + 5]);
title("Bode Plot for Frequency Response of LM741 Gain[dB]");
xlabel("log(Frequency)");
ylabel("Gain [dB]");

set(gca,'FontSize',22,'fontWeight','bold') % Set font for all other text in figure
set(findall(gcf, 'type', 'text'), 'FontSize', 22, 'fontWeight', 'bold');

subplot(3,1,2);
hold;
plot(freq_log,bode_ninv.Mag_Response1,'k','LineWidth',2);
plot(freq_log,ones(length(freq_log)) * bode_ninv.Mag_Response1(cutoff_freq_idx),'b','LineWidth',2);

ylim([min(bode_ninv.Mag_Response1) - 5,max(bode_ninv.Mag_Response1) + 5]);
title("Bode Plot for Frequency Response of LM741 Gain Magnitude");
xlabel("log(Frequency)");
ylabel("Gain");

set(gca,'FontSize',22,'fontWeight','bold') % Set font for all other text in figure
set(findall(gcf, 'type', 'text'), 'FontSize', 22, 'fontWeight', 'bold');

subplot(3,1,3);
hold;
plot(freq_log,bode_ninv.Phase_Response1,'k','LineWidth',2);

ylim([min(bode_ninv.Phase_Response1) - 20,max(bode_ninv.Phase_Response1) + 20]);
title("Bode Plot for Frequency Response of LM741 Phase");
xlabel("log(Frequency)");
ylabel("Gain");

set(gca,'FontSize',22,'fontWeight','bold') % Set font for all other text in figure
set(findall(gcf, 'type', 'text'), 'FontSize', 22, 'fontWeight', 'bold');
