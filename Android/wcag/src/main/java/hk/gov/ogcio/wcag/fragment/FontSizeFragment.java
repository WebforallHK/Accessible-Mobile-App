package hk.gov.ogcio.wcag.fragment;

import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CompoundButton;
import android.widget.RadioButton;

import hk.gov.ogcio.wcag.R;
import hk.gov.ogcio.wcag.manager.FragmentManager;

import static hk.gov.ogcio.wcag.application.Config.SETTINGS_FONT_SIZE;

public class FontSizeFragment extends FragmentManager implements View.OnClickListener, CompoundButton.OnCheckedChangeListener, View.OnTouchListener {

    private float fontSize;

    public static FontSizeFragment newInstance() {
        return new FontSizeFragment();
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        activityInterface.getContainer().linearLayoutMenu.setVisibility(View.VISIBLE);
        activityInterface.getContainer().toolbar.setVisibility(View.VISIBLE);
    }

    @Override
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle savedInstanceState) {
        View view = layoutInflater.inflate(R.layout.fragment_font_size, viewGroup, false);
        activityInterface.getContainer().setTitle(getString(R.string.title_choose_font_size));
        view.setLongClickable(true);
        view.setOnTouchListener(this);
        view.findViewById(R.id.buttonConfirm).setOnClickListener(this);
        RadioButton radioButtonSmall = view.findViewById(R.id.radioButtonSmall);
        fontSize = sharedPreferences.getFloat(SETTINGS_FONT_SIZE, 0.2f);
        RadioButton radioButtonMedium = view.findViewById(R.id.radioButtonMedium);
        RadioButton radioButtonLarge = view.findViewById(R.id.radioButtonLarge);

        DisplayMetrics metrics = new DisplayMetrics();
        activity.getWindowManager().getDefaultDisplay().getMetrics(metrics);

        float yInches = metrics.heightPixels / metrics.ydpi;
        float xInches = metrics.widthPixels / metrics.xdpi;
        double diagonalInches = Math.sqrt(xInches * xInches + yInches * yInches);
        if (diagonalInches >= 7.5) {
            radioButtonSmall.setTextSize(0.8f * 26.0f);
            radioButtonMedium.setTextSize(1.0f * 26.0f);
            radioButtonLarge.setTextSize(1.2f * 26.0f);
        } else if (diagonalInches >= 6.5) {
            radioButtonSmall.setTextSize(0.8f * 22.0f);
            radioButtonMedium.setTextSize(1.0f * 22.0f);
            radioButtonLarge.setTextSize(1.2f * 22.0f);
        } else {
            radioButtonSmall.setTextSize(0.8f * 18.0f);
            radioButtonMedium.setTextSize(1.0f * 18.0f);
            radioButtonLarge.setTextSize(1.2f * 18.0f);
        }

        if (fontSize == 0.0f) {
            radioButtonSmall.setChecked(true);
        }
        if (fontSize == 0.2f) {
            radioButtonMedium.setChecked(true);
        }
        if (fontSize == 0.4f) {
            radioButtonLarge.setChecked(true);
        }
        radioButtonSmall.setOnCheckedChangeListener(this);
        radioButtonMedium.setOnCheckedChangeListener(this);
        radioButtonLarge.setOnCheckedChangeListener(this);
        return view;
    }

    @SuppressWarnings("unchecked")
    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.buttonConfirm:
                sharedPreferences.edit().putFloat(SETTINGS_FONT_SIZE, fontSize).apply();
                activityInterface.getContainer().updateTextSize();
                activityInterface.getContainer().backToPreviousFragment();
                break;
        }
    }

    @Override
    public void onCheckedChanged(CompoundButton compoundButton, boolean b) {
        if (b) {
            switch (compoundButton.getId()) {
                case R.id.radioButtonSmall:
                    fontSize = 0.0f;
                    break;
                case R.id.radioButtonMedium:
                    fontSize = 0.2f;
                    break;
                case R.id.radioButtonLarge:
                    fontSize = 0.4f;
                    break;
            }
        }
    }

    @Override
    public boolean onTouch(View view, MotionEvent motionEvent) {
        return gestureDetector.onTouchEvent(motionEvent);
    }
}