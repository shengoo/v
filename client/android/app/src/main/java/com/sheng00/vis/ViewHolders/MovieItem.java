package com.sheng00.vis.ViewHolders;

import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.sheng00.vis.R;

/**
 * Created by UC206612 on 2016/4/22.
 */
public class MovieItem extends RecyclerView.ViewHolder {

    public TextView title;
    public ImageView cover;

    public MovieItem(View itemView) {
        super(itemView);
        title = (TextView) itemView.findViewById(R.id.movie_list_item_title);
    }
}
