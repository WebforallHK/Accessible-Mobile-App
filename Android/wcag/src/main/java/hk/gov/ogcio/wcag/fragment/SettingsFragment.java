package hk.gov.ogcio.wcag.fragment;

import android.os.Bundle;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import java.util.Locale;

import hk.gov.ogcio.wcag.R;
import hk.gov.ogcio.wcag.manager.FragmentManager;

import static hk.gov.ogcio.wcag.application.Config.SETTINGS_AUTO_UPDATE;
import static hk.gov.ogcio.wcag.application.Config.SETTINGS_BACKGROUND_MUSIC;
import static hk.gov.ogcio.wcag.application.Config.SETTINGS_FONT_SIZE;
import static hk.gov.ogcio.wcag.application.Config.SETTINGS_LANGUAGE;

public class SettingsFragment extends FragmentManager implements View.OnClickListener {

    public static SettingsFragment newInstance() {
        return new SettingsFragment();
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        activityInterface.getContainer().linearLayoutMenu.setVisibility(View.VISIBLE);
        activityInterface.getContainer().toolbar.setVisibility(View.VISIBLE);
    }

    @Override
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle savedInstanceState) {
        View view = layoutInflater.inflate(R.layout.fragment_settings, viewGroup, false);
        activityInterface.getContainer().setTitle(getString(R.string.title_settings));
        view.findViewById(R.id.constraintLayoutFontSize).setOnClickListener(this);
        view.findViewById(R.id.constraintLayoutLanguage).setOnClickListener(this);
        view.findViewById(R.id.constraintLayoutPushNofitication).setOnClickListener(this);
        view.findViewById(R.id.constraintLayoutAutoUpdate).setOnClickListener(this);
        view.findViewById(R.id.constraintLayoutBackgroundMusic).setOnClickListener(this);
        TextView textViewAutoUpdate = view.findViewById(R.id.textViewAutoUpdate);
        textViewAutoUpdate.setText(sharedPreferences.getBoolean(SETTINGS_AUTO_UPDATE, false) ? getString(R.string.settings_on) : getString(R.string.settings_off));
        TextView textViewBackgroundMusic = view.findViewById(R.id.textViewBackgroundMusic);
        textViewBackgroundMusic.setText(sharedPreferences.getBoolean(SETTINGS_BACKGROUND_MUSIC, false) ? getString(R.string.settings_on) : getString(R.string.settings_off));
        TextView textViewFontSize = view.findViewById(R.id.textViewFontSize);
        float fontSize = sharedPreferences.getFloat(SETTINGS_FONT_SIZE, 0.2f);
        if (fontSize == 0.0f) {
            textViewFontSize.setText(getString(R.string.settings_small));
        } else if (fontSize == 0.2f) {
            textViewFontSize.setText(getString(R.string.settings_medium));
        } else if (fontSize == 0.4f) {
            textViewFontSize.setText(getString(R.string.settings_large));
        }
        TextView textViewLanguage = view.findViewById(R.id.textViewLanguage);
        String language = sharedPreferences.getString(SETTINGS_LANGUAGE, String.valueOf(Locale.ENGLISH));
        if (TextUtils.equals(language, String.valueOf(Locale.ENGLISH))) {
            textViewLanguage.setText(getString(R.string.settings_english));
        }
        if (TextUtils.equals(language, String.valueOf(Locale.TRADITIONAL_CHINESE))) {
            textViewLanguage.setText(getString(R.string.settings_traditional_chinese));
        }
        if (TextUtils.equals(language, String.valueOf(Locale.SIMPLIFIED_CHINESE))) {
            textViewLanguage.setText(getString(R.string.settings_simplified_chinese));
        }
        return view;
    }

    @SuppressWarnings("unchecked")
    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.constraintLayoutFontSize:
                activityInterface.getContainer().setFragmentChild(FontSizeFragment.newInstance());
                break;
            case R.id.constraintLayoutLanguage:
                activityInterface.getContainer().setFragmentChild(LanguageFragment.newInstance());
                break;
            case R.id.constraintLayoutPushNofitication:
                activityInterface.getContainer().setFragmentChild(PushNotificationFragment.newInstance());
                break;
            case R.id.constraintLayoutAutoUpdate:
                activityInterface.getContainer().setFragmentChild(AutoUpdateFragment.newInstance());
                break;
            case R.id.constraintLayoutBackgroundMusic:
                activityInterface.getContainer().setFragmentChild(BackgroundMusicFragment.newInstance());
                break;
        }
    }
}