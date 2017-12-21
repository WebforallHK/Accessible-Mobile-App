package hk.gov.ogcio.wcag.fragment;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CompoundButton;
import android.widget.RadioButton;

import hk.gov.ogcio.wcag.R;
import hk.gov.ogcio.wcag.manager.FragmentManager;

import static hk.gov.ogcio.wcag.application.Config.SETTINGS_BACKGROUND_MUSIC;

public class BackgroundMusicFragment extends FragmentManager implements View.OnClickListener, CompoundButton.OnCheckedChangeListener, View.OnTouchListener {

    private boolean backgroundMusic;

    public static BackgroundMusicFragment newInstance() {
        return new BackgroundMusicFragment();
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        activityInterface.getContainer().linearLayoutMenu.setVisibility(View.VISIBLE);
        activityInterface.getContainer().toolbar.setVisibility(View.VISIBLE);
    }

    @Override
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle savedInstanceState) {
        View view = layoutInflater.inflate(R.layout.fragment_background_music, viewGroup, false);
        activityInterface.getContainer().setTitle(getString(R.string.settings_background_music));
        view.setLongClickable(true);
        view.setOnTouchListener(this);
        view.findViewById(R.id.buttonConfirm).setOnClickListener(this);
        backgroundMusic = sharedPreferences.getBoolean(SETTINGS_BACKGROUND_MUSIC, false);
        RadioButton radioButtonOn = view.findViewById(R.id.radioButtonOn);
        RadioButton radioButtonOff = view.findViewById(R.id.radioButtonOff);
        if (backgroundMusic) {
            radioButtonOn.setChecked(true);
        } else {
            radioButtonOff.setChecked(true);
        }
        radioButtonOn.setOnCheckedChangeListener(this);
        radioButtonOff.setOnCheckedChangeListener(this);
        return view;
    }

    @SuppressWarnings("unchecked")
    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.buttonConfirm:
                if (backgroundMusic) {
                    if (!sharedPreferences.getBoolean(SETTINGS_BACKGROUND_MUSIC, false)) {
                        activityInterface.getContainer().startBackgroundMusic();
                    }
                } else {
                    activityInterface.getContainer().stopBackgroundMusic();
                }
                sharedPreferences.edit().putBoolean(SETTINGS_BACKGROUND_MUSIC, backgroundMusic).apply();
                activityInterface.getContainer().backToPreviousFragment();
                break;
        }
    }

    @Override
    public void onCheckedChanged(CompoundButton compoundButton, boolean b) {
        if (b) {
            switch (compoundButton.getId()) {
                case R.id.radioButtonOn:
                    backgroundMusic = true;
                    break;
                case R.id.radioButtonOff:
                    backgroundMusic = false;
                    break;
            }
        }
    }

    @Override
    public boolean onTouch(View view, MotionEvent motionEvent) {
        return gestureDetector.onTouchEvent(motionEvent);
    }
}