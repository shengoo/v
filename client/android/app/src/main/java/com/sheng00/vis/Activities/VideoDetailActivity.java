package com.sheng00.vis.Activities;

import android.content.Intent;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Bundle;
import android.widget.MediaController;
import android.widget.TextView;
import android.widget.VideoView;

import com.sheng00.vis.BaseActivity;
import com.sheng00.vis.Model.Movie;
import com.sheng00.vis.R;
import com.sheng00.vis.Utils.Urls;

public class VideoDetailActivity extends BaseActivity {

    VideoView videoView;
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

        mediaController = new MediaController(this);

        videoView = (VideoView) findViewById(R.id.videoView);
        videoView.setVideoURI(videoUri);
        videoView.setMediaController(mediaController);
        videoView.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {

            public void onPrepared(MediaPlayer mp) {
                videoView.start();
            }
        });
    }
}
