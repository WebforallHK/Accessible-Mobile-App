package hk.gov.ogcio.wcag.widget;

import android.app.Activity;
import android.app.Dialog;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.content.ContextCompat;
import android.view.Gravity;
import android.view.View;
import android.view.Window;
import android.widget.TextSwitcher;
import android.widget.TextView;
import android.widget.ViewSwitcher;

import java.util.Calendar;

import hk.gov.ogcio.wcag.R;

public class CustomDatePicker extends Dialog implements View.OnClickListener, ViewSwitcher.ViewFactory {

    private Activity activity;
    private boolean limit;
    private Calendar calendar;
    private int pickedDay;
    private int pickedMonth;
    private int pickedYear;
    private int thisDay;
    private int thisMonth;
    private int thisYear;
    private MyDatePickerCallback myDatePickerCallback;
    private String[] MONTH;
    private String[] WEEK_DAY;
    private TextSwitcher textSwitcherYear;
    private TextSwitcher textSwitcherMonth;
    private TextSwitcher textSwitcherDay;
    private TextView textView;
    private TextView textViewDate;

    public CustomDatePicker(Activity activity, Fragment fragment, TextView textView, boolean limit) {
        super(activity);
        this.activity = activity;
        this.textView = textView;
        this.limit = limit;
        myDatePickerCallback = (MyDatePickerCallback) fragment;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.datepicker);
        MONTH = activity.getResources().getStringArray(R.array.month);
        WEEK_DAY = activity.getResources().getStringArray(R.array.week_day);
        calendar = Calendar.getInstance();
        thisDay = calendar.get(Calendar.DAY_OF_MONTH);
        thisMonth = calendar.get(Calendar.MONTH);
        thisYear = calendar.get(Calendar.YEAR);
        if (limit) {
            calendar.add(Calendar.DAY_OF_YEAR, 7);
        }
        pickedDay = calendar.get(Calendar.DAY_OF_MONTH);
        pickedMonth = calendar.get(Calendar.MONTH);
        pickedYear = calendar.get(Calendar.YEAR);

        findViewById(R.id.buttonCancel).setOnClickListener(this);
        findViewById(R.id.buttonConfirm).setOnClickListener(this);

        findViewById(R.id.imageButtonYearUp).setOnClickListener(this);
        findViewById(R.id.imageButtonYearDown).setOnClickListener(this);
        findViewById(R.id.imageButtonMonthUp).setOnClickListener(this);
        findViewById(R.id.imageButtonMonthDown).setOnClickListener(this);
        findViewById(R.id.imageButtonDayUp).setOnClickListener(this);
        findViewById(R.id.imageButtonDayDown).setOnClickListener(this);

        textSwitcherYear = findViewById(R.id.textSwitcherYear);
        textSwitcherYear.setFactory(this);
        textSwitcherYear.setText(String.valueOf(pickedYear));

        textSwitcherMonth = findViewById(R.id.textSwitcherMonth);
        textSwitcherMonth.setFactory(this);
        textSwitcherMonth.setText(MONTH[pickedMonth]);

        textSwitcherDay = findViewById(R.id.textSwitcherDay);
        textSwitcherDay.setFactory(this);
        textSwitcherDay.setText(String.valueOf(pickedDay));

        textViewDate = findViewById(R.id.textView);
        textViewDate.setText(String.format(activity.getString(R.string.text_date),
                pickedYear,
                MONTH[calendar.get(Calendar.MONTH)],
                calendar.get(Calendar.DAY_OF_MONTH),
                WEEK_DAY[calendar.get(Calendar.DAY_OF_WEEK)]));
    }

    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.imageButtonYearUp:
                ++pickedYear;
                textSwitcherYear.setText(String.valueOf(pickedYear));
                calendar.set(Calendar.DAY_OF_MONTH, 1);
                calendar.set(Calendar.YEAR, pickedYear);
                if (pickedDay > calendar.getActualMaximum(Calendar.DAY_OF_MONTH)) {
                    pickedDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
                    textSwitcherDay.setText(String.valueOf(pickedDay));
                }
                setTextViewDate();
                break;
            case R.id.imageButtonYearDown:
                if (pickedYear > thisYear) {
                    decreaseYear();
                }
                break;
            case R.id.imageButtonMonthUp:
                ++pickedMonth;
                if (pickedMonth > 11)
                    pickedMonth = 0;
                textSwitcherMonth.setText(MONTH[pickedMonth]);
                calendar.set(Calendar.DAY_OF_MONTH, 1);
                calendar.set(Calendar.MONTH, pickedMonth);
                if (pickedDay > calendar.getActualMaximum(Calendar.DAY_OF_MONTH)) {
                    pickedDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
                    textSwitcherDay.setText(String.valueOf(pickedDay));
                }
                setTextViewDate();
                break;
            case R.id.imageButtonMonthDown:
                if (pickedYear == thisYear) {
                    if (pickedMonth > thisMonth) {
                        decreaseMonth();
                    }
                } else {
                    decreaseMonth();
                }
                break;
            case R.id.imageButtonDayUp:
                ++pickedDay;
                if (pickedDay > calendar.getActualMaximum(Calendar.DAY_OF_MONTH))
                    pickedDay = 1;
                textSwitcherDay.setText(String.valueOf(pickedDay));
                setTextViewDate();
                break;
            case R.id.imageButtonDayDown:
                if (pickedYear == thisYear) {
                    if (pickedMonth > thisMonth) {
                        decreaseDay();
                    } else if (pickedDay > thisDay) {
                        decreaseDay();
                    }
                } else {
                    decreaseDay();
                }
                break;
            case R.id.buttonCancel:
                dismiss();
                break;
            case R.id.buttonConfirm:
                String pickedDate = String.valueOf(pickedDay) + "/" +
                        String.valueOf(pickedMonth + 1) + "/" +
                        String.valueOf(pickedYear);
                myDatePickerCallback.getPickedDate(pickedDate, textView);
                dismiss();
                break;
        }
    }

    private void setTextViewDate() {
        calendar.set(Calendar.DAY_OF_MONTH, pickedDay);
        textViewDate.setText(String.format(activity.getString(R.string.text_date),
                pickedYear,
                MONTH[calendar.get(Calendar.MONTH)],
                calendar.get(Calendar.DAY_OF_MONTH),
                WEEK_DAY[calendar.get(Calendar.DAY_OF_WEEK)]));
    }

    private void decreaseYear() {
        --pickedYear;
        textSwitcherYear.setText(String.valueOf(pickedYear));
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        calendar.set(Calendar.YEAR, pickedYear);
        if (pickedDay > calendar.getActualMaximum(Calendar.DAY_OF_MONTH)) {
            pickedDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
            textSwitcherDay.setText(String.valueOf(pickedDay));
        }
        setTextViewDate();
        if (pickedYear == thisYear && pickedMonth < thisMonth) {
            pickedMonth = thisMonth;
            textSwitcherMonth.setText(MONTH[pickedMonth]);
            calendar.set(Calendar.DAY_OF_MONTH, 1);
            calendar.set(Calendar.MONTH, pickedMonth);
            if (pickedDay > calendar.getActualMaximum(Calendar.DAY_OF_MONTH)) {
                pickedDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
                textSwitcherDay.setText(String.valueOf(pickedDay));
            }
            setTextViewDate();
        }
        if (pickedMonth == thisMonth && pickedDay < thisDay) {
            pickedDay = thisDay;
            if (pickedDay <= 0)
                pickedDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
            textSwitcherDay.setText(String.valueOf(pickedDay));
            setTextViewDate();
        }
    }

    private void decreaseMonth() {
        --pickedMonth;
        if (pickedMonth < 0)
            pickedMonth = 11;
        textSwitcherMonth.setText(MONTH[pickedMonth]);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        calendar.set(Calendar.MONTH, pickedMonth);
        if (pickedDay > calendar.getActualMaximum(Calendar.DAY_OF_MONTH)) {
            pickedDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
            textSwitcherDay.setText(String.valueOf(pickedDay));
        }
        calendar.set(Calendar.DAY_OF_MONTH, pickedDay);
        setTextViewDate();
        if (pickedMonth == thisMonth && pickedDay < thisDay) {
            pickedDay = thisDay;
            if (pickedDay <= 0)
                pickedDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
            textSwitcherDay.setText(String.valueOf(pickedDay));
            setTextViewDate();
        }
    }

    private void decreaseDay() {
        --pickedDay;
        if (pickedDay <= 0)
            pickedDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
        textSwitcherDay.setText(String.valueOf(pickedDay));
        setTextViewDate();
    }

    @Override
    public View makeView() {
        TextView textView = new TextView(activity);
        textView.setGravity(Gravity.TOP | Gravity.CENTER_HORIZONTAL);
        textView.setTextSize(24);
        textView.setTextColor(ContextCompat.getColor(activity, android.R.color.black));
        textView.setMaxLines(1);
        return textView;
    }

    public interface MyDatePickerCallback {
        void getPickedDate(String pickedDate, TextView textView);
    }
}