[audio, fs] = audioread('rickroll.wav'); % Load your audio file here

% Normalize the audio
audio_normalized = audio / max(abs(audio));

% Split audio into frames 
frame_length = 1024;
num_frames = ceil(length(audio) / frame_length);
audio_frames = zeros(frame_length, num_frames);
audio_padded = [audio_normalized; zeros(num_frames * frame_length - length(audio), 1)];
for i = 1:num_frames
    audio_frames(:, i) = audio_padded((i-1)*frame_length+1 : i*frame_length);
end

% Define phase shift for encoding message
phase_shift = pi/2; 

% Encode message into phase of audio frames
message = 'Never gonna give you up, never gonna let you down!';
message_binary = reshape(dec2bin(double(message), 8)', 1, []);
index = 1;
for i = 1:num_frames
    if index <= length(message_binary)
        bit = str2double(message_binary(index));
        % Apply phase shift based on bit value
        if bit == 1
            audio_frames(:, i) = audio_frames(:, i) * exp(1i * phase_shift);
        end
        index = index + 1;
    else
        break;
    end
end

% Reconstruct audio from modified frames
audio_reconstructed = zeros(size(audio_padded));
for i = 1:num_frames
    audio_reconstructed((i-1)*frame_length+1 : i*frame_length) = audio_frames(:, i);
end
real_audio = abs(audio_reconstructed);
disp(audio_reconstructed)

% Save the reconstructed audio
audiowrite('reconstructed_audio_phase_coding.wav', real_audio, fs);

% --- Optional: Play Original and Reconstructed Audio for Comparison ---
sound(audio_normalized, fs); % Play original audio
pause(length(audio) / fs + 1); % Wait for audio to finish plus a little extra
sound(real_audio, fs); % Play reconstructed audio
