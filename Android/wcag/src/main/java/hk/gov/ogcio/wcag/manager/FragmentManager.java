package hk.gov.ogcio.wcag.manager;

import android.app.Activity;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.support.v4.app.Fragment;
import android.view.GestureDetector;
import android.view.MotionEvent;
import android.view.View;

import hk.gov.ogcio.wcag.application.ActivityInterface;

public class FragmentManager extends Fragment {

    public static ActivityInterface activityInterface;
    public Activity activity;
    public SharedPreferences sharedPreferences;
    public GestureDetector gestureDetector = new GestureDetector(activity, new GestureDetector.SimpleOnGestureListener() {

        @Override
        public boolean onFling(MotionEvent e1, MotionEvent e2, float velocityX, float velocityY) {
            final int SWIPE_MIN_DISTANCE = 120;
            final int SWIPE_THRESHOLD_VELOCITY = 200;
            if (e1.getX() - e2.getX() > SWIPE_MIN_DISTANCE && Math.abs(velocityX) > SWIPE_THRESHOLD_VELOCITY) {
                activityInterface.getContainer().backToPreviousFragment();
            }
            return super.onFling(e1, e2, velocityX, velocityY);
        }
    });

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        activity = getActivity();
        activityInterface = (ActivityInterface) activity;
        sharedPreferences = PreferenceManager.getDefaultSharedPreferences(activity);
    }

    public void setViewSlide(View view) {
        view.setLongClickable(true);
        view.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View view, MotionEvent motionEvent) {
                return gestureDetector.onTouchEvent(motionEvent);
            }
        });
    }
}