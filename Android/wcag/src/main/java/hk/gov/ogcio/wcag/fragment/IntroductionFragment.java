package hk.gov.ogcio.wcag.fragment;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;

import java.util.Locale;

import hk.gov.ogcio.wcag.R;
import hk.gov.ogcio.wcag.manager.FragmentManager;

public class IntroductionFragment extends FragmentManager implements View.OnClickListener {

    public static IntroductionFragment newInstance() {
        return new IntroductionFragment();
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        activityInterface.getContainer().linearLayoutMenu.setVisibility(View.VISIBLE);
        activityInterface.getContainer().toolbar.setVisibility(View.VISIBLE);
        activityInterface.getContainer().imageButtonMenu.setVisibility(View.VISIBLE);
    }

    @Override
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle savedInstanceState) {
        View view = layoutInflater.inflate(R.layout.fragment_introduction, viewGroup, false);
        activityInterface.getContainer().setTitle(getString(R.string.title_about_web_mobile_app_accessibility_campaign));
        Button buttonMore = view.findViewById(R.id.buttonMore);
        buttonMore.setOnClickListener(this);
        ImageView imageViewBanner = view.findViewById(R.id.imageViewBanner);
        if (getResources().getConfiguration().locale.equals(Locale.ENGLISH)) {
            imageViewBanner.setImageResource(R.drawable.banner_en);
        }
        if (getResources().getConfiguration().locale.equals(Locale.TRADITIONAL_CHINESE)) {
            imageViewBanner.setImageResource(R.drawable.banner_tc);
        }
        if (getResources().getConfiguration().locale.equals(Locale.SIMPLIFIED_CHINESE)) {
            imageViewBanner.setImageResource(R.drawable.banner_sc);
        }
        return view;
    }

    @SuppressWarnings("unchecked")
    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.buttonMore:
                activityInterface.getContainer().setFragmentChild(CategoryFragment.newInstance());
                break;
        }
    }
}