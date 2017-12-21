package hk.gov.ogcio.wcag.fragment;

import android.os.Bundle;
import android.support.v7.widget.DividerItemDecoration;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import java.util.Arrays;

import hk.gov.ogcio.wcag.R;
import hk.gov.ogcio.wcag.adapter.CategoryAdapter;
import hk.gov.ogcio.wcag.manager.FragmentManager;

public class CategoryFragment extends FragmentManager implements CategoryAdapter.OnItemClickListener {

    public static CategoryFragment newInstance() {
        return new CategoryFragment();
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
        activityInterface.getContainer().setTitle(getString(R.string.title_more_information_about_the_campaign));
        RecyclerView recyclerView = view.findViewById(R.id.recyclerView);
        recyclerView.setLayoutManager(new LinearLayoutManager(activity));
        CategoryAdapter categoryAdapter = new CategoryAdapter(activity, Arrays.asList(getResources().getStringArray(R.array.category)));
        categoryAdapter.setOnItemClickListener(this);
        recyclerView.setAdapter(categoryAdapter);
        recyclerView.addItemDecoration(new DividerItemDecoration(activity, DividerItemDecoration.VERTICAL));
        return view;
    }

    @Override
    public void onItemClick(View view, int position, String title) {
        activityInterface.getContainer().setFragmentChild(WebViewFragment.newInstance(title));
    }
}