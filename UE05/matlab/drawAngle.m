function [] = drawAngle(radius,phi1,phi2,name,color,aE,aB)

funcTurnR = @(z,phi) abs(z) .* exp(1i.*(angle(z)-phi));
points = radius*cos(linspace(phi1,phi2,500))+1i*radius*sin(linspace(phi1,phi2,500));

arrow = [-1+0.3i,-1-0.3i,0]./10.*radius;

plot(real(points),imag(points),color);
text_rad = 0.8*radius;
text((text_rad*cos(phi1)+text_rad*cos(phi2))/2,...
    (text_rad*sin(phi1)+text_rad*sin(phi2))/2,name,...
'BackgroundColor',[1 1 1], ...
'VerticalAlignment', 'Middle', ...
'HorizontalAlignment', 'Center', ...
'EdgeColor', color(end), ...
'FontSize', 10);

arrowE=points(end)+funcTurnR(arrow,-angle(points(end)-points(end-1)));

arrowB=points(1)+funcTurnR(arrow,-angle(points(1)-points(2)));

if nargin < 6 || aE==1
fill(real(arrowE),imag(arrowE),color(end));
end

if nargin > 6 && aB==1
fill(real(arrowB),imag(arrowB),color(end));
end

end

