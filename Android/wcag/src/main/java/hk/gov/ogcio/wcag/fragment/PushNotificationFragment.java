package hk.gov.ogcio.wcag.fragment;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;

import hk.gov.ogcio.wcag.R;
import hk.gov.ogcio.wcag.manager.FragmentManager;

import static hk.gov.ogcio.wcag.application.Config.SETTINGS_RINGTONE;
import static hk.gov.ogcio.wcag.application.Config.SETTINGS_VIBRATION;

public class PushNotificationFragment extends FragmentManager implements View.OnClickListener, View.OnTouchListener {

    private CheckBox checkBoxRingtone;
    private CheckBox checkBoxVibration;

    public static PushNotificationFragment newInstance() {
        return new PushNotificationFragment();
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        activityInterface.getContainer().linearLayoutMenu.setVisibility(View.VISIBLE);
        activityInterface.getContainer().toolbar.setVisibility(View.VISIBLE);
    }

    @Override
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle savedInstanceState) {
        View view = layoutInflater.inflate(R.layout.fragment_push_notification, viewGroup, false);
        activityInterface.getContainer().setTitle(getString(R.string.title_push_notification));
        view.setLongClickable(true);
        view.setOnTouchListener(this);
        view.findViewById(R.id.buttonConfirm).setOnClickListener(this);
        checkBoxRingtone = view.findViewById(R.id.checkBoxRingtone);
        checkBoxRingtone.setChecked(sharedPreferences.getBoolean(SETTINGS_RINGTONE, false));
        checkBoxVibration = view.findViewById(R.id.checkBoxVibration);
        checkBoxVibration.setChecked(sharedPreferences.getBoolean(SETTINGS_VIBRATION, false));
        return view;
    }

    @SuppressWarnings("unchecked")
    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.buttonConfirm:
                sharedPreferences.edit().putBoolean(SETTINGS_RINGTONE, checkBoxRingtone.isChecked()).apply();
                sharedPreferences.edit().putBoolean(SETTINGS_VIBRATION, checkBoxVibration.isChecked()).apply();
                activityInterface.getContainer().backToPreviousFragment();
                break;
        }
    }

    @Override
    public boolean onTouch(View view, MotionEvent motionEvent) {
        return gestureDetector.onTouchEvent(motionEvent);
    }
}