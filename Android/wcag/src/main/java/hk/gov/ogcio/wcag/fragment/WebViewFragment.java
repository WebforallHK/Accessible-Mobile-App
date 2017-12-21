package hk.gov.ogcio.wcag.fragment;

import android.content.res.Configuration;
import android.content.res.Resources;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.DisplayMetrics;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebSettings;
import android.webkit.WebView;

import java.util.Locale;

import hk.gov.ogcio.wcag.R;
import hk.gov.ogcio.wcag.manager.FragmentManager;

import static hk.gov.ogcio.wcag.application.Config.SETTINGS_FONT_SIZE;
import static hk.gov.ogcio.wcag.application.Config.SETTINGS_LANGUAGE;

public class WebViewFragment extends FragmentManager implements View.OnTouchListener {

    private String title;

    public static WebViewFragment newInstance(String title) {
        WebViewFragment webViewFragment = new WebViewFragment();
        webViewFragment.title = title;
        return webViewFragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        activityInterface.getContainer().linearLayoutMenu.setVisibility(View.VISIBLE);
        activityInterface.getContainer().toolbar.setVisibility(View.VISIBLE);
    }

    @Override
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle savedInstanceState) {
        View view = layoutInflater.inflate(R.layout.fragment_web_view, viewGroup, false);

        String page = "contact_us";
        if (TextUtils.equals(title, getString(R.string.government_leadership))) {
            page = "government_leadership";
        }
        if (TextUtils.equals(title, getString(R.string.fostering_awareness))) {
            page = "fostering_awareness";
        }
        if (TextUtils.equals(title, getString(R.string.promulgating_guidelines_and_tips))) {
            page = "promulgating_guidelines_and_tips";
        }
        if (TextUtils.equals(title, getString(R.string.nurturing_expertise))) {
            page = "nurturing_expertise";
        }
        if (TextUtils.equals(title, getString(R.string.title_contact_us))) {
            page = "contact_us";
        }

        String lang = "en";
        if (TextUtils.equals(sharedPreferences.getString(SETTINGS_LANGUAGE, null), String.valueOf(Locale.TRADITIONAL_CHINESE))) {
            lang = "tc";
        }
        if (TextUtils.equals(sharedPreferences.getString(SETTINGS_LANGUAGE, null), String.valueOf(Locale.SIMPLIFIED_CHINESE))) {
            lang = "sc";
        }
        Locale locale = Locale.ENGLISH;
        if (TextUtils.equals(sharedPreferences.getString(SETTINGS_LANGUAGE, null), String.valueOf(Locale.TRADITIONAL_CHINESE))) {
            locale = Locale.TRADITIONAL_CHINESE;
        }
        if (TextUtils.equals(sharedPreferences.getString(SETTINGS_LANGUAGE, null), String.valueOf(Locale.SIMPLIFIED_CHINESE))) {
            locale = Locale.SIMPLIFIED_CHINESE;
        }

        Resources resources = getResources();
        DisplayMetrics displayMetrics = resources.getDisplayMetrics();
        Configuration configuration = resources.getConfiguration();
        configuration.setLocale(locale);
        resources.updateConfiguration(configuration, displayMetrics);

        switch (page) {
            case "government_leadership":
                title = getString(R.string.government_leadership);
                break;
            case "fostering_awareness":
                title = getString(R.string.fostering_awareness);
                break;
            case "promulgating_guidelines_and_tips":
                title = getString(R.string.promulgating_guidelines_and_tips);
                break;
            case "nurturing_expertise":
                title = getString(R.string.nurturing_expertise);
                break;
            case "contact_us":
                title = getString(R.string.title_contact_us);
                break;
        }

        activityInterface.getContainer().setTitle(title);
        WebView webView = view.findViewById(R.id.webView);
        webView.setOnTouchListener(this);
        WebSettings webSettings = webView.getSettings();
        float fontSize = sharedPreferences.getFloat(SETTINGS_FONT_SIZE, 0.2f);


        DisplayMetrics metrics = new DisplayMetrics();
        activity.getWindowManager().getDefaultDisplay().getMetrics(metrics);

        float yInches = metrics.heightPixels / metrics.ydpi;
        float xInches = metrics.widthPixels / metrics.xdpi;
        double diagonalInches = Math.sqrt(xInches * xInches + yInches * yInches);
        if (diagonalInches >= 6.5) {
            if (fontSize == 0.0f) {
                webSettings.setTextZoom(140);
            } else if (fontSize == 0.2f) {
                webSettings.setTextZoom(180);
            } else if (fontSize == 0.4f) {
                webSettings.setTextZoom(200);
            }
        } else if (diagonalInches >= 6.5) {
            if (fontSize == 0.0f) {
                webSettings.setTextZoom(120);
            } else if (fontSize == 0.2f) {
                webSettings.setTextZoom(140);
            } else if (fontSize == 0.4f) {
                webSettings.setTextZoom(160);
            }
        } else {
            if (fontSize == 0.0f) {
                webSettings.setTextZoom(80);
            } else if (fontSize == 0.2f) {
                webSettings.setTextZoom(100);
            } else if (fontSize == 0.4f) {
                webSettings.setTextZoom(120);
            }
        }

        webView.loadUrl("file:///android_asset/" + page + "_" + lang + ".html");

        return view;
    }

    @Override
    public boolean onTouch(View view, MotionEvent motionEvent) {
        return gestureDetector.onTouchEvent(motionEvent);
    }
}