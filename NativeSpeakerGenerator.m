word = 'words\0013m1.wav';
[y, Fs] = audioread(word);
[nF, t] = toPitchContour(y, Fs);
[json] = WriteIntoJSON('??', t, nF, 'native\??.txt');