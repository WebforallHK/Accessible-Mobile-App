package hk.gov.ogcio.wcag.fragment;

import android.os.Bundle;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.accessibility.AccessibilityManager;
import android.widget.CheckBox;
import android.widget.ImageButton;

import hk.gov.ogcio.wcag.R;
import hk.gov.ogcio.wcag.adapter.ViewPagerAdapter;
import hk.gov.ogcio.wcag.manager.FragmentManager;

import static android.content.Context.ACCESSIBILITY_SERVICE;

public class WelcomeFragment extends FragmentManager implements View.OnClickListener {

    private boolean isTalkBackEnabled;
    private CheckBox checkBox;
    private ImageButton imageButton1;
    private ImageButton imageButton2;
    private ImageButton imageButtonLeft;
    private ImageButton imageButtonRight;
    private ViewPager viewPager;

    public static WelcomeFragment newInstance() {
        return new WelcomeFragment();
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        activityInterface.getContainer().linearLayoutMenu.setVisibility(View.GONE);
        activityInterface.getContainer().toolbar.setVisibility(View.VISIBLE);
        activityInterface.getContainer().imageButtonMenu.setVisibility(View.INVISIBLE);
    }

    @Override
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle savedInstanceState) {
        View view = layoutInflater.inflate(R.layout.fragment_welcome, viewGroup, false);
        activityInterface.getContainer().setTitle(getString(R.string.title_welcome));
        AccessibilityManager accessibilityManager = (AccessibilityManager) activity.getSystemService(ACCESSIBILITY_SERVICE);
        isTalkBackEnabled = accessibilityManager.isEnabled() && accessibilityManager.isTouchExplorationEnabled();
        view.findViewById(R.id.buttonStart).setOnClickListener(this);
        checkBox = view.findViewById(R.id.checkBox);
        imageButtonLeft = view.findViewById(R.id.imageButtonLeft);
        imageButtonLeft.setOnClickListener(this);
        imageButtonRight = view.findViewById(R.id.imageButtonRight);
        imageButtonRight.setOnClickListener(this);
        imageButton1 = view.findViewById(R.id.imageButton1);
        imageButton1.setOnClickListener(this);
        imageButton2 = view.findViewById(R.id.imageButton2);
        imageButton2.setOnClickListener(this);
        view.findViewById(R.id.imageButton2).setOnClickListener(this);
        viewPager = view.findViewById(R.id.viewPager);
        viewPager.setAdapter(new ViewPagerAdapter(getChildFragmentManager()));
        viewPager.addOnPageChangeListener(new ViewPager.OnPageChangeListener() {
            @Override
            public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {

            }

            @Override
            public void onPageSelected(int position) {
                if (position == 0) {
                    if (isTalkBackEnabled) {
                        imageButtonLeft.setVisibility(View.INVISIBLE);
                        imageButtonRight.setVisibility(View.VISIBLE);
                    }
                    imageButton1.setImageResource(R.drawable.tablayout_selected);
                    imageButton2.setImageResource(R.drawable.tablayout_default);
                } else {
                    if (isTalkBackEnabled) {
                        imageButtonLeft.setVisibility(View.VISIBLE);
                        imageButtonRight.setVisibility(View.INVISIBLE);
                    }
                    imageButton1.setImageResource(R.drawable.tablayout_default);
                    imageButton2.setImageResource(R.drawable.tablayout_selected);

                }
            }

            @Override
            public void onPageScrollStateChanged(int state) {

            }
        });
        if (isTalkBackEnabled) {
            imageButtonLeft.setOnClickListener(this);
            imageButtonRight.setOnClickListener(this);
        } else {
            imageButtonLeft.setVisibility(View.GONE);
            imageButtonRight.setVisibility(View.GONE);
        }
        return view;
    }

    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.buttonStart:
                if (checkBox.isChecked()) {
                    sharedPreferences.edit().putBoolean("skip_welcome_screen", true).apply();
                } else {
                    sharedPreferences.edit().putBoolean("skip_welcome_screen", false).apply();
                }
                activityInterface.getContainer().setFragmentParent(IntroductionFragment.newInstance());
                break;
            case R.id.imageButtonLeft:
                viewPager.setCurrentItem(0, true);
                break;
            case R.id.imageButtonRight:
                viewPager.setCurrentItem(1, false);
                break;
            case R.id.imageButton1:
                viewPager.setCurrentItem(0, true);
                break;
            case R.id.imageButton2:
                viewPager.setCurrentItem(1, false);
                break;
        }

    }
}
