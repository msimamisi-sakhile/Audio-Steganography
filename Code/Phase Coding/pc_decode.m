% Extract the embedded message from the modified audio
% Load the modified audio file
[y, Fs] = audioread('output_pc.wav');

% Perform FFT on the modified audio signal
Y = fft(y);

% Perform FFT on the sterile (original) audio signal
sterile_signal = x;
S = fft(sterile_signal);

% Extract the binary message from the FFT coefficients
extracted_binary_message = zeros(1, message_length);

for i = 1:message_length
    original_phase = angle(S(i+1));
    modified_phase = angle(Y(i+1));
    phase_diff = modified_phase - original_phase;

    if phase_diff >= 0.1*floor(0.5 * phase_shift*10)
        extracted_binary_message(i) = 1;
    elseif phase_diff <= round(0.5 * phase_shift)
        extracted_binary_message(i) = 0;
    end
    
    % Debug output for extraction process
    fprintf('Extracting bit at position %d: extracted phase = %.4f, original phase = %.4f, difference factor = %.4f, extracted bit = %d\n', i+1, modified_phase, original_phase, phase_diff, extracted_binary_message(i));
end

% Convert the binary message back to the original string
extracted_message = char(bin2dec(char(reshape(extracted_binary_message, 8, []).' + '0'))).';

% Display the extracted message
disp(['Extracted message: ', extracted_message]);

% Check if the extracted message matches the original message
if strcmp(message, extracted_message)
    disp('Steganography was successful!');
else
    disp('Steganography executed with errors.');
end