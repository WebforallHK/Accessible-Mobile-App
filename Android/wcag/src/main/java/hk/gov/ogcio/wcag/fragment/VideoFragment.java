package hk.gov.ogcio.wcag.fragment;

import android.content.res.Configuration;
import android.content.res.Resources;
import android.media.MediaPlayer;
import android.os.Bundle;
import android.support.constraint.ConstraintLayout;
import android.text.TextUtils;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.TextView;

import java.util.HashMap;
import java.util.Locale;

import hk.gov.ogcio.wcag.R;
import hk.gov.ogcio.wcag.activity.MainActivity;
import hk.gov.ogcio.wcag.manager.FragmentManager;
import hk.gov.ogcio.wcag.widget.videoview.UniversalMediaController;
import hk.gov.ogcio.wcag.widget.videoview.UniversalVideoView;

import static hk.gov.ogcio.wcag.application.Config.SETTINGS_LANGUAGE;

public class VideoFragment extends FragmentManager implements MainActivity.GetVideoFragment, UniversalVideoView.VideoViewCallback {

    private static final String TAG = "MainActivity";
    private HashMap<String, Object> hashMap;
    private FrameLayout frameLayoutVideo;
    private ConstraintLayout constraintLayoutText;
    private UniversalVideoView universalVideoView;

    private int mSeekPosition;
    private int cachedHeight;

    public static VideoFragment newInstance(HashMap<String, Object> hashMap) {
        VideoFragment videoFragment = new VideoFragment();
        activityInterface.getContainer().getVideoFragment = videoFragment;
        videoFragment.hashMap = hashMap;
        return videoFragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        activityInterface.getContainer().linearLayoutMenu.setVisibility(View.VISIBLE);
        activityInterface.getContainer().toolbar.setVisibility(View.VISIBLE);
    }

    @Override
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle savedInstanceState) {
        View view = layoutInflater.inflate(R.layout.fragment_video, viewGroup, false);
        activityInterface.getContainer().setTitle(getString(R.string.title_webforall_video_channel));
        TextView textViewContent = view.findViewById(R.id.textViewContent);
        textViewContent.setText((String) hashMap.get("content"));
        TextView textViewTitle = view.findViewById(R.id.textViewTitle);
        textViewTitle.setText((String) hashMap.get("title"));
        constraintLayoutText = view.findViewById(R.id.constraintLayoutText);
        frameLayoutVideo = view.findViewById(R.id.frameLayoutVideo);
        universalVideoView = view.findViewById(R.id.universalVideoView);
        UniversalMediaController universalMediaController = view.findViewById(R.id.universalMediaController);
        universalVideoView.setMediaController(universalMediaController);
        setVideoAreaSize();
        universalVideoView.setVideoViewCallback(this);
        if (mSeekPosition > 0) {
            universalVideoView.seekTo(mSeekPosition);
        }
        universalMediaController.setTitle((String) hashMap.get("title"));
        return view;
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        activityInterface.getContainer().getVideoFragment = null;
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
    }

    @Override
    public void onScaleChange(boolean isFullscreen) {
        activityInterface.getContainer().isFullscreen = isFullscreen;
        if (isFullscreen) {
            ViewGroup.LayoutParams layoutParams = frameLayoutVideo.getLayoutParams();
            layoutParams.width = ViewGroup.LayoutParams.MATCH_PARENT;
            layoutParams.height = ViewGroup.LayoutParams.MATCH_PARENT;
            frameLayoutVideo.setLayoutParams(layoutParams);
            constraintLayoutText.setVisibility(View.GONE);
            activityInterface.getContainer().linearLayoutMenu.setVisibility(View.GONE);

        } else {
            ViewGroup.LayoutParams layoutParams = frameLayoutVideo.getLayoutParams();
            layoutParams.width = ViewGroup.LayoutParams.MATCH_PARENT;
            layoutParams.height = this.cachedHeight;
            frameLayoutVideo.setLayoutParams(layoutParams);
            constraintLayoutText.setVisibility(View.VISIBLE);
            activityInterface.getContainer().linearLayoutMenu.setVisibility(View.VISIBLE);
        }
        switchTitleBar(!isFullscreen);
    }

    @Override
    public void onPause() {
        super.onPause();
        Log.d(TAG, "onPause ");
        if (universalVideoView != null && universalVideoView.isPlaying()) {
            mSeekPosition = universalVideoView.getCurrentPosition();
            Log.d(TAG, "onPause mSeekPosition=" + mSeekPosition);
            universalVideoView.pause();
        }
    }

    private void switchTitleBar(boolean show) {
        android.support.v7.app.ActionBar supportActionBar = activityInterface.getContainer().getSupportActionBar();
        if (supportActionBar != null) {
            if (show) {
                supportActionBar.show();
            } else {
                supportActionBar.hide();
            }
        }
    }

    private void setVideoAreaSize() {
        frameLayoutVideo.post(new Runnable() {
            @Override
            public void run() {
                int width = frameLayoutVideo.getWidth();
                cachedHeight = (int) (width * 405f / 720f);
                ViewGroup.LayoutParams videoLayoutParams = frameLayoutVideo.getLayoutParams();
                videoLayoutParams.width = ViewGroup.LayoutParams.MATCH_PARENT;
                videoLayoutParams.height = cachedHeight;
                frameLayoutVideo.setLayoutParams(videoLayoutParams);
                universalVideoView.setVideoPath("android.resource://" + activity.getPackageName() + "/" + hashMap.get("video"));
                universalVideoView.requestFocus();

                universalVideoView.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {
                    public void onPrepared(MediaPlayer mp) {
                        universalVideoView.seekTo(1);
                    }
                });
            }
        });
    }

    @Override
    public void onPause(MediaPlayer mediaPlayer) {
        Log.d(TAG, "onPause UniversalVideoView callback");
    }

    @Override
    public void onStart(MediaPlayer mediaPlayer) {
        Log.d(TAG, "onStart UniversalVideoView callback");
    }

    @Override
    public void onBufferingStart(MediaPlayer mediaPlayer) {
        Log.d(TAG, "onBufferingStart UniversalVideoView callback");
    }

    @Override
    public void onBufferingEnd(MediaPlayer mediaPlayer) {
        Log.d(TAG, "onBufferingEnd UniversalVideoView callback");
    }

    @Override
    public void setFullscreen() {
        universalVideoView.setFullscreen(false);
    }
}