function [] = vectorPlot(start,stop,color,name,size,arrowOnOff)
% params:
%   - start: This is where the vector to be drawn starts in the complex
%     plain
%   - stop: This is the where the tip of the vector to be drawn is located
%     in the complex plain
%   - color: The line style and the color of the vector... eg.: '-b', '--m'
%	- name: Name of the vector. Use LaTeX syntax.
%   - arrowOnOff: The value of this integer-number defines the arrow's size

if nargin < 2 error('error'); end
if nargin < 3 color='-b'; end
if nargin < 4 name=''; end
if nargin < 5 size=max(abs([start,stop])); end
if nargin < 6 arrowOnOff=1; end

funcTurnR = @(z,phi) abs(z) .* exp(1i.*(angle(z)-phi));

x = [real(start),real(stop)+real(start)];
y = [imag(start),imag(start)+imag(stop)];

plot(x, y, color);

if arrowOnOff==1
  arrow = [-1+0.15i,-1-0.15i,0]./5.*size;
  arrowE=start+stop+funcTurnR(arrow,-angle(stop));
  fill(real(arrowE),imag(arrowE),color(end));
end

if name not '';
  text( (x(2)-x(1))/2+x(1) , (y(2)-y(1))/2+y(1) , name,...
            'BackgroundColor',[1 1 1], ...
            'VerticalAlignment', 'Middle', ...
            'HorizontalAlignment', 'Center', ...
            'EdgeColor', color(end), ...
            'FontSize', 10);
end

end

