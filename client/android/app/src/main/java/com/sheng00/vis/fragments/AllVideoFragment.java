package com.sheng00.vis.fragments;


import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Toast;

import com.sheng00.vis.Model.Movie;
import com.sheng00.vis.R;
import com.sheng00.vis.Service.MovieService;
import com.sheng00.vis.adapters.AllVideoAdapter;

import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * A simple {@link Fragment} subclass.
 */
public class AllVideoFragment extends Fragment {

    AllVideoAdapter adapter;


    public AllVideoFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_all_video,container,false);
        RecyclerView recyclerView = (RecyclerView) view.findViewById(R.id.recyclerview);
        setupRecyclerView(recyclerView);
        return view;
    }

    private void setupRecyclerView(final RecyclerView recyclerView) {
        recyclerView.setHasFixedSize(true);
//        recyclerView.setLayoutManager(new GridLayoutManager(recyclerView.getContext(), 2));
        recyclerView.setLayoutManager(new LinearLayoutManager(recyclerView.getContext()));
//        recyclerView.setLayoutManager(new StaggeredGridLayoutManager(2,1));


//        adapter = new AllVideoAdapter(recyclerView.getContext());
//        recyclerView.setAdapter(adapter);

        MovieService service = new MovieService(getContext());
        service.getAll(new Callback<List<Movie>>() {
            @Override
            public void onResponse(Call<List<Movie>> call, final Response<List<Movie>> response) {
                getActivity().runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        adapter = new AllVideoAdapter(response.body());
                        recyclerView.setAdapter(adapter);
//                        adapter.setData(response.body());
                        recyclerView.setVisibility(View.VISIBLE);
                    }
                });
            }

            @Override
            public void onFailure(Call<List<Movie>> call, Throwable t) {

            }
        });


    }

}
