
X_original = fft(x);
X_modified = ifft(modified_audio);

% Calc the time axis
N = length(x);
t = (0:N-1) / Fs; % Time axis

% original and modified signals (time domain)
figure;
subplot(2, 2, 1);
plot(t, x);
xlabel('Time (s)');
ylabel('Amplitude');
title('Original Audio: Time-domain Waveform');

subplot(2, 2, 2);
plot(t, modified_audio);
xlabel('Time (s)');
ylabel('Amplitude');
title('Modified Audio (After Encoding): Time-domain Waveform');

% original and modified signals (frequency domain)
f = (0:N-1) * (Fs / N); % Frequency axis

subplot(2, 2, 3);
plot(f, abs(X_original));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Original Audio: Magnitude Spectrum of FFT Coefficients');

subplot(2, 2, 4);
plot(f, abs(X_modified));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Modified Audio (After Encoding): Magnitude Spectrum of FFT Coefficients');

% Title
sgtitle('Comparison of Time and Frequency Domains (Before and After Encoding)');
