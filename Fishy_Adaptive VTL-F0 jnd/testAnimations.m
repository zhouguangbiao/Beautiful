function testAnimations

addpath('../lib/SpriteKit');
close(gcf)

scrsz = get(0,'ScreenSize');
G = SpriteKit.Game.instance('Title','Flying Membrane Demo', 'ShowFPS', false, 'Size',[scrsz(3) scrsz(4)]);

%% Setup the Sprite
s = SpriteKit.Sprite('fishone');
for k=1:10
    spritename = sprintf('FISHY_TURN_%d',k);
    pngFile = ['../img/fixed/' spritename '.png'];
    s.initState(spritename, pngFile, true);
end
im = imread(pngFile);
addprop(s, 'size');
s.size = size(im);
addprop(s, 'bubblesX');
s.bubblesX = round(s.Location(1) + s.size(1)/2);
addprop(s, 'bubblesY');
s.bubblesY = round(s.Location(2) + s.size(2)/2);
iter = 1;

% [nBubbles, posBubbles, ] = makeBubbles_abs(0,0);

bubbles = SpriteKit.Sprite('bubbles');
for k=1:4
    spritename = sprintf('bubbles_%d',k);
    pngFile = ['../img/fixed/' spritename '.png'];
    bubbles.initState(spritename, pngFile, true);
end

s.cycleNext;

statusCounter = 1;
bubble = {};

%% Run it!
G.play(@action);

%% Function to be called on each tic/toc of gameplay
    function action
        
        % increase the scaling
        %     s.Scale = s.Scale+0.01;
        
%         s.cycleNext
        % cycle next layer
        if (mod(floor(iter/10), 4) == 0)
%             s.cycleNext;
            bubbles.Location = [s.bubblesX, s.bubblesY];
            bubbles.cycleNext;
        end
%         s.State
%         if (mod(floor(iter/10), 4) == 0)
%             s.State = sprintf('FISHY_TURN_%d',mod(floor(iter/2), 10) + 1);
%         end
        % update position and angle
        %     s.Location = P(iter,:);  % use dot assignment...
        %     set(s,'Angle',iter)      % or "set"
        %
        if iter==140 % stop processing
            G.stop();
            
        end
        
        iter = iter+1;

%         for iBubbles = 1 : nBubbles(statusCounter)
%             bubble{end + 1} = rectangle('Curvature', [1 1], 'Position', [posBubbles(statusCounter).b{iBubbles}], 'FaceColor', [0 115 255]./255, ...
%                 'EdgeColor', [198 241 255]./255, 'LineWidth', 2)
%         end

        
    end


rmpath('../lib/SpriteKit');

end