% Load the modified audio file
[modified_audio, Fs] = audioread('output_sst.wav');

% Perform FFT on the modified audio signal
X_modified = fft(modified_audio);

% Extract the encoded message from the magnitude of the FFT coefficients
message_length = 100; % Length of the message
binary_message = zeros(1, message_length);
for i = 1:message_length
    % Check if the magnitude is greater than a threshold 
    if abs(X_modified(i+1)) > 0.5
        binary_message(i) = 1;
    else
        binary_message(i) = 0;
    end
end

% Convert the binary message back to its string representation
binary_message_str = num2str(binary_message);
padding_length = mod(8 - rem(length(binary_message_str), 8), 8);
binary_message_str = [repmat('0', 1, padding_length), binary_message_str];
binary_message_str = reshape(binary_message_str, 8, []).';
decoded_message = char(bin2dec(binary_message_str))';

disp('Decoded Message:');
disp(decoded_message);
