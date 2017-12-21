package hk.gov.ogcio.wcag.adapter;

import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;

import hk.gov.ogcio.wcag.fragment.IntroFragment;
import hk.gov.ogcio.wcag.fragment.TutorialFragment;

public class ViewPagerAdapter extends FragmentPagerAdapter {

    public ViewPagerAdapter(FragmentManager fragmentManager) {
        super(fragmentManager);
    }

    @Override
    public int getCount() {
        return 2;
    }

    @Override
    public Fragment getItem(int position) {
        switch (position) {
            case 0:
                return IntroFragment.newInstance();
            case 1:
                return TutorialFragment.newInstance();
            default:
                return null;
        }
    }
}