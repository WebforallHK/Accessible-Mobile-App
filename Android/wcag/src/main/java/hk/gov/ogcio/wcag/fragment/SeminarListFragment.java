package hk.gov.ogcio.wcag.fragment;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.os.Handler;
import android.support.v7.widget.DividerItemDecoration;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.text.TextUtils;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.google.gson.Gson;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import hk.gov.ogcio.wcag.R;
import hk.gov.ogcio.wcag.adapter.SeminarListAdapter;
import hk.gov.ogcio.wcag.gson.Seminar;
import hk.gov.ogcio.wcag.manager.FragmentManager;

import static hk.gov.ogcio.wcag.application.Config.SETTINGS_AUTO_UPDATE;
import static hk.gov.ogcio.wcag.application.Config.language;

public class SeminarListFragment extends FragmentManager implements View.OnClickListener, SeminarListAdapter.OnItemClickListener {

    private Handler handler = new Handler();
    private ImageView imageView;
    private int[] imagesEn = {R.drawable.banner_1_en, R.drawable.banner_2_en, R.drawable.banner_3_en};
    private int[] imagesSc = {R.drawable.banner_1_sc, R.drawable.banner_2_sc, R.drawable.banner_3_sc};
    private int[] imagesTc = {R.drawable.banner_1_tc, R.drawable.banner_2_tc, R.drawable.banner_3_tc};
    private int order = 0;
    private TextView textViewUpdate;
    private Runnable runnable = new Runnable() {
        @Override
        public void run() {
            order++;
            if (TextUtils.equals(language, String.valueOf(Locale.TRADITIONAL_CHINESE))) {
                imageView.setImageResource(imagesTc[order % 3]);
            }
            if (TextUtils.equals(language, String.valueOf(Locale.SIMPLIFIED_CHINESE))) {
                imageView.setImageResource(imagesSc[order % 3]);
            }
            if (TextUtils.equals(language, String.valueOf(Locale.ENGLISH))) {
                imageView.setImageResource(imagesEn[order % 3]);
            }
            handler.postDelayed(runnable, 1000);
            if (order == Integer.MAX_VALUE) {
                order = 0;
            }
        }
    };

    public static SeminarListFragment newInstance() {
        return new SeminarListFragment();
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        activityInterface.getContainer().linearLayoutMenu.setVisibility(View.VISIBLE);
        activityInterface.getContainer().toolbar.setVisibility(View.VISIBLE);
    }

    @Override
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle savedInstanceState) {
        View view = layoutInflater.inflate(R.layout.fragment_seminar_list, viewGroup, false);
        activityInterface.getContainer().setTitle(getString(R.string.title_seminars_and_technical_workshops));
        view.findViewById(R.id.buttonFind).setOnClickListener(this);
        imageView = view.findViewById(R.id.imageView);
        RecyclerView recyclerViewNew = view.findViewById(R.id.recyclerViewNew);
        recyclerViewNew.setLayoutManager(new LinearLayoutManager(activity));
        RecyclerView recyclerViewPast = view.findViewById(R.id.recyclerViewPast);
        recyclerViewPast.setLayoutManager(new LinearLayoutManager(activity));
        Gson gson = new Gson();
        ArrayList<Seminar> arrayListNew = new ArrayList<>();
        ArrayList<Seminar> arrayListPast = new ArrayList<>();
        try {
            JSONArray jsonArray = new JSONArray(loadJSONFromAssets());
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject jsonObject = jsonArray.getJSONObject(i);
                String dateString = jsonObject.getString("date");
                SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy", Locale.getDefault());
                Date date = new Date();
                try {
                    date = dateFormat.parse(dateString);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
                if (new Date().before(date)) {
                    jsonObject.put("outdated", false);
                    arrayListNew.add(gson.fromJson(jsonArray.getString(i), Seminar.class));
                } else {
                    jsonObject.put("outdated", true);
                    arrayListPast.add(gson.fromJson(jsonArray.getString(i), Seminar.class));
                }
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }
        SeminarListAdapter seminarListAdapterNew = new SeminarListAdapter(activity, arrayListNew);
        seminarListAdapterNew.setOnItemClickListener(this);
        recyclerViewNew.setAdapter(seminarListAdapterNew);
        recyclerViewNew.addItemDecoration(new DividerItemDecoration(activity, DividerItemDecoration.VERTICAL));
        SeminarListAdapter seminarListAdapterPast = new SeminarListAdapter(activity, arrayListPast);
        seminarListAdapterPast.setOnItemClickListener(this);
        recyclerViewPast.setAdapter(seminarListAdapterPast);
        recyclerViewPast.addItemDecoration(new DividerItemDecoration(activity, DividerItemDecoration.VERTICAL));
        textViewUpdate = view.findViewById(R.id.textView);
        textViewUpdate.setText(String.format(getString(R.string.text_auto_update), sharedPreferences.getBoolean(SETTINGS_AUTO_UPDATE, false) ? getString(R.string.settings_on) : getString(R.string.settings_off)));
        textViewUpdate.setOnClickListener(this);
        if (sharedPreferences.getBoolean(SETTINGS_AUTO_UPDATE, false)) {
            handler.postDelayed(runnable, 1000);
        }
        if (TextUtils.equals(language, String.valueOf(Locale.TRADITIONAL_CHINESE))) {
            imageView.setImageResource(imagesTc[0]);
        }
        if (TextUtils.equals(language, String.valueOf(Locale.SIMPLIFIED_CHINESE))) {
            imageView.setImageResource(imagesSc[0]);
        }
        if (TextUtils.equals(language, String.valueOf(Locale.ENGLISH))) {
            imageView.setImageResource(imagesEn[0]);
        }
        return view;
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        handler.removeCallbacks(runnable);
    }

    private String loadJSONFromAssets() {
        String json;
        try {
            InputStream inputStream = activity.getAssets().open("seminars.json");
            int size = inputStream.available();
            byte[] buffer = new byte[size];
            inputStream.read(buffer);
            inputStream.close();
            json = new String(buffer, "UTF-8");
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
        return json;
    }

    @SuppressWarnings("unchecked")
    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.buttonFind:
                activityInterface.getContainer().setFragmentChild(PeriodFragment.newInstance());
                break;
            case R.id.textView:
                if (sharedPreferences.getBoolean(SETTINGS_AUTO_UPDATE, false)) {
                    new AlertDialog.Builder(activity, R.style.alertDialogStyle)
                            .setMessage(R.string.text_stop_auto_update)
                            .setCancelable(false)
                            .setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialogInterface, int i) {
                                    sharedPreferences.edit().putBoolean(SETTINGS_AUTO_UPDATE, false).apply();
                                    textViewUpdate.setText(String.format(getString(R.string.text_auto_update), getString(R.string.settings_off)));
                                    handler.removeCallbacks(runnable);
                                }
                            })
                            .setNegativeButton(android.R.string.no, null)
                            .show();
                } else {
                    new AlertDialog.Builder(activity, R.style.alertDialogStyle)
                            .setMessage(R.string.text_start_auto_update)
                            .setCancelable(false)
                            .setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialogInterface, int i) {
                                    sharedPreferences.edit().putBoolean(SETTINGS_AUTO_UPDATE, true).apply();
                                    textViewUpdate.setText(String.format(getString(R.string.text_auto_update), getString(R.string.settings_on)));
                                    handler.postDelayed(runnable, 1000);
                                }
                            })
                            .setNegativeButton(android.R.string.no, null)
                            .show();
                }
                break;
        }
    }

    @Override
    public void onItemClick(View view, int position, Seminar seminar) {
        activityInterface.getContainer().setFragmentChild(SeminarFragment.newInstance(seminar));
    }
}