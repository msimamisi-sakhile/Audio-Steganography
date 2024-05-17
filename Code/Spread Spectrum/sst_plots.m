% Visualization

% Calc the time axis
N = length(x);
t = (0:N-1) / Fs; % Time axis

% Perform FFT on the original audio signal
X_original = fft(x);
X_modified = fft(modified_audio);

% Frequency axis for FFT plots
f = (0:N-1) * (Fs / N); % Frequency axis

% Create a new figure window
figure;

% Original audio signal (time domain)
subplot(4, 2, 1);
plot(t, x);
xlabel('Time (s)');
ylabel('Amplitude');
title('Original Audio: Time-domain Waveform');

% Modified audio signal (time domain)
subplot(4, 2, 2);
plot(t, modified_audio);
xlabel('Time (s)');
ylabel('Amplitude');
title('Modified Audio (After Encoding): Time-domain Waveform');

% Original audio signal (frequency domain)
subplot(4, 2, 3);
plot(f, abs(X_original));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Original Audio: Magnitude Spectrum of FFT Coefficients');

% Modified audio signal (frequency domain)
subplot(4, 2, 4);
plot(f, abs(X_modified));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Modified Audio (After Encoding): Magnitude Spectrum of FFT Coefficients');

% Plot of message binary (before encoding)
subplot(4, 2, 5);
stem(binary_message, 'filled');
xlabel('Bit Index');
ylabel('Binary Value');
title('Message Binary Data (Before Encoding)');

% Plot of message binary (after decoding)
subplot(4, 2, 6);
stem(extracted_binary_message, 'filled');
xlabel('Bit Index');
ylabel('Binary Value');
title('Extracted Message Binary Data (After Decoding)');

% Plot the difference between original and extracted binary message
subplot(4, 2, [7 8]);
stem(binary_message - extracted_binary_message, 'filled');
xlabel('Bit Index');
ylabel('Difference');
title('Difference Between Original and Extracted Binary Data (0 = similar, 1 = different)');

% Overall title for the entire figure
sgtitle('Comparison of Time and Frequency Domains, and Message Binary Data (Before and After Encoding)');