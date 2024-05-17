%BIT ERROR RATE

% Example binary strings
original_msg = message;
decoded_msg = decoded_message;

if size(original_msg) == size(decoded_msg)
    % Calculate number of bit errors
    num_errors = sum(original_msg ~= decoded_msg);
    len_check = '';
else
    num_errors = length(original_msg);
    len_check = 'Decoded message length different from original message!';
end

% Calculate Bit Error Rate (BER)
ber = num_errors / length(original_msg);

% Display BER
disp(['% Bit Error Rate (BER): ', num2str(ber(1)*100)]);
disp(len_check);


% HIDING RATE

% Calculate the duration of the audio signal
audio_duration = length(x) / Fs; % Duration in seconds

% Calculate the length of the binary message
message_length = length(binary_message);

% Calculate the rate at which the message is hidden per unit second
message_rate_per_second = message_length / audio_duration;

% Display the message hiding rate per unit second
disp(['Message hiding rate per second: ', num2str(message_rate_per_second), ' bits/second']);
