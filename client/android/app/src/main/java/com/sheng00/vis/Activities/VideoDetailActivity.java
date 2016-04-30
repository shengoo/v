package com.sheng00.vis.Activities;

import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

import com.sheng00.vis.BaseActivity;
import com.sheng00.vis.Model.Movie;
import com.sheng00.vis.R;

public class VideoDetailActivity extends BaseActivity {

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

    }
}
