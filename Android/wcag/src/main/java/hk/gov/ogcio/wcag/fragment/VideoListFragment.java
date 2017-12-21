package hk.gov.ogcio.wcag.fragment;

import android.os.Bundle;
import android.support.v7.widget.DividerItemDecoration;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import java.util.ArrayList;
import java.util.HashMap;

import hk.gov.ogcio.wcag.R;
import hk.gov.ogcio.wcag.adapter.VideoListAdapter;
import hk.gov.ogcio.wcag.manager.FragmentManager;

public class VideoListFragment extends FragmentManager implements VideoListAdapter.OnItemClickListener {

    public static VideoListFragment newInstance() {
        return new VideoListFragment();
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        activityInterface.getContainer().linearLayoutMenu.setVisibility(View.VISIBLE);
        activityInterface.getContainer().toolbar.setVisibility(View.VISIBLE);
    }

    @Override
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle savedInstanceState) {
        View view = layoutInflater.inflate(R.layout.fragment_category, viewGroup, false);
        activityInterface.getContainer().setTitle(getString(R.string.title_webforall_video_channel));
        RecyclerView recyclerView = view.findViewById(R.id.recyclerView);
        recyclerView.setLayoutManager(new LinearLayoutManager(activity));
        VideoListAdapter videoListAdapter = new VideoListAdapter(activity, setData());
        videoListAdapter.setOnItemClickListener(this);
        recyclerView.setAdapter(videoListAdapter);
        recyclerView.addItemDecoration(new DividerItemDecoration(activity, DividerItemDecoration.VERTICAL));
        return view;
    }

    private ArrayList<HashMap<String, Object>> setData() {
        ArrayList<HashMap<String, Object>> arrayList = new ArrayList<>();
        HashMap<String, Object> hashMap = new HashMap<>();
        hashMap.put("title", getString(R.string.video1_title));
        hashMap.put("content", getString(R.string.video1_content));
        hashMap.put("video", R.raw.web_accessibility_campaign_video);
        arrayList.add(hashMap);
        hashMap = new HashMap<>();
        hashMap.put("title", getString(R.string.video2_title));
        hashMap.put("content", getString(R.string.video2_content));
        hashMap.put("video", R.raw.why_web_accessibility_website_mobile_app_are_necessary);
        arrayList.add(hashMap);
        return arrayList;
    }

    @Override
    public void onItemClick(View view, int position, HashMap<String, Object> hashMap) {
        activityInterface.getContainer().setFragmentChild(VideoFragment.newInstance(hashMap));
    }
}