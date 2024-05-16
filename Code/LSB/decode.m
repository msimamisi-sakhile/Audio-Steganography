[audio_rec, fs] = audioread('reconstructed_audio.wav'); % Load your audio file here
audio_normalized_rec = int16(audio_rec * 32767); % Normalize
audio_binary_rec = dec2bin(typecast(audio_normalized_rec(:), 'uint16'), 16); % Convert to binary

%disp(audio_binary);

str_val = 'Never gonna give you up, never gonna let you down!';

asciiValue = double(str_val);

binString_rec = dec2bin(asciiValue, 8);
return_str = string();
binString_rec = reshape(binString_rec', 1, []);
message_length = 50*8;
spacing = 10000;
error = 0;
index = 0;
for i=1:spacing:message_length*spacing
    index = index + 1;
    return_str(index,1) = audio_binary_rec(i, end);
    if return_str(index,1) ~= binString_rec(index)
        error = error + 1;
    end
end
fprintf("Error is: \n");
disp(error);
fprintf("Bit error rate is:\n");
disp((error/message_length)*100);

msg_dec = string();
byte = '';
index = 1;
for i=1:message_length
    if mod(i, 8) == 1 && i ~= 1 
        msg_dec(1,index) = byte;
        index = index + 1;
        byte = '';
    end
    byte = byte + return_str(i,1);
end
msg_dec = bin2dec(msg_dec);
fprintf("The decoded message is \n");
disp(char(msg_dec));

