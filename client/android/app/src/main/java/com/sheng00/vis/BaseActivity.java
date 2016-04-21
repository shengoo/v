package com.sheng00.vis;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;

import com.nostra13.universalimageloader.cache.disc.impl.UnlimitedDiskCache;
import com.nostra13.universalimageloader.core.DisplayImageOptions;
import com.nostra13.universalimageloader.core.ImageLoader;
import com.nostra13.universalimageloader.core.ImageLoaderConfiguration;
import com.umeng.analytics.AnalyticsConfig;
import com.umeng.analytics.MobclickAgent;

/**
 * Created by UC206612 on 2016/4/21.
 */
public class BaseActivity extends AppCompatActivity {

    protected String umengKey = "571865dfe0f55a1d7e00236d";
    protected String umengChannel = "default";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        AnalyticsConfig.setAppkey(this,umengKey);
        AnalyticsConfig.setChannel(umengChannel);

        ImageLoaderConfiguration config = new ImageLoaderConfiguration.Builder(this)
                .diskCache(new UnlimitedDiskCache(getCacheDir()))
                .defaultDisplayImageOptions(
                        new DisplayImageOptions.Builder()
                                .cacheInMemory(true)
                                .cacheOnDisk(true)
                                .build())
                .build();
        ImageLoader.getInstance().init(config);
    }

    @Override
    protected void onResume() {
        super.onResume();
        MobclickAgent.onResume(this);
    }

    @Override
    protected void onPause() {
        super.onPause();
        MobclickAgent.onPause(this);
    }




//    @Override
//    public Intent getSupportParentActivityIntent() {
//        finish();
//        return null;
//    }

}
