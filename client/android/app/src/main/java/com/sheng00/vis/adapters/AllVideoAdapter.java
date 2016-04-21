package com.sheng00.vis.adapters;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.sheng00.vis.CustomView.LoadingImageView;

/**
 * Created by UC206612 on 2016/4/21.
 */
public class AllVideoAdapter extends RecyclerView.Adapter<AllVideoAdapter.ViewHolder> {

    private Context context;

    public AllVideoAdapter(Context context){
        this.context = context;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        return null;
    }

    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {

    }

    @Override
    public int getItemCount() {
        return 0;
    }

    public static class ViewHolder extends RecyclerView.ViewHolder {

        public final View view;
        public TextView title;
        public TextView summary;
        public LoadingImageView imageView;

        public ViewHolder(View v){
            super(v);
            view = v;
//            title = (TextView) v.findViewById(R.id.title);
//            summary = (TextView) v.findViewById(R.id.summary);
//            imageView = (LoadingImageView) v.findViewById(R.id.image);
        }
    }
}
