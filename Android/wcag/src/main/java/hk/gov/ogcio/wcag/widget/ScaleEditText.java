package hk.gov.ogcio.wcag.widget;

import android.content.Context;
import android.preference.PreferenceManager;
import android.support.v7.widget.AppCompatEditText;
import android.util.AttributeSet;

import static hk.gov.ogcio.wcag.application.Config.SETTINGS_FONT_SIZE;

public class ScaleEditText extends AppCompatEditText {

    public ScaleEditText(Context context) {
        super(context);
    }

    public ScaleEditText(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        setFontStyle(context);
    }

    public ScaleEditText(Context context, AttributeSet attributeSet, int defStyle) {
        super(context, attributeSet, defStyle);
        setFontStyle(context);
    }

    private void setFontStyle(Context context) {
        float AppFontSize;
        AppFontSize = PreferenceManager.getDefaultSharedPreferences(context).getFloat(SETTINGS_FONT_SIZE, ((float) 50 / 100) * 0.4f);
        setTextSize((AppFontSize + 0.8f) * 18.0f);
    }
}