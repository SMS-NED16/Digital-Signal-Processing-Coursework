%% EE-394  Digital Signal Processing - Bonus Task 1 
% Saad Mashkoor Siddiqui, EE-16163, Section D, TE-EE, Fall 2018
% Function File - generate_movie.m
% generates and saves a video of a rotating wheel

%% Function Definition
function generate_movie( frame_rate, rotation_speed, title, vid_length )
    % read image file - assumes file is in same directory as m script
    wheel = imread( 'wheel.png' );
    
    % create a video writer object - MPEG 4 profile specified
    video = VideoWriter( title, 'MPEG-4' );
    
    % set the framerate as defined in argumeont
    video.FrameRate = frame_rate;
    
    % set duration to argument
    video_duration = vid_length;
    
    % calculating total frames and total angular displacement
    total_frames = video_duration * frame_rate;
    total_angle = video_duration * rotation_speed * 360;    % 360 deg in 1 rotation
    
    % amount by which image rotates with each frame
    angle_per_frame = total_angle / total_frames;
    
    % rotation angle decrements by angle_per_frame with each iter for cw
    img_angle = 0;         
    
    % Open the video writer stream to write frames to it
    open( video );
    
    % for every frame in the specified duration
    for var = 1:(total_frames + 1 )
        % create annotations for frame
        % angle per frame label
        apf_text = sprintf( 'Angle/Frame = %.2f\n', angle_per_frame );
        
        % clockwise angular displacement label
        angle_text = sprintf( 'CW Displacement = %.2f\n', -img_angle );  
        
        % frame rate and rotation speed (function argument) labels
        args = [ sprintf( 'Frames/Second = %.2f\n', frame_rate )...
             sprintf( 'Rotations/Second = %.2f\n', rotation_speed ) ];
        
        % will be passed as argument to insertText
        caption = [ args, apf_text, angle_text ];
        
        % Rotate image for new frame
        new_img = imrotate( wheel, img_angle, 'bilinear', 'crop' );
        
        % Add title, FPS, rotations/second, angle labels to frame
            % title
        new_img = insertText( new_img, [ 0 0 ], title, 'FontSize', 24, 'BoxColor',...
            'red', 'BoxOpacity', 0.4, 'TextColor', 'white' );
            % other data
        new_img = insertText( new_img, [ 0 34 ], caption,'FontSize',18,'BoxColor',...
            'green','BoxOpacity',0.4,'TextColor','white');
        
        % render frame after rotation
        imshow( new_img );
        
        % save currently rendered frame; add to video
        frame = getframe( gcf );
        writeVideo( video, frame );
        
        % decrement angle for next frame - clockwise rotation
        img_angle = img_angle - angle_per_frame;
    end
    
    % close video file stream
    close( video );
end