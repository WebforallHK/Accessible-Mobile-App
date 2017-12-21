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

import static hk.gov.ogcio.wcag.application.Config.SETTINGS_AUTO_UPDATE;

public class AutoUpdateFragment extends FragmentManager implements View.OnClickListener, CompoundButton.OnCheckedChangeListener, View.OnTouchListener {

    private boolean autoUpdate;

    public static AutoUpdateFragment newInstance() {
        return new AutoUpdateFragment();
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        activityInterface.getContainer().linearLayoutMenu.setVisibility(View.VISIBLE);
        activityInterface.getContainer().toolbar.setVisibility(View.VISIBLE);
    }

    @Override
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle savedInstanceState) {
        View view = layoutInflater.inflate(R.layout.fragment_auto_update, viewGroup, false);
        activityInterface.getContainer().setTitle(getString(R.string.settings_auto_update));
        view.setLongClickable(true);
        view.setOnTouchListener(this);
        view.findViewById(R.id.buttonConfirm).setOnClickListener(this);
        autoUpdate = sharedPreferences.getBoolean(SETTINGS_AUTO_UPDATE, false);
        RadioButton radioButtonOn = view.findViewById(R.id.radioButtonOn);
        RadioButton radioButtonOff = view.findViewById(R.id.radioButtonOff);
        if (autoUpdate) {
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
                sharedPreferences.edit().putBoolean(SETTINGS_AUTO_UPDATE, autoUpdate).apply();
                activityInterface.getContainer().backToPreviousFragment();
                break;
        }
    }

    @Override
    public void onCheckedChanged(CompoundButton compoundButton, boolean b) {
        if (b) {
            switch (compoundButton.getId()) {
                case R.id.radioButtonOn:
                    autoUpdate = true;
                    break;
                case R.id.radioButtonOff:
                    autoUpdate = false;
                    break;
            }
        }
    }

    @Override
    public boolean onTouch(View view, MotionEvent motionEvent) {
        return gestureDetector.onTouchEvent(motionEvent);
    }
}