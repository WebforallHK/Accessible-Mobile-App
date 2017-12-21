package hk.gov.ogcio.wcag.application;

import android.content.Context;
import android.content.res.Configuration;
import android.text.TextUtils;

import java.util.Locale;

import static hk.gov.ogcio.wcag.application.Config.DEFAULT_LANGUAGE;
import static hk.gov.ogcio.wcag.application.Config.SETTINGS_LANGUAGE;
import static hk.gov.ogcio.wcag.manager.ApplicationManager.sharedPreferences;

public class Language {

    public static Locale getLanguage() {
        String language = sharedPreferences.getString(SETTINGS_LANGUAGE, String.valueOf(DEFAULT_LANGUAGE));
        if (TextUtils.equals(language, String.valueOf(Locale.ENGLISH))) {
            return Locale.ENGLISH;
        }
        if (TextUtils.equals(language, String.valueOf(Locale.TRADITIONAL_CHINESE))) {
            return Locale.TRADITIONAL_CHINESE;
        }
        if (TextUtils.equals(language, String.valueOf(Locale.SIMPLIFIED_CHINESE))) {
            return Locale.SIMPLIFIED_CHINESE;
        }
        return DEFAULT_LANGUAGE;
    }

    public static void setLanguage(Context context, Locale locale) {
        sharedPreferences.edit().putString(SETTINGS_LANGUAGE, String.valueOf(locale)).apply();
        Configuration configuration = context.getResources().getConfiguration();
        configuration.setLocale(locale);
        Context newContext = context.createConfigurationContext(configuration);
//        super.attachBaseContext(newContext);
    }
}