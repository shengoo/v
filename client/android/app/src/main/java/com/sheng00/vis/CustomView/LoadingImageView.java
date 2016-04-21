package com.sheng00.vis.CustomView;

import android.content.Context;
import android.util.AttributeSet;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.RelativeLayout;

import com.nostra13.universalimageloader.core.ImageLoader;

/**
 * Created by UC206612 on 2016/4/21.
 */
public class LoadingImageView extends RelativeLayout {

    private ImageView imageView;
    private Context mContext;

    public LoadingImageView(Context context) {
        super(context);
        mContext = context;
        init();
    }

    public LoadingImageView(Context context,AttributeSet attrs){
        super(context,attrs);
        mContext = context;
        init();
    }
    public LoadingImageView(Context context, AttributeSet attrs, int defStyle)
    {
        super(context, attrs, defStyle);
        mContext = context;
        init();
    }

    private void init(){
        ProgressBar progressBar = new ProgressBar(mContext);
        LayoutParams lp = new LayoutParams(LayoutParams.WRAP_CONTENT,LayoutParams.WRAP_CONTENT);
        lp.addRule(RelativeLayout.CENTER_IN_PARENT, RelativeLayout.TRUE);
        addView(progressBar, lp);

        imageView = new ImageView(mContext);
        imageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
        addView(imageView,new LayoutParams(LayoutParams.MATCH_PARENT,LayoutParams.MATCH_PARENT));
    }




    public void setImage(String url){
        ImageLoader.getInstance().displayImage(url,imageView);
    }

}
