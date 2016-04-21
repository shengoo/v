package com.sheng00.vis.Service;

import android.content.Context;

import com.sheng00.vis.Model.Movie;
import com.sheng00.vis.Utils.Urls;

import java.util.List;
import java.util.concurrent.Executor;
import java.util.concurrent.Executors;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;
import retrofit2.http.GET;
import retrofit2.http.Path;

/**
 * Created by UC206612 on 2016/4/21.
 */
public class MovieService {
    private String serverHost = "http://182.92.153.230";

    private Context mContext;
    private IMovieService service;

    public MovieService(Context context){
        mContext = context;
        Retrofit retrofit = new Retrofit.Builder().baseUrl(Urls.base)
                .addConverterFactory(GsonConverterFactory.create()).build();
        service = retrofit.create(IMovieService.class);
    }

    public void getAll(Callback<List<Movie>> cb){
//        service.list(cb);
        Call<List<Movie>> call = service.list();
        call.enqueue(cb);
    }

    public interface IMovieService{
        @GET("/api")
//        void list(Callback<List<Movie>> cb);
        Call<List<Movie>> list();

//        @GET("/api/category")
//        void category(Callback<List<Movie>> cb);
//
//        @GET("/api/getmoviebycategory/{category}")
//        void categoryList(@Path("category") String category,Callback<List<Movie>> cb);
    }

}
