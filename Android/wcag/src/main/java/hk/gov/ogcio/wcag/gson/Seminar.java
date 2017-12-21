package hk.gov.ogcio.wcag.gson;

import android.content.Context;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import android.text.TextUtils;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import static hk.gov.ogcio.wcag.application.Config.SETTINGS_LANGUAGE;

public class Seminar {

    private SharedPreferences sharedPreferences;
    private String language;

    @SerializedName("date")
    @Expose
    private String date;
    @SerializedName("outdated")
    @Expose
    private boolean outdated;
    @SerializedName("time")
    @Expose
    private String time;
    @SerializedName("topic_tc")
    @Expose
    private String topicTc;
    @SerializedName("topic_sc")
    @Expose
    private String topicSc;
    @SerializedName("topic_en")
    @Expose
    private String topicEn;
    @SerializedName("venue_tc")
    @Expose
    private String venueTc;
    @SerializedName("venue_sc")
    @Expose
    private String venueSc;
    @SerializedName("venue_en")
    @Expose
    private String venueEn;
    @SerializedName("coordinate")
    @Expose
    private String coordinate;
    @SerializedName("details_tc")
    @Expose
    private String detailsTc;
    @SerializedName("details_sc")
    @Expose
    private String detailsSc;
    @SerializedName("details_en")
    @Expose
    private String detailsEn;

    public String getDate(Context context) {
        try {
            Date d = new SimpleDateFormat("MM/dd/yyyy", Locale.getDefault()).parse(date);
            if (sharedPreferences == null) {
                sharedPreferences = PreferenceManager.getDefaultSharedPreferences(context);
                language = sharedPreferences.getString(SETTINGS_LANGUAGE, "en");
            }
            if (TextUtils.equals(language, "zh_CN")) {
                return new SimpleDateFormat("yyyy年MMMdd日", Locale.SIMPLIFIED_CHINESE).format(d);
            } else if (TextUtils.equals(language, "zh_TW")) {
                return new SimpleDateFormat("yyyy年MMMdd日", Locale.TRADITIONAL_CHINESE).format(d);
            } else {
                return new SimpleDateFormat("dd MMM yyyy", Locale.ENGLISH).format(d);
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public boolean getOutdated() {
        return outdated;
    }

    public void setOutdated(boolean outdated) {
        this.outdated = outdated;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getTopic(Context context) {
        if (sharedPreferences == null) {
            sharedPreferences = PreferenceManager.getDefaultSharedPreferences(context);
            language = sharedPreferences.getString(SETTINGS_LANGUAGE, "en");
        }
        if (TextUtils.equals(language, "zh_CN")) {
            return topicSc;
        }
        if (TextUtils.equals(language, "zh_TW")) {
            return topicTc;
        }
        return topicEn;
    }

    public void setTopicTc(String topicTc) {
        this.topicTc = topicTc;
    }

    public void setTopicEn(String topicEn) {
        this.topicEn = topicEn;
    }

    public String getVenue(Context context) {
        if (sharedPreferences == null) {
            sharedPreferences = PreferenceManager.getDefaultSharedPreferences(context);
            language = sharedPreferences.getString(SETTINGS_LANGUAGE, "en");
        }
        if (TextUtils.equals(language, "zh_CN")) {
            return venueSc;
        }
        if (TextUtils.equals(language, "zh_TW")) {
            return venueTc;
        }
        return venueEn;
    }

    public void setVenueTc(String venueTc) {
        this.venueTc = venueTc;
    }

    public void setVenueEn(String venueEn) {
        this.venueEn = venueEn;
    }

    public String getCoordinate() {
        return coordinate;
    }

    public void setCoordinate(String coordinate) {
        this.coordinate = coordinate;
    }

    public String getDetails(Context context) {
        if (sharedPreferences == null) {
            sharedPreferences = PreferenceManager.getDefaultSharedPreferences(context);
            language = sharedPreferences.getString(SETTINGS_LANGUAGE, "en");
        }
        if (TextUtils.equals(language, "zh_CN")) {
            return detailsSc;
        }
        if (TextUtils.equals(language, "zh_TW")) {
            return detailsTc;
        }
        return detailsEn;
    }

    public void setDetailsTc(String detailsTc) {
        this.detailsTc = detailsTc;
    }

    public void setDetailsEn(String detailsEn) {
        this.detailsEn = detailsEn;
    }

}