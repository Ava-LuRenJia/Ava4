clear;
close all;
myi=zeros(20,20); % Create a 20*20 zero matrix.
myi(2:2:18,2:2:18)=1; % Change [2,4,6...18][2,4,6...18].
myi=uint8(myi); % Change type to uint8.
figure, imshow(myi,'InitialMagnification', 'fit');
% "figure, imshow(myi,'notruesize');" is wrong, be used to show the picture.
pause;