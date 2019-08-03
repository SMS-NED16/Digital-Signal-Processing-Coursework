R = 1000;
C = 100 * exp(-9);
f = 0:0.01:50;
Z_R = R;
Z_C = 1 + i * 2 * pi * f * R * C;
H = abs( Z_R./( Z_R + Z_C ) );
plot( f, H ); hold on;