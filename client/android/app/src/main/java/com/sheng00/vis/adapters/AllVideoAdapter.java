package com.sheng00.vis.adapters;

import android.content.Context;
import android.content.Intent;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.sheng00.vis.CustomView.LoadingImageView;
import com.sheng00.vis.Model.Movie;
import com.sheng00.vis.R;
import com.sheng00.vis.Utils.Urls;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by UC206612 on 2016/4/21.
 */
public class AllVideoAdapter extends RecyclerView.Adapter<AllVideoAdapter.ViewHolder> {

    private Context context;
    private List<Movie> mDataset = new ArrayList<Movie>();

    public AllVideoAdapter(Context context){
        this.context = context;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View v = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.movie_list_item, parent, false);
//        v.setBackgroundResource(mBackground);
//        System.out.println(mBackground);
        ViewHolder vh = new ViewHolder(v);
        return vh;
    }

    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
        System.out.println("get item at: " + position);
        final Movie item = mDataset.get(position);
        holder.title.setText(item.getTitle());
//        holder.summary.setText(alb.getSummary());
        final String imageUrl = Urls.base + item.getImage();
//        ImageLoader.getInstance().displayImage(imageUrl,holder.imageView);
//        holder.imageView.setImage(imageUrl);
//        holder.view.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                Context context = v.getContext();
//                Intent intent = new Intent(context, AlbActivity.class);
//                intent.putExtra("Alb",item);
//                context.startActivity(intent);
//            }
//        });
    }

    @Override
    public int getItemCount() {
        System.out.println("item count:" + mDataset.size());
        return mDataset.size();
    }

    public void setData(List<Movie> data){
        mDataset = data;
        notifyDataSetChanged();
    }

    public static class ViewHolder extends RecyclerView.ViewHolder {

        public final View view;
        public TextView title;
        public TextView summary;
        public LoadingImageView imageView;

        public ViewHolder(View v){
            super(v);
            view = v;
            title = (TextView) v.findViewById(R.id.movie_list_item_title);
//            summary = (TextView) v.findViewById(R.id.summary);
//            imageView = (LoadingImageView) v.findViewById(R.id.image);
        }
    }

}
