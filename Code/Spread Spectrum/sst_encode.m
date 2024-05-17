% Load the audio file
[x, Fs] = audioread('rickroll.wav');

% Convert the message string to binary
message = 'Never gonna!'; 
binary_message = reshape(dec2bin(message, 8).' - '0', 1, []);

% Perform FFT on the audio signal
X = fft(x);

% Embed the binary message signal into the magnitude of the FFT coefficients
scaling_factor = 0.5; % Adjust this scaling factor to control the embedding strength
message_length = length(binary_message);
for i = 1:message_length
    if binary_message(i) == 0
        X(i+1) = X(i+1) - scaling_factor * abs(X(i+1));
    else
        X(i+1) = X(i+1) + scaling_factor * abs(X(i+1));
    end
end

% Perform inverse FFT to get the modified audio signal
modified_audio = real(ifft(X));


% Write the modified audio to a new file
audiowrite('output_sst.wav', modified_audio, Fs);

% Play the original and modified audio for comparison
sound(x, Fs);
pause(length(x)/Fs);
sound(modified_audio, Fs);



