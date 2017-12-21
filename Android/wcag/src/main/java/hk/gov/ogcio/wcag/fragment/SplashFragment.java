package hk.gov.ogcio.wcag.fragment;

import android.content.DialogInterface;
import android.os.Build;
import android.os.Bundle;
import android.support.v7.app.AlertDialog;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import java.util.Locale;

import hk.gov.ogcio.wcag.R;
import hk.gov.ogcio.wcag.application.Config;
import hk.gov.ogcio.wcag.manager.FragmentManager;

public class SplashFragment extends FragmentManager implements View.OnClickListener {

    public static SplashFragment newInstance() {
        return new SplashFragment();
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        activityInterface.getContainer().linearLayoutMenu.setVisibility(View.GONE);
        activityInterface.getContainer().toolbar.setVisibility(View.GONE);
    }

    @Override
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle savedInstanceState) {
        View view = layoutInflater.inflate(R.layout.fragment_splash, viewGroup, false);
        view.findViewById(R.id.buttonStart).setOnClickListener(this);
        ImageView imageView = view.findViewById(R.id.imageView);
        if (TextUtils.equals(Config.language, String.valueOf(Locale.TRADITIONAL_CHINESE))) {
            imageView.setImageResource(R.drawable.landing_tc);
        }
        if (TextUtils.equals(Config.language, String.valueOf(Locale.SIMPLIFIED_CHINESE))) {
            imageView.setImageResource(R.drawable.landing_sc);
        }
        if (TextUtils.equals(Config.language, String.valueOf(Locale.ENGLISH))) {
            imageView.setImageResource(R.drawable.landing);
        }
        if (Build.VERSION.SDK_INT > 26 || Build.VERSION.SDK_INT < 19) {
            new AlertDialog.Builder(activity, R.style.alertDialogStyle)
                    .setMessage(R.string.text_version_alert)
                    .setCancelable(false)
                    .setPositiveButton(android.R.string.ok, null)
                    .setNegativeButton(R.string.button_leave_app, new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialogInterface, int i) {
                            System.exit(0);
                        }
                    })
                    .show();
        }
        return view;
    }

    @SuppressWarnings("unchecked")
    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.buttonStart:
                if (sharedPreferences.getBoolean("skip_welcome_screen", false)) {
                    activityInterface.getContainer().setFragmentParent(IntroductionFragment.newInstance());
                } else {
                    activityInterface.getContainer().setFragmentParent(WelcomeFragment.newInstance());
                }
                break;
        }
    }
}