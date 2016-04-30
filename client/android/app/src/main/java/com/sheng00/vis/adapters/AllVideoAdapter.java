package com.sheng00.vis.adapters;

import android.content.Context;
import android.content.Intent;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.nostra13.universalimageloader.core.ImageLoader;
import com.sheng00.vis.Activities.VideoDetailActivity;
import com.sheng00.vis.Model.Movie;
import com.sheng00.vis.R;
import com.sheng00.vis.Utils.Urls;
import com.sheng00.vis.ViewHolders.MovieItem;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by UC206612 on 2016/4/21.
 */
public class AllVideoAdapter extends RecyclerView.Adapter<MovieItem> {

    private List<Movie> mDataset = new ArrayList<Movie>();

    public AllVideoAdapter(List<Movie> data){
        mDataset = data;
    }

    @Override
    public MovieItem onCreateViewHolder(ViewGroup parent, int viewType) {
        View v = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.movie_list_item, parent, false);
//        v.setBackgroundResource(mBackground);
//        System.out.println(mBackground);
        MovieItem vh = new MovieItem(v);
        return vh;
    }

    @Override
    public void onBindViewHolder(MovieItem holder, int position) {
        System.out.println("get item at: " + position);
        final Movie item = mDataset.get(position);
        holder.title.setText(item.getTitle());
//        holder.summary.setText(alb.getSummary());
        final String imageUrl = Urls.base  + "/file/" + item.getImage();
        ImageLoader.getInstance().displayImage(imageUrl,holder.cover);
//        holder.imageView.setImage(imageUrl);
        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Context context = v.getContext();
                Intent intent = new Intent(context, VideoDetailActivity.class);
                intent.putExtra("Movie", item);
                context.startActivity(intent);
            }
        });
    }

    @Override
    public int getItemCount() {
        return mDataset.size();
    }



}
