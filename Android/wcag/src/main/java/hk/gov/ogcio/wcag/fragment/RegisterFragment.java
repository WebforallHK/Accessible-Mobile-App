package hk.gov.ogcio.wcag.fragment;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;
import android.os.CountDownTimer;
import android.support.v4.content.ContextCompat;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.TextView;

import java.util.HashMap;
import java.util.concurrent.TimeUnit;

import hk.gov.ogcio.wcag.R;
import hk.gov.ogcio.wcag.gson.Seminar;
import hk.gov.ogcio.wcag.manager.FragmentManager;

public class RegisterFragment extends FragmentManager implements View.OnClickListener {

    private CountDownTimer countDownTimer;
    private EditText editTextAddress;
    private TextView selectDistrict;
    private EditText editTextFirstName;
    private EditText editTextLastName;
    private EditText editTextPhone;
    private HashMap<String, String> hashMap;
    private Seminar seminar;
    private TextView textViewFirstName;
    private TextView textViewLastName;
    private TextView textViewPhone;
    private TextView textViewDistrict;
    private TextView textViewTimer;

    public static RegisterFragment newInstance(HashMap<String, String> hashMap, Seminar seminar) {
        RegisterFragment registerFragment = new RegisterFragment();
        registerFragment.hashMap = hashMap;
        registerFragment.seminar = seminar;
        return registerFragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        activityInterface.getContainer().linearLayoutMenu.setVisibility(View.VISIBLE);
        activityInterface.getContainer().toolbar.setVisibility(View.VISIBLE);
    }

    @Override
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle savedInstanceState) {
        View view = layoutInflater.inflate(R.layout.fragment_register, viewGroup, false);
        activityInterface.getContainer().setTitle(getString(R.string.title_register));
        setViewSlide(view);
        view.findViewById(R.id.buttonRegister).setOnClickListener(this);
        editTextAddress = view.findViewById(R.id.editTextAddress);
        selectDistrict = view.findViewById(R.id.selectDistrict);
        selectDistrict.setOnClickListener(this);
        selectDistrict.setOnFocusChangeListener(new View.OnFocusChangeListener() {
            @Override
            public void onFocusChange(View v, boolean hasFocus) {
                if (v != null && hasFocus) {
                    InputMethodManager inputMethodManager = (InputMethodManager) activity.getSystemService(Context.INPUT_METHOD_SERVICE);
                    inputMethodManager.hideSoftInputFromWindow(v.getWindowToken(), 0);
                }
            }
        });
        editTextFirstName = view.findViewById(R.id.editTextFirstName);
        editTextLastName = view.findViewById(R.id.editTextLastName);
        editTextPhone = view.findViewById(R.id.editTextPhone);
        textViewFirstName = view.findViewById(R.id.textViewFirstName);
        textViewLastName = view.findViewById(R.id.textViewLastName);
        textViewDistrict = view.findViewById(R.id.textViewDistrict);
        textViewPhone = view.findViewById(R.id.textViewPhone);
//        final String[] districts = getResources().getStringArray(R.array.district);
//        ArrayAdapter<CharSequence> arrayAdapter = ArrayAdapter.createFromResource(activity, R.array.district, android.R.layout.simple_spinner_dropdown_item);
//        spinnerDistrict.setAdapter(arrayAdapter);
//        spinnerDistrict.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
//            @Override
//            public void onItemSelected(AdapterView<?> adapterView, View view, int i, long l) {
//                hashMap.put("district", districts[i]);
//            }
//
//            @Override
//            public void onNothingSelected(AdapterView<?> adapterView) {
//
//            }
//        });
        textViewTimer = view.findViewById(R.id.textViewTimer);
        setTimer();
        return view;
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        countDownTimer.cancel();
    }

    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.buttonRegister:
                hashMap.put("first_name", editTextFirstName.getText().toString());
                hashMap.put("last_name", editTextLastName.getText().toString());
                hashMap.put("address", editTextAddress.getText().toString());
                hashMap.put("phone", editTextPhone.getText().toString());
                checkValid();
                view = activity.getCurrentFocus();
                if (view != null) {
                    InputMethodManager inputMethodManager = (InputMethodManager) activity.getSystemService(Context.INPUT_METHOD_SERVICE);
                    inputMethodManager.hideSoftInputFromWindow(view.getWindowToken(), 0);
                }
                break;
            case R.id.selectDistrict:
                InputMethodManager imm = (InputMethodManager) getActivity().getSystemService(Context.INPUT_METHOD_SERVICE);
                imm.hideSoftInputFromWindow(view.getWindowToken(), 0);
                final String[] districts = getResources().getStringArray(R.array.district);
                new AlertDialog.Builder(getActivity())
                        .setTitle(R.string.choose_a_district)
                        .setItems(districts, new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int which) {
                                selectDistrict.setText(districts[which]);
                                hashMap.put("district", districts[which]);
                            }
                        })
                        .show();
                break;
        }
    }

    private void setTimer() {
        countDownTimer = new CountDownTimer(300000, 1000) {
            @Override
            public void onTick(long millisUntilFinished) {
                textViewTimer.setText(String.format(getString(R.string.text_timer),
                        TimeUnit.MILLISECONDS.toMinutes(millisUntilFinished),
                        TimeUnit.MILLISECONDS.toSeconds(millisUntilFinished) -
                                TimeUnit.MINUTES.toSeconds(TimeUnit.MILLISECONDS.toMinutes(millisUntilFinished))));
            }

            @Override
            public void onFinish() {
                textViewTimer.setText(String.format(getString(R.string.text_timer), 0, 0));
                new AlertDialog.Builder(activity, R.style.alertDialogStyle)
                        .setMessage(R.string.reason_time)
                        .setCancelable(false)
                        .setNeutralButton(R.string.button_extend_time_limit, new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialogInterface, int i) {
                                setTimer();
                            }
                        })
                        .setNegativeButton(R.string.button_reset, new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialogInterface, int i) {
                                activityInterface.getContainer().removeLastFragment();
                                activityInterface.getContainer().setFragmentChild(RegisterFragment.newInstance(hashMap, seminar));
                            }
                        })
                        .show();
            }
        }.start();
    }

    private void checkValid() {
        View current = getView().findFocus();
        if (current != null) current.clearFocus();
        boolean valid = true;
        textViewDistrict.setTextColor(ContextCompat.getColor(activity, android.R.color.black));
        textViewFirstName.setTextColor(ContextCompat.getColor(activity, android.R.color.black));
        textViewLastName.setTextColor(ContextCompat.getColor(activity, android.R.color.black));
        textViewPhone.setTextColor(ContextCompat.getColor(activity, android.R.color.black));
        StringBuilder reason = new StringBuilder();
        if (TextUtils.isEmpty(hashMap.get("first_name"))) {
            reason.append(getString(R.string.reason_first_name));
            editTextFirstName.requestFocus();
            textViewFirstName.setTextColor(ContextCompat.getColor(activity, R.color.colorTextRed));
            valid = false;
        }
        if (TextUtils.isEmpty(hashMap.get("last_name"))) {
            reason.append(getString(R.string.reason_last_name));
            if (valid)
                editTextLastName.requestFocus();
            textViewLastName.setTextColor(ContextCompat.getColor(activity, R.color.colorTextRed));
            valid = false;
        }
        if (hashMap.get("district") == null) {
            reason.append(getString(R.string.reason_district));
            if (valid)
                selectDistrict.requestFocus();
            textViewDistrict.setTextColor(ContextCompat.getColor(activity, R.color.colorTextRed));
            valid = false;
        }
        if (TextUtils.isEmpty(hashMap.get("phone")) || hashMap.get("phone").length() != 8) {
            reason.append(getString(R.string.reason_phone));
            if (valid)
                editTextPhone.requestFocus();
            textViewPhone.setTextColor(ContextCompat.getColor(activity, R.color.colorTextRed));
            valid = false;
        }
        if (valid) {
            activityInterface.getContainer().setFragmentChild(ConfirmFragment.newInstance(hashMap, seminar));
        } else {
            new AlertDialog.Builder(activity, R.style.alertDialogStyle)
                    .setMessage(reason)
                    .setCancelable(false)
                    .setNegativeButton(R.string.button_close, null)
                    .show();
        }
    }
}