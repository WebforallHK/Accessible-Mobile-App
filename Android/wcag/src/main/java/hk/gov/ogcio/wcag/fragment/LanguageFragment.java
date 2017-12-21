package hk.gov.ogcio.wcag.fragment;

import android.content.res.Configuration;
import android.content.res.Resources;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CompoundButton;
import android.widget.RadioButton;

import java.util.Locale;

import hk.gov.ogcio.wcag.R;
import hk.gov.ogcio.wcag.manager.FragmentManager;

import static hk.gov.ogcio.wcag.application.Config.SETTINGS_LANGUAGE;

public class LanguageFragment extends FragmentManager implements View.OnClickListener, CompoundButton.OnCheckedChangeListener, View.OnTouchListener {

    private Locale locale;

    public static LanguageFragment newInstance() {
        return new LanguageFragment();
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        activityInterface.getContainer().linearLayoutMenu.setVisibility(View.VISIBLE);
        activityInterface.getContainer().toolbar.setVisibility(View.VISIBLE);
    }

    @Override
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle savedInstanceState) {
        View view = layoutInflater.inflate(R.layout.fragment_language, viewGroup, false);
        activityInterface.getContainer().setTitle(getString(R.string.title_choose_a_language));
        view.setLongClickable(true);
        view.setOnTouchListener(this);
        view.findViewById(R.id.buttonConfirm).setOnClickListener(this);
        RadioButton radioButtonEnglish = view.findViewById(R.id.radioButtonEnglish);
        RadioButton radioButtonTraditionalChinese = view.findViewById(R.id.radioButtonTraditionalChinese);
        RadioButton radioButtonSimplifiedChinese = view.findViewById(R.id.radioButtonSimplifiedChinese);
        locale = getResources().getConfiguration().locale;
        if (locale.equals(Locale.ENGLISH)) {
            radioButtonEnglish.setChecked(true);
        }
        if (locale.equals(Locale.TRADITIONAL_CHINESE)) {
            radioButtonTraditionalChinese.setChecked(true);
        }
        if (locale.equals(Locale.SIMPLIFIED_CHINESE)) {
            radioButtonSimplifiedChinese.setChecked(true);
        }
        radioButtonEnglish.setOnCheckedChangeListener(this);
        radioButtonTraditionalChinese.setOnCheckedChangeListener(this);
        radioButtonSimplifiedChinese.setOnCheckedChangeListener(this);
        return view;
    }

    @SuppressWarnings("unchecked")
    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.buttonConfirm:
                sharedPreferences.edit().putString(SETTINGS_LANGUAGE, String.valueOf(locale)).apply();
                Resources resources = getResources();
                DisplayMetrics displayMetrics = resources.getDisplayMetrics();
                Configuration configuration = resources.getConfiguration();
                configuration.setLocale(locale);
                resources.updateConfiguration(configuration, displayMetrics);
                activityInterface.getContainer().menuButton[0].setText(getString(R.string.menu_home));
                activityInterface.getContainer().menuButton[1].setText(getString(R.string.menu_about_web_mobile_app_accessibility_campaign));
                activityInterface.getContainer().menuButton[2].setText(getString(R.string.menu_seminars_and_technical_workshops));
                activityInterface.getContainer().menuButton[3].setText(getString(R.string.menu_webforall_video_channel));
                activityInterface.getContainer().menuButton[4].setText(getString(R.string.menu_settings));
                activityInterface.getContainer().menuButton[5].setText(getString(R.string.menu_contact_us));
                activityInterface.getContainer().updateLanguage(locale);
                activityInterface.getContainer().backToPreviousFragment();
                break;
        }
    }

    @Override
    public void onCheckedChanged(CompoundButton compoundButton, boolean b) {
        if (b) {
            switch (compoundButton.getId()) {
                case R.id.radioButtonEnglish:
                    locale = Locale.ENGLISH;
                    break;
                case R.id.radioButtonTraditionalChinese:
                    locale = Locale.TRADITIONAL_CHINESE;
                    break;
                case R.id.radioButtonSimplifiedChinese:
                    locale = Locale.SIMPLIFIED_CHINESE;
                    break;
            }
        }
    }

    @Override
    public boolean onTouch(View view, MotionEvent motionEvent) {
        return gestureDetector.onTouchEvent(motionEvent);
    }
}