function DisplayInstructions(options, phase)
    
    %% Display instructions message, if we start
    instr = strrep(options.instructions.(phase), '\n', sprintf('\n'));
    if ~isempty(instr)
        scrsz = get(0,'ScreenSize');
        left=scrsz(1); bottom=scrsz(2); width=scrsz(3); height=scrsz(4);

        msg = struct();
        msgw = 900;
        msgh = 650;
        mr = 60;
        msg.w = figure('Visible', 'off', 'Position', [left+(width-msgw)/2, (height-msgh)/2, msgw, msgh], 'Menubar', 'none', 'Resize', 'off', 'Color', [1 1 1]*.9, 'Name', 'Instructions');

        msg.txt = uicontrol('Style', 'text', 'Position', [mr, 50+mr*2, msgw-mr*2, msgh-(50+mr)-mr*2], 'Fontsize', 18, 'HorizontalAlignment', 'left', 'BackgroundColor', [1 1 1]*.9);
        instr = textwrap(msg.txt, {instr});
        set(msg.txt, 'String', instr);
        msg.bt = uicontrol('Style', 'pushbutton', 'Position', [msgw/2-50, mr, 100, 50], 'String', 'OK', 'Fontsize', 14, 'Callback', 'uiresume');
        set(msg.w, 'Visible', 'on');
        uicontrol(msg.bt);

        uiwait(msg.w);
        close(msg.w);
    end

end    