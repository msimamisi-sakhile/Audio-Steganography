% Extract the embedded message from the modified audio
% Load the modified audio file
[y, Fs] = audioread('output_sst.wav');

% Perform FFT on the modified audio signal
Y = fft(y);

% Perform FFT on the sterile(no data) audio signal
sterile_signal = x;
S = fft(sterile_signal);

% Extract the binary message from the FFT coefficients
extracted_binary_message = zeros(1, message_length);
for i = 1:message_length
    if abs(Y(i+1)) / abs(S(i+1)) > 1.5
        extracted_binary_message(i) = 1;
    else
        extracted_binary_message(i) = 0;
    end
    % Debug output for extraction process
    fprintf('Extracting bit at position %d: extracted magnitude = %.4f, original magnitude = %.4f, difference factor = %.4f, extracted bit = %d\n', i+1, abs(Y(i+1)), abs(S(i+1)), abs(Y(i+1))/abs(S(i+1)), extracted_binary_message(i));
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
