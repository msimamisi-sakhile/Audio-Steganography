% Load the reconstructed audio
[audio_reconstructed, fs] = audioread('reconstructed_audio_phase_coding.wav');

% Split audio into frames
frame_length = 1024;
num_frames = floor(length(audio_reconstructed) / frame_length);
audio_frames = zeros(frame_length, num_frames);
for i = 1:num_frames
    audio_frames(:, i) = audio_reconstructed((i-1)*frame_length+1 : i*frame_length);
end

% Use same phase shift used for encoding
phase_shift = pi/2; % Adjust as needed

% Initialize variables
message_binary = '';
prev_phase = angle(audio_frames(1, 1));
threshold = phase_shift / 2;

% Decode message from phase differences
for i = 2:num_frames
    curr_phase = angle(audio_frames(1, i));
    phase_diff = mod(curr_phase - prev_phase + pi, 2*pi) - pi;
    if abs(phase_diff) > threshold
        message_binary = strcat(message_binary, '1');
    else
        message_binary = strcat(message_binary, '0');
    end
    prev_phase = curr_phase;

    % Debugging: Print phase differences
    disp(['Frame ', num2str(i), ': Phase Difference = ', num2str(phase_diff)]);
end


% Pad message with zeros to make its length divisible by 8
remainder = mod(length(message_binary), 8);
if remainder > 0
    message_binary = strcat(message_binary, repmat('0', 1, 8 - remainder));
end

disp(message_binary)
% Convert binary message to ASCII characters
message = char(bin2dec(reshape(message_binary, 8, []).'));

disp('Decoded Message:');
fprintf(message);
