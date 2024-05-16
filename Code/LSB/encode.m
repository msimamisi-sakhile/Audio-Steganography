
[audio, fs] = audioread('rickroll.wav'); % Load your audio file here
audio_normalized = int16(audio * 32767); % Normalize
audio_binary = dec2bin(typecast(audio_normalized(:), 'uint16'), 16); % Convert to binary

str = 'Never gonna give you up, never gonna let you down!';

spacing_encode = 10000;

asciiValues = double(str);

binString = dec2bin(asciiValues, 8);

binString = reshape(binString', 1, []);

index = 0;

for i=1:spacing_encode:length(binString)*spacing_encode
    index = index + 1;
    audio_binary(i, end) = binString(index);
end

audio_integers = bin2dec(audio_binary); % Convert binary to decimal
audio_reconstructed = typecast(uint16(audio_integers), 'int16'); % Typecast to int16
audio_reconstructed_normalized = double(audio_reconstructed) / 32767; % Normalize to [-1, 1]

% Save the reconstructed audio
audiowrite('reconstructed_audio.wav', audio_reconstructed_normalized, fs);

% --- Optional: Play Original and Reconstructed Audio for Comparison ---
sound(audio, fs); % Play original audio
pause(length(audio)/fs + 1); % Wait for audio to finish plus a little extra
sound(audio_reconstructed_normalized, fs); % Play reconstructed audio