% Load the audio file
[x, Fs] = audioread('rickroll.wav');

% Convert the message string to binary
message = 'Never going to give you up!';
binary_message = reshape(dec2bin(message, 8).' - '0', 1, []);

% Ensure the message can fit in the audio file
if length(binary_message) > length(x)
    error('The message is too long to be embedded in the audio file.');
end

% Perform FFT on the audio signal
X = fft(x);

% Embed the binary message signal into the phase of the FFT coefficients
phase_shift = pi/2; 

message_length = length(binary_message);
for i = 1:message_length
    original_phase = angle(X(i+1));
    if binary_message(i) == 0
        new_phase = original_phase - phase_shift;
    elseif binary_message(i) == 1
        new_phase = original_phase + phase_shift;
    end
    X(i+1) = abs(X(i+1)) * exp(1i * new_phase);
    % Debug output for embedding process
    fprintf('Embedding bit %d at position %d: original phase = %.4f, new phase = %.4f, difference factor = %.4f\n', binary_message(i), i+1, original_phase, new_phase, new_phase - original_phase);
end

% Perform inverse FFT to get the modified audio signal
modified_audio = real(ifft(X));

% Normalize the modified audio to prevent clipping
modified_audio = modified_audio / max(abs(modified_audio));

% Write the modified audio to a new file
audiowrite('output_pc.wav', modified_audio, Fs);

% Play the original and modified audio for comparison
sound(x, Fs);
pause(length(x)/Fs);
sound(modified_audio, Fs);
