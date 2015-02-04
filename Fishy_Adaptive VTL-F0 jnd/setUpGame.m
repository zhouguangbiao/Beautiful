function [G, bkg, bigFish, bubbles, screen2, gameCommands] = setUpGame

    % to test
    % addpath('../lib/SpriteKit');

    %% introduce the animation bit
    % Start a new Game
    
%     [screen1, screen2] = getScreens();
    [~, screen2] = getScreens();
    fprintf('Experiment will displayed on: [%s]\n', sprintf('%d ',screen2));
    % We put the game on screen 2
    
    G = SpriteKit.Game.instance('Title','Fishy Game', 'Size', screen2(3:4), 'Location', screen2(1:2), 'ShowFPS', false);

    bkg = SpriteKit.Background(resizeBackgroundToScreenSize(screen2, '../img/fixed/BACKGROUND_unscaled.png'));

    addBorders(G);
    % Setup the SpriteS
    bigFish = SpriteKit.Sprite('fish_1');
    
    initState(bigFish,'fish_1','../img/fixed/FISHY_TURN_1.png',true);
    for k=2:10
        spritename = sprintf('FISHY_TURN_%d',k);
        pngFile = ['../img/fixed/' spritename '.png'];
%         s.initState(spritename, pngFile, true);
        initState(bigFish, ['fish_' int2str(k)] , pngFile, true);
    end
    
    bigFish.Scale = 1;
    bigFish.State = 'fish_1';
    bigFish.Location = [screen2(3)/2, screen2(4)-450];
    addprop(bigFish, 'arcAround1');
    addprop(bigFish, 'arcAround2');
    nFriends = 40;
    [x, y] = getArc(5*pi/6, pi/6, bigFish.Location(1)-100, bigFish.Location(2)-100, 400, nFriends);
    bigFish.arcAround1 = [x;y];
    addprop(bigFish, 'availableLocArc1');
    bigFish.availableLocArc1 = randperm(nFriends);
    nFriends = 60;
    [x, y] = getArc(5*pi/6, pi/6, bigFish.Location(1)-200, bigFish.Location(2)-200, 600, nFriends);
    bigFish.arcAround2 = [x;y];
    addprop(bigFish, 'availableLocArc2');
    bigFish.availableLocArc2 = randperm(nFriends);
    addprop(bigFish, 'iter')
    bigFish.iter = 1;
    addprop(bigFish, 'countTurns');
    bigFish.countTurns = 0;
    
    bubbles = SpriteKit.Sprite('noBubbles');
    bubbles.initState('noBubbles', ['../img/fixed/' 'bubbles_none' '.png'], true);
    for k=1:4
        spritename = sprintf('bubbles_%d',k);
        pngFile = ['../img/fixed/' spritename '.png'];
%         pngFile = ['/home/paolot/gitStuff/bubblesAnimation/' spritename
%         '.png'];  PT: these are the old bubbles, they work better
        bubbles.initState(spritename, pngFile, true);
    end
    bubbles.State = 'noBubbles';
    %% Setup KeyPressFcn and others
%     G.onKeyPress = @keypressfcn;
%     G.onMouseRelease = @buttonupfcn;
    
    gameCommands = SpriteKit.Sprite('controls');
%     initState(gameCommands, 'none', zeros(2,2,3), true);
    initState(gameCommands, 'begin','../img/fixed/start.png' , true);
    initState(gameCommands, 'finish','../img/fixed/finish.png' , true);
    gameCommands.State = 'begin';
    gameCommands.Location = [screen2(3)/2, screen2(4)/2 + 40];
    gameCommands.Scale = 1.5; % make it bigger to cover fishy
    % define clicking areas
    clickArea = size(imread('../img/fixed/start.png'));
    addprop(gameCommands, 'clickL');
    addprop(gameCommands, 'clickR');
    addprop(gameCommands, 'clickD');
    addprop(gameCommands, 'clickU');
    gameCommands.clickL = round(gameCommands.Location(1) - round(clickArea(1)/2));
    gameCommands.clickR = round(gameCommands.Location(1) + round(clickArea(1)/2));
    gameCommands.clickD = round(gameCommands.Location(2) - round(clickArea(2)/2));
    gameCommands.clickU = round(gameCommands.Location(2) + round(clickArea(2)/2));
    clear clickArea 
    %% ------   start the GAME
%     iter = 0;
%     G.play(@()action(argin));
%     G.play(@action);
%     pause(1);

    
end % end of the setUpGame function 