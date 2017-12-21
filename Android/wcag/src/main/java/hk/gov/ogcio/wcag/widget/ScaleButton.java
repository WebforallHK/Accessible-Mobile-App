package hk.gov.ogcio.wcag.widget;

import android.app.Activity;
import android.content.Context;
import android.preference.PreferenceManager;
import android.support.v7.widget.AppCompatButton;
import android.util.AttributeSet;
import android.util.DisplayMetrics;

import static hk.gov.ogcio.wcag.application.Config.SETTINGS_FONT_SIZE;

public class ScaleButton extends AppCompatButton {

    public ScaleButton(Context context) {
        super(context);
    }

    public ScaleButton(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        setFontStyle(context);
    }

    public ScaleButton(Context context, AttributeSet attributeSet, int defStyle) {
        super(context, attributeSet, defStyle);
        setFontStyle(context);
    }

    private void setFontStyle(Context context) {
        float AppFontSize;
        AppFontSize = PreferenceManager.getDefaultSharedPreferences(context).getFloat(SETTINGS_FONT_SIZE, ((float) 50 / 100) * 0.4f);
        DisplayMetrics metrics = new DisplayMetrics();
        ((Activity) context).getWindowManager().getDefaultDisplay().getMetrics(metrics);

        float yInches = metrics.heightPixels / metrics.ydpi;
        float xInches = metrics.widthPixels / metrics.xdpi;
        double diagonalInches = Math.sqrt(xInches * xInches + yInches * yInches);
        if (diagonalInches >= 7.5) {
            setTextSize((AppFontSize + 0.8f) * 22.0f);
        } else if (diagonalInches >= 6.5) {
            setTextSize((AppFontSize + 0.8f) * 18.0f);
        } else {
            setTextSize((AppFontSize + 0.8f) * 14.0f);
        }
    }
}