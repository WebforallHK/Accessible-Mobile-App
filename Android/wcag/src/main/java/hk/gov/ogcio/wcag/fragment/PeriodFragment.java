package hk.gov.ogcio.wcag.fragment;

import android.app.AlertDialog;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import hk.gov.ogcio.wcag.R;
import hk.gov.ogcio.wcag.manager.FragmentManager;
import hk.gov.ogcio.wcag.widget.CustomDatePicker;

import static hk.gov.ogcio.wcag.application.Config.SETTINGS_LANGUAGE;

public class PeriodFragment extends FragmentManager implements View.OnClickListener, CustomDatePicker.MyDatePickerCallback {

    private SimpleDateFormat simpleDateFormat;
    private TextView textViewEnd;
    private TextView textViewStart;

    public static PeriodFragment newInstance() {
        return new PeriodFragment();
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        activityInterface.getContainer().linearLayoutMenu.setVisibility(View.VISIBLE);
        activityInterface.getContainer().toolbar.setVisibility(View.VISIBLE);
    }

    @Override
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle savedInstanceState) {
        View view = layoutInflater.inflate(R.layout.fragment_period, viewGroup, false);
        activityInterface.getContainer().setTitle(getString(R.string.title_register));
        setViewSlide(view);
        setViewSlide(view.findViewById(R.id.linearLayout));
        setViewSlide(view.findViewById(R.id.textView1));
        setViewSlide(view.findViewById(R.id.textView2));
        setViewSlide(view.findViewById(R.id.textView3));
        view.findViewById(R.id.buttonNext).setOnClickListener(this);

        simpleDateFormat = new SimpleDateFormat("dd MMM yyyy", Locale.ENGLISH);
        if (TextUtils.equals(sharedPreferences.getString(SETTINGS_LANGUAGE, String.valueOf(Locale.ENGLISH)), String.valueOf(Locale.TRADITIONAL_CHINESE)) ||
                TextUtils.equals(sharedPreferences.getString(SETTINGS_LANGUAGE, String.valueOf(Locale.ENGLISH)), String.valueOf(Locale.SIMPLIFIED_CHINESE))) {
            simpleDateFormat = new SimpleDateFormat("yyyy年M月d日", Locale.CHINESE);
        }

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date());
        calendar.add(Calendar.DAY_OF_YEAR, 1);
        textViewStart = view.findViewById(R.id.textViewStart);
        textViewStart.setOnClickListener(this);
        textViewStart.setText(simpleDateFormat.format(calendar.getTime()));
        textViewStart.setContentDescription(getString(R.string.edit) + textViewStart.getText().toString());
        calendar.add(Calendar.DAY_OF_YEAR, 7);
        textViewEnd = view.findViewById(R.id.textViewEnd);
        textViewEnd.setOnClickListener(this);
        textViewEnd.setText(simpleDateFormat.format(calendar.getTime()));
        textViewEnd.setContentDescription(getString(R.string.edit) + textViewEnd.getText().toString());
        return view;
    }

    private void showDatePicker(TextView textView) {
        CustomDatePicker calendar = new CustomDatePicker(activity, this, textView, textView == textViewEnd);
        calendar.show();
    }

    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.buttonNext:
                if (textViewEnd.getText().toString().equals(textViewStart.getText().toString()) ||
                        stringToDate(textViewEnd.getText().toString()).after(stringToDate(textViewStart.getText().toString()))) {
                    HashMap<String, String> hashMap = new HashMap<>();
                    hashMap.put("start", textViewStart.getText().toString());
                    hashMap.put("end", textViewEnd.getText().toString());
                    activityInterface.getContainer().setFragmentChild(RegisterFragment.newInstance(hashMap, null));
                } else {
                    new AlertDialog.Builder(activity, R.style.alertDialogStyle)
                            .setMessage(R.string.reason_date)
                            .setCancelable(false)
                            .setNegativeButton(R.string.button_close, null)
                            .show();
                }
                break;
            case R.id.textViewEnd:
                showDatePicker(textViewEnd);
                break;
            case R.id.textViewStart:
                showDatePicker(textViewStart);
                break;
        }
    }

    private Date stringToDate(String stringDate) {
        try {
            return simpleDateFormat.parse(stringDate);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public void getPickedDate(String pickedDate, TextView textView) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy", Locale.getDefault());
        Date date = new Date();
        try {
            date = dateFormat.parse(pickedDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        textView.setText(simpleDateFormat.format(date));
    }
}