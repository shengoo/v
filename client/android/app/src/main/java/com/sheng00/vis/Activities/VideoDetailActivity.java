package com.sheng00.vis.Activities;

import android.content.Intent;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Bundle;
import android.view.ViewGroup;
import android.widget.MediaController;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.VideoView;

import com.sheng00.vis.BaseActivity;
import com.sheng00.vis.CustomView.StretchVideoView;
import com.sheng00.vis.Model.Movie;
import com.sheng00.vis.R;
import com.sheng00.vis.Utils.Urls;

public class VideoDetailActivity extends BaseActivity {

    StretchVideoView videoView;
    MediaController mediaController;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_video_detail);

        Intent intent = getIntent();
        Movie movie = (Movie) intent.getSerializableExtra("Movie");

        TextView title = (TextView) findViewById(R.id.title_txt);
        title.setText(movie.getTitle());

        TextView description = (TextView) findViewById(R.id.description_txt);
        description.setText(movie.getDescription());

        Uri videoUri = Uri.parse(Urls.base + "/file/" + movie.getVideo());


//videoView.getHolder().setFixedSize();

        videoView = (StretchVideoView) findViewById(R.id.videoView);
        videoView.setVideoURI(videoUri);
        mediaController = new MediaController(videoView.getContext());
        videoView.setMediaController(mediaController);
        RelativeLayout.LayoutParams lp = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        lp.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM,1);
        mediaController.setLayoutParams(lp);
        ((ViewGroup)mediaController.getParent()).removeView(mediaController);
        ((RelativeLayout)findViewById(R.id.videoContainer)).addView(mediaController);
//        mediaController.setAnchorView(findViewById(R.id.videoView));
        videoView.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {

            public void onPrepared(MediaPlayer mp) {
//                mp.setOnVideoSizeChangedListener(new MediaPlayer.OnVideoSizeChangedListener() {
//                    @Override
//                    public void onVideoSizeChanged(MediaPlayer mp, int width, int height) {
//                        System.out.println("onVideoSizeChanged");
//                        /*
//                                           *  add media controller
//                                           */
//                        mediaController = new MediaController(VideoDetailActivity.this);;
//                        videoView.setMediaController(mediaController);
//                                          /*
//                                           * and set its position on screen
//                                           */
//                        mediaController.setAnchorView(videoView);
//                    }
//                });
                System.out.println("prepared");
                videoView.start();
            }
        });
    }
}
