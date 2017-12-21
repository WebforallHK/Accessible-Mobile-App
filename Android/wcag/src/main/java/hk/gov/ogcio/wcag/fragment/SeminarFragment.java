package hk.gov.ogcio.wcag.fragment;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;

import java.util.HashMap;

import hk.gov.ogcio.wcag.R;
import hk.gov.ogcio.wcag.gson.Seminar;
import hk.gov.ogcio.wcag.manager.FragmentManager;

public class SeminarFragment extends FragmentManager implements View.OnClickListener, View.OnTouchListener {

    private Seminar seminar;

    public static SeminarFragment newInstance(Seminar seminar) {
        SeminarFragment seminarFragment = new SeminarFragment();
        seminarFragment.seminar = seminar;
        return seminarFragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        activityInterface.getContainer().linearLayoutMenu.setVisibility(View.VISIBLE);
        activityInterface.getContainer().toolbar.setVisibility(View.VISIBLE);
    }

    @Override
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle savedInstanceState) {
        View view = layoutInflater.inflate(R.layout.fragment_seminar, viewGroup, false);
        activityInterface.getContainer().setTitle(getString(R.string.title_seminars_and_technical_workshop_details));
        view.setLongClickable(true);
        view.setOnTouchListener(this);
        view.findViewById(R.id.scrollView).setLongClickable(true);
        view.findViewById(R.id.scrollView).setOnTouchListener(this);
        TextView textViewSeminar = view.findViewById(R.id.textViewTopic);
        textViewSeminar.setLongClickable(true);
        textViewSeminar.setOnTouchListener(this);
        textViewSeminar.setText(seminar.getTopic(activity));
        TextView textViewDate = view.findViewById(R.id.textViewDate);
        textViewDate.setLongClickable(true);
        textViewDate.setOnTouchListener(this);
        textViewDate.setText(seminar.getDate(activity));
        TextView textViewTime = view.findViewById(R.id.textViewTime);
        textViewTime.setLongClickable(true);
        textViewTime.setOnTouchListener(this);
        textViewTime.setText(seminar.getTime());
        TextView textViewVenue = view.findViewById(R.id.textViewVenue);
        textViewVenue.setLongClickable(true);
        textViewVenue.setOnTouchListener(this);
        textViewVenue.setText(seminar.getVenue(activity));
        Button buttonMap = view.findViewById(R.id.buttonMap);
        buttonMap.setOnClickListener(this);
        buttonMap.setOnTouchListener(this);
        TextView textViewDetails = view.findViewById(R.id.textViewDetails);
        textViewDetails.setLongClickable(true);
        textViewDetails.setOnTouchListener(this);
        textViewDetails.setText(seminar.getDetails(activity));
        Button buttonRegister = view.findViewById(R.id.buttonRegister);
        if (seminar.getOutdated()) {
            buttonRegister.setVisibility(View.GONE);
        } else {
            buttonRegister.setOnClickListener(this);
            buttonRegister.setOnTouchListener(this);
        }
        return view;
    }

    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.buttonMap:
                activityInterface.getContainer().setFragmentChild(MapFragment.newInstance(seminar));
                break;
            case R.id.buttonRegister:
                activityInterface.getContainer().setFragmentChild(DetailsFragment.newInstance(new HashMap<String, String>(), seminar));
                break;
        }
    }

    @Override
    public boolean onTouch(View view, MotionEvent motionEvent) {
        return gestureDetector.onTouchEvent(motionEvent);
    }
}