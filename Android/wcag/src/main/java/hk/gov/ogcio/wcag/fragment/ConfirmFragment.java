package hk.gov.ogcio.wcag.fragment;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import java.util.HashMap;

import hk.gov.ogcio.wcag.R;
import hk.gov.ogcio.wcag.gson.Seminar;
import hk.gov.ogcio.wcag.manager.FragmentManager;

public class ConfirmFragment extends FragmentManager implements View.OnClickListener {

    private HashMap<String, String> hashMap;
    private Seminar seminar;

    public static ConfirmFragment newInstance(HashMap<String, String> hashMap, Seminar seminar) {
        ConfirmFragment confirmFragment = new ConfirmFragment();
        confirmFragment.hashMap = hashMap;
        confirmFragment.seminar = seminar;
        return confirmFragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        activityInterface.getContainer().linearLayoutMenu.setVisibility(View.VISIBLE);
        activityInterface.getContainer().toolbar.setVisibility(View.VISIBLE);
    }

    @Override
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle savedInstanceState) {
        View view = layoutInflater.inflate(R.layout.fragment_confirm, viewGroup, false);
        activityInterface.getContainer().setTitle(getString(R.string.title_confirmation));
        view.findViewById(R.id.buttonChange).setOnClickListener(this);
        view.findViewById(R.id.buttonConfirm).setOnClickListener(this);
        TextView textViewFirstName = view.findViewById(R.id.textViewFirstName);
        textViewFirstName.setText(hashMap.get("first_name"));
        TextView textViewLastName = view.findViewById(R.id.textViewLastName);
        textViewLastName.setText(hashMap.get("last_name"));
        TextView textViewAddress = view.findViewById(R.id.textViewAddress);
        textViewAddress.setText(hashMap.get("address"));
        TextView textViewDistrict = view.findViewById(R.id.textViewDistrict);
        textViewDistrict.setText(hashMap.get("district"));
        TextView textViewPhone = view.findViewById(R.id.textViewPhone);
        textViewPhone.setText(hashMap.get("phone"));
        return view;
    }

    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.buttonConfirm:
                activityInterface.getContainer().setFragmentChild(AcknowledgementFragment.newInstance(hashMap, seminar));
                break;
            case R.id.buttonChange:
                activityInterface.getContainer().backToPreviousFragment();
                break;
        }
    }
}