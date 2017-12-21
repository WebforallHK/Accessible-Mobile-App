package hk.gov.ogcio.wcag.fragment;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import java.util.HashMap;

import hk.gov.ogcio.wcag.R;
import hk.gov.ogcio.wcag.gson.Seminar;
import hk.gov.ogcio.wcag.manager.FragmentManager;

public class DetailsFragment extends FragmentManager implements View.OnClickListener {

    private HashMap<String, String> hashMap;
    private Seminar seminar;

    public static DetailsFragment newInstance(HashMap<String, String> hashMap, Seminar seminar) {
        DetailsFragment detailsFragment = new DetailsFragment();
        detailsFragment.hashMap = hashMap;
        detailsFragment.seminar = seminar;
        return detailsFragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        activityInterface.getContainer().linearLayoutMenu.setVisibility(View.VISIBLE);
        activityInterface.getContainer().toolbar.setVisibility(View.VISIBLE);
    }

    @Override
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle savedInstanceState) {
        View view = layoutInflater.inflate(R.layout.fragment_details, viewGroup, false);
        activityInterface.getContainer().setTitle(getString(R.string.title_register));
        setViewSlide(view);
        TextView textViewTopic = view.findViewById(R.id.textViewTopic);
        textViewTopic.setText(seminar.getTopic(activity));
        TextView textViewDate = view.findViewById(R.id.textViewDate);
        textViewDate.setText(seminar.getDate(activity));
        TextView textViewTime = view.findViewById(R.id.textViewTime);
        textViewTime.setText(seminar.getTime());
        TextView textViewVenue = view.findViewById(R.id.textViewVenue);
        textViewVenue.setText(seminar.getVenue(activity));
        setViewSlide(textViewTopic);
        setViewSlide(textViewDate);
        setViewSlide(textViewTime);
        setViewSlide(textViewVenue);
        setViewSlide(view.findViewById(R.id.textView));
        view.findViewById(R.id.buttonNext).setOnClickListener(this);
        return view;
    }

    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.buttonNext:
                activityInterface.getContainer().setFragmentChild(RegisterFragment.newInstance(hashMap, seminar));
                break;
        }
    }
}