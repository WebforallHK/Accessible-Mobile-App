package hk.gov.ogcio.wcag.fragment;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import hk.gov.ogcio.wcag.R;
import hk.gov.ogcio.wcag.manager.FragmentManager;

public class TutorialFragment extends FragmentManager {

    public static TutorialFragment newInstance() {
        return new TutorialFragment();
    }

    @Override
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle savedInstanceState) {
        return layoutInflater.inflate(R.layout.fragment_tutorial, viewGroup, false);
    }
}