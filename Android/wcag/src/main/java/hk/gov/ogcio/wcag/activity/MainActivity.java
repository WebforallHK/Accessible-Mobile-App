package hk.gov.ogcio.wcag.activity;

import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.media.MediaPlayer;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.text.TextUtils;
import android.util.DisplayMetrics;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.util.LinkedList;
import java.util.List;
import java.util.Locale;

import hk.gov.ogcio.wcag.R;
import hk.gov.ogcio.wcag.application.ActivityInterface;
import hk.gov.ogcio.wcag.application.Config;
import hk.gov.ogcio.wcag.fragment.AcknowledgementFragment;
import hk.gov.ogcio.wcag.fragment.ConfirmFragment;
import hk.gov.ogcio.wcag.fragment.IntroductionFragment;
import hk.gov.ogcio.wcag.fragment.SeminarListFragment;
import hk.gov.ogcio.wcag.fragment.SettingsFragment;
import hk.gov.ogcio.wcag.fragment.SplashFragment;
import hk.gov.ogcio.wcag.fragment.VideoListFragment;
import hk.gov.ogcio.wcag.fragment.WebViewFragment;

import static hk.gov.ogcio.wcag.application.Config.SETTINGS_FONT_SIZE;
import static hk.gov.ogcio.wcag.application.Config.SETTINGS_LANGUAGE;

public class MainActivity extends AppCompatActivity implements ActivityInterface, View.OnClickListener {

    public GetVideoFragment getVideoFragment;
    public boolean isFullscreen = false;
    public Toolbar toolbar;
    public ImageButton imageButtonMenu;
    public LinearLayout linearLayoutMenu;
    public TextView textViewTitle;
    public MediaPlayer mediaPlayer;
    public Button[] menuButton = new Button[6];
    private boolean isDisallowBack = true;
    private ImageButton imageButtonBack;
    private List<Fragment> childFragmentStack = new LinkedList<>();
    private SharedPreferences sharedPreferences;
    private View viewContent;
    private View viewMenu;
    private boolean isPaused = true;
    private boolean setFragmentAfterResume = false;
    private Fragment currentFragment;
    private String title;
    private ImageButton imageButtonAbout;
    private ImageButton imageButtonSeminars;
    private ImageButton imageButtonVideo;
    private ImageButton imageButtonSettings;
    private ImageButton imageButtonContact;

    @SuppressWarnings("unchecked")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        sharedPreferences = PreferenceManager.getDefaultSharedPreferences(this);
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
        setContentView(R.layout.activity_main);
        setView();
        setHomeFragment(SplashFragment.newInstance());
        Config.language = sharedPreferences.getString(SETTINGS_LANGUAGE, "en");
        if (sharedPreferences.getBoolean(Config.SETTINGS_BACKGROUND_MUSIC, false)) {
            startBackgroundMusic();
        }
    }

    private void setView() {
        linearLayoutMenu = (LinearLayout) findViewById(R.id.linearLayoutMenu);
        imageButtonAbout = (ImageButton) findViewById(R.id.imageButtonAbout);
        imageButtonAbout.setOnClickListener(this);
        imageButtonSeminars = (ImageButton) findViewById(R.id.imageButtonSeminars);
        imageButtonSeminars.setOnClickListener(this);
        imageButtonVideo = (ImageButton) findViewById(R.id.imageButtonVideo);
        imageButtonVideo.setOnClickListener(this);
        imageButtonSettings = (ImageButton) findViewById(R.id.imageButtonSettings);
        imageButtonSettings.setOnClickListener(this);
        imageButtonContact = (ImageButton) findViewById(R.id.imageButtonContact);
        imageButtonContact.setOnClickListener(this);

        menuButton[0] = (Button) findViewById(R.id.button0);
        menuButton[0].setOnClickListener(this);
        menuButton[1] = (Button) findViewById(R.id.button1);
        menuButton[1].setOnClickListener(this);
        menuButton[2] = (Button) findViewById(R.id.button2);
        menuButton[2].setOnClickListener(this);
        menuButton[3] = (Button) findViewById(R.id.button3);
        menuButton[3].setOnClickListener(this);
        menuButton[4] = (Button) findViewById(R.id.button4);
        menuButton[4].setOnClickListener(this);
        menuButton[5] = (Button) findViewById(R.id.button5);
        menuButton[5].setOnClickListener(this);

        imageButtonBack = (ImageButton) findViewById(R.id.imageButtonBack);
        imageButtonBack.setOnClickListener(this);
        imageButtonMenu = (ImageButton) findViewById(R.id.imageButtonMenu);
        imageButtonMenu.setOnClickListener(this);
        textViewTitle = (TextView) findViewById(R.id.textViewTitle);
        toolbar = (Toolbar) findViewById(R.id.toolbar);
        viewContent = findViewById(R.id.viewContent);
        viewMenu = findViewById(R.id.viewMenu);
        setSupportActionBar(toolbar);
    }

    public void startBackgroundMusic() {
        mediaPlayer = MediaPlayer.create(this, R.raw.background);
        mediaPlayer.setLooping(true);
        mediaPlayer.start();
    }

    public void stopBackgroundMusic() {
        try {
            if (mediaPlayer != null && mediaPlayer.isPlaying()) {
                mediaPlayer.stop();
                mediaPlayer.release();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void onBackPressed() {
        if (isFullscreen) {
            getVideoFragment.setFullscreen();
        } else if (viewMenu.getVisibility() == View.VISIBLE) {
            triggerMenu();
        } else if (childFragmentStack.size() > 1) {
            if (!isDisallowBack) {
                backToPreviousFragment();
            }
        } else {
            new AlertDialog.Builder(MainActivity.this, R.style.alertDialogStyle)
                    .setMessage(R.string.do_you_want_to_close_this_application)
                    .setCancelable(false)
                    .setNegativeButton(android.R.string.cancel, null)
                    .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            finish();
                        }
                    })
                    .show();
        }
    }

    @Override
    public void onResume() {
        super.onResume();
        isPaused = false;
        if (setFragmentAfterResume) {
            setFragmentAfterResume = false;
            setFragmentChild(currentFragment);
        }
        if (sharedPreferences.getBoolean(Config.SETTINGS_BACKGROUND_MUSIC, false)) {
            mediaPlayer.start();
        }
    }

    @Override
    public void onPause() {
        super.onPause();
        isPaused = true;
        if (sharedPreferences.getBoolean(Config.SETTINGS_BACKGROUND_MUSIC, false)) {
            mediaPlayer.pause();
        }
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        if (sharedPreferences.getBoolean(Config.SETTINGS_BACKGROUND_MUSIC, false)) {
            stopBackgroundMusic();
        }
    }

    public void setTitle(String title) {
        if (textViewTitle != null) {
            textViewTitle.setText(title);
        }
    }

    public void setDisallowBack(boolean isDisallowBack) {
        this.isDisallowBack = isDisallowBack;
        if (isDisallowBack) {
            imageButtonBack.setVisibility(View.INVISIBLE);
        } else {
            imageButtonBack.setVisibility(View.VISIBLE);
        }
    }

    public void setHomeFragment(Fragment fragment) {
        imageButtonBack.setVisibility(View.INVISIBLE);
        FragmentTransaction fragmentTransaction = getSupportFragmentManager().beginTransaction();
        if (childFragmentStack.size() != 0) {
            fragmentTransaction.remove(childFragmentStack.get(childFragmentStack.size() - 1));
            childFragmentStack.clear();
        }
        fragmentTransaction.add(R.id.frameLayout, fragment).commitAllowingStateLoss();
        childFragmentStack.add(fragment);
    }

    public void setFragmentParent(Fragment fragment) {
        setFragment(fragment, childFragmentStack.get(childFragmentStack.size() - 1));
        childFragmentStack = new LinkedList<>();
        childFragmentStack.add(fragment);
        String language = "en";
        if (TextUtils.equals(Config.language, String.valueOf(Locale.TRADITIONAL_CHINESE))) {
            language = "tc";
        }
        if (TextUtils.equals(Config.language, String.valueOf(Locale.SIMPLIFIED_CHINESE))) {
            language = "sc";
        }
        imageButtonAbout.setImageResource(getResources().getIdentifier("nav_about_" + language, "drawable", getPackageName()));
        imageButtonSeminars.setImageResource(getResources().getIdentifier("nav_seminars_" + language, "drawable", getPackageName()));
        imageButtonVideo.setImageResource(getResources().getIdentifier("nav_video_" + language, "drawable", getPackageName()));
        imageButtonSettings.setImageResource(getResources().getIdentifier("nav_setting_" + language, "drawable", getPackageName()));
        imageButtonContact.setImageResource(getResources().getIdentifier("nav_contact_" + language, "drawable", getPackageName()));
        imageButtonAbout.setContentDescription(getString(R.string.title_about_web_mobile_app_accessibility_campaign));
        imageButtonSeminars.setContentDescription(getString(R.string.title_seminars_and_technical_workshops));
        imageButtonVideo.setContentDescription(getString(R.string.title_webforall_video_channel));
        imageButtonSettings.setContentDescription(getString(R.string.title_settings));
        imageButtonContact.setContentDescription(getString(R.string.title_contact_us));
        if (fragment instanceof IntroductionFragment) {
            imageButtonAbout.setImageResource(getResources().getIdentifier("nav_about_o_" + language, "drawable", getPackageName()));
            imageButtonAbout.setContentDescription(imageButtonAbout.getContentDescription() + getString(R.string.selected));
        }
        if (fragment instanceof SeminarListFragment) {
            imageButtonSeminars.setImageResource(getResources().getIdentifier("nav_seminars_o_" + language, "drawable", getPackageName()));
            imageButtonSeminars.setContentDescription(imageButtonSeminars.getContentDescription() + getString(R.string.selected));
        }
        if (fragment instanceof VideoListFragment) {
            imageButtonVideo.setImageResource(getResources().getIdentifier("nav_video_o_" + language, "drawable", getPackageName()));
            imageButtonVideo.setContentDescription(imageButtonVideo.getContentDescription() + getString(R.string.selected));
        }
        if (fragment instanceof SettingsFragment) {
            imageButtonSettings.setImageResource(getResources().getIdentifier("nav_setting_o_" + language, "drawable", getPackageName()));
            imageButtonSettings.setContentDescription(imageButtonSettings.getContentDescription() + getString(R.string.selected));
        }
        if (fragment instanceof WebViewFragment) {
            imageButtonContact.setImageResource(getResources().getIdentifier("nav_contact_o_" + language, "drawable", getPackageName()));
            imageButtonContact.setContentDescription(imageButtonContact.getContentDescription() + getString(R.string.selected));
        }
        isDisallowBack = true;
        imageButtonBack.setVisibility(View.INVISIBLE);
    }

    public void setFragmentChild(Fragment fragment) {
        if (fragment instanceof ConfirmFragment || fragment instanceof AcknowledgementFragment) {
            setDisallowBack(true);
        } else {
            setDisallowBack(false);
        }
        if (childFragmentStack.size() > 0) {
            currentFragment = fragment;
            if (!isPaused) {
                setFragment(fragment, childFragmentStack.get(childFragmentStack.size() - 1));
                childFragmentStack.add(fragment);
            } else {
                setFragmentAfterResume = true;
            }
        }
    }

    public void backToPreviousFragment() {
        if (childFragmentStack.size() == 2) {
            imageButtonBack.setVisibility(View.INVISIBLE);
        }
        Fragment newFragment = childFragmentStack.get(childFragmentStack.size() - 2);
        Fragment currentFragment = childFragmentStack.remove(childFragmentStack.size() - 1);
        setFragment(newFragment, currentFragment);
    }

    public void removeLastFragment() {
        childFragmentStack.remove(childFragmentStack.size() - 1);
    }

    private void setFragment(Fragment fragment, Fragment oldFragment) {
        FragmentTransaction fragmentTransaction = getSupportFragmentManager().beginTransaction();
        if (oldFragment != null && fragment != oldFragment) {
            fragmentTransaction.remove(oldFragment);
        }
        fragmentTransaction.replace(R.id.frameLayout, fragment).commitAllowingStateLoss();
    }

    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.imageButtonAbout:
                setFragmentParent(IntroductionFragment.newInstance());
                break;
            case R.id.imageButtonSeminars:
                setFragmentParent(SeminarListFragment.newInstance());
                break;
            case R.id.imageButtonVideo:
                setFragmentParent(VideoListFragment.newInstance());
                break;
            case R.id.imageButtonSettings:
                setFragmentParent(SettingsFragment.newInstance());
                break;
            case R.id.imageButtonContact:
                setFragmentParent(WebViewFragment.newInstance(getString(R.string.title_contact_us)));
                break;
            case R.id.button0:
                setFragmentParent(SplashFragment.newInstance());
                triggerMenu();
                break;
            case R.id.button1:
                setFragmentParent(IntroductionFragment.newInstance());
                triggerMenu();
                break;
            case R.id.button2:
                setFragmentParent(SeminarListFragment.newInstance());
                triggerMenu();
                break;
            case R.id.button3:
                setFragmentParent(VideoListFragment.newInstance());
                triggerMenu();
                break;
            case R.id.button4:
                setFragmentParent(SettingsFragment.newInstance());
                triggerMenu();
                break;
            case R.id.button5:
                setFragmentParent(WebViewFragment.newInstance(getString(R.string.title_contact_us)));
                triggerMenu();
                break;
            case R.id.imageButtonBack:
                if (!isDisallowBack) {
                    backToPreviousFragment();
                }
                break;
            case R.id.imageButtonMenu:
                triggerMenu();
                break;
        }
    }

    public void triggerMenu() {
        Locale locale = Locale.ENGLISH;
        String language = sharedPreferences.getString(SETTINGS_LANGUAGE, String.valueOf(Locale.ENGLISH));
        if (TextUtils.equals(language, String.valueOf(Locale.ENGLISH))) {
            locale = Locale.ENGLISH;
        }
        if (TextUtils.equals(language, String.valueOf(Locale.TRADITIONAL_CHINESE))) {
            locale = Locale.TRADITIONAL_CHINESE;
        }
        if (TextUtils.equals(language, String.valueOf(Locale.SIMPLIFIED_CHINESE))) {
            locale = Locale.SIMPLIFIED_CHINESE;
        }
        Resources resources = getResources();
        DisplayMetrics displayMetrics = resources.getDisplayMetrics();
        Configuration configuration = resources.getConfiguration();
        configuration.setLocale(locale);
        resources.updateConfiguration(configuration, displayMetrics);


        if (viewMenu.getVisibility() == View.VISIBLE) {
            if (childFragmentStack.size() > 1) {
                imageButtonBack.setVisibility(View.VISIBLE);
            }
            textViewTitle.setText(title);
            viewContent.setVisibility(View.VISIBLE);
            viewMenu.setVisibility(View.GONE);
        } else {
            if (childFragmentStack.size() > 1) {
                imageButtonBack.setVisibility(View.INVISIBLE);
            }
            title = textViewTitle.getText().toString();
            textViewTitle.setText(R.string.title_menu);
            viewContent.setVisibility(View.GONE);
            viewMenu.setVisibility(View.VISIBLE);
        }
    }

    public void updateLanguage(Locale locale) {
        Config.language = String.valueOf(locale);
        imageButtonMenu.setContentDescription(getString(R.string.button_menu));
        imageButtonBack.setContentDescription(getString(R.string.button_back));

        imageButtonAbout.setContentDescription(getString(R.string.title_about_web_mobile_app_accessibility_campaign));
        imageButtonSeminars.setContentDescription(getString(R.string.title_seminars_and_technical_workshops));
        imageButtonVideo.setContentDescription(getString(R.string.title_webforall_video_channel));
        imageButtonSettings.setContentDescription(getString(R.string.title_settings) + getString(R.string.selected));
        imageButtonContact.setContentDescription(getString(R.string.title_contact_us));

        String language = "en";
        if (TextUtils.equals(Config.language, String.valueOf(Locale.TRADITIONAL_CHINESE))) {
            language = "tc";
        }
        if (TextUtils.equals(Config.language, String.valueOf(Locale.SIMPLIFIED_CHINESE))) {
            language = "sc";
        }
        imageButtonAbout.setImageResource(getResources().getIdentifier("nav_about_" + language, "drawable", getPackageName()));
        imageButtonSeminars.setImageResource(getResources().getIdentifier("nav_seminars_" + language, "drawable", getPackageName()));
        imageButtonVideo.setImageResource(getResources().getIdentifier("nav_video_" + language, "drawable", getPackageName()));
        imageButtonSettings.setImageResource(getResources().getIdentifier("nav_setting_o_" + language, "drawable", getPackageName()));
        imageButtonContact.setImageResource(getResources().getIdentifier("nav_contact_" + language, "drawable", getPackageName()));
    }

    public void updateTextSize() {
        float fontSize = sharedPreferences.getFloat(SETTINGS_FONT_SIZE, 0.2f);
        textViewTitle.setTextSize((fontSize + 0.8f) * 18.0f);
        DisplayMetrics metrics = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(metrics);

        float yInches = metrics.heightPixels / metrics.ydpi;
        float xInches = metrics.widthPixels / metrics.xdpi;
        double diagonalInches = Math.sqrt(xInches * xInches + yInches * yInches);
        if (diagonalInches >= 7.5) {
            menuButton[0].setTextSize((fontSize + 0.8f) * 22.0f);
            menuButton[1].setTextSize((fontSize + 0.8f) * 22.0f);
            menuButton[2].setTextSize((fontSize + 0.8f) * 22.0f);
            menuButton[3].setTextSize((fontSize + 0.8f) * 22.0f);
            menuButton[4].setTextSize((fontSize + 0.8f) * 22.0f);
            menuButton[5].setTextSize((fontSize + 0.8f) * 22.0f);
        } else if (diagonalInches >= 6.5) {
            menuButton[0].setTextSize((fontSize + 0.8f) * 18.0f);
            menuButton[1].setTextSize((fontSize + 0.8f) * 18.0f);
            menuButton[2].setTextSize((fontSize + 0.8f) * 18.0f);
            menuButton[3].setTextSize((fontSize + 0.8f) * 18.0f);
            menuButton[4].setTextSize((fontSize + 0.8f) * 18.0f);
            menuButton[5].setTextSize((fontSize + 0.8f) * 18.0f);
        } else {
            menuButton[0].setTextSize((fontSize + 0.8f) * 14.0f);
            menuButton[1].setTextSize((fontSize + 0.8f) * 14.0f);
            menuButton[2].setTextSize((fontSize + 0.8f) * 14.0f);
            menuButton[3].setTextSize((fontSize + 0.8f) * 14.0f);
            menuButton[4].setTextSize((fontSize + 0.8f) * 14.0f);
            menuButton[5].setTextSize((fontSize + 0.8f) * 14.0f);
        }
    }

    @Override
    public MainActivity getContainer() {
        return this;
    }

    public interface GetVideoFragment {
        void setFullscreen();
    }
}