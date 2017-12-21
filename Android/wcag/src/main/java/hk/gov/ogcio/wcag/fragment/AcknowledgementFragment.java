package hk.gov.ogcio.wcag.fragment;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ScrollView;
import android.widget.TextView;

import java.util.HashMap;

import hk.gov.ogcio.wcag.R;
import hk.gov.ogcio.wcag.gson.Seminar;
import hk.gov.ogcio.wcag.manager.FragmentManager;

public class AcknowledgementFragment extends FragmentManager implements View.OnClickListener {

    private HashMap<String, String> hashMap;
    private Seminar seminar;

    public static AcknowledgementFragment newInstance(HashMap<String, String> hashMap, Seminar seminar) {
        AcknowledgementFragment acknowledgementFragment = new AcknowledgementFragment();
        acknowledgementFragment.hashMap = hashMap;
        acknowledgementFragment.seminar = seminar;
        return acknowledgementFragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        activityInterface.getContainer().linearLayoutMenu.setVisibility(View.VISIBLE);
        activityInterface.getContainer().toolbar.setVisibility(View.VISIBLE);
    }

    @Override
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle savedInstanceState) {
        View view = layoutInflater.inflate(R.layout.fragment_acknowledgement, viewGroup, false);
        activityInterface.getContainer().setTitle(getString(R.string.title_register_success));
        view.findViewById(R.id.buttonHome).setOnClickListener(this);
        ScrollView scrollView = view.findViewById(R.id.scrollView);
        TextView textView = view.findViewById(R.id.textView);
        if (seminar == null) {
            textView.setText(String.format(getString(R.string.text_type_0), hashMap.get("start"), hashMap.get("end")));
            scrollView.setVisibility(View.GONE);
        } else {
            textView.setText(getString(R.string.text_type_1));
            TextView textViewTopic = view.findViewById(R.id.textViewTopic);
            textViewTopic.setText(seminar.getTopic(activity));
            TextView textViewDate = view.findViewById(R.id.textViewDate);
            textViewDate.setText(seminar.getDate(activity));
            TextView textViewTime = view.findViewById(R.id.textViewTime);
            textViewTime.setText(seminar.getTime());
            TextView textViewVenue = view.findViewById(R.id.textViewVenue);
            textViewVenue.setText(seminar.getVenue(activity));
        }
        return view;
    }

    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.buttonHome:
                activityInterface.getContainer().setFragmentParent(IntroductionFragment.newInstance());
                break;
        }
    }
}