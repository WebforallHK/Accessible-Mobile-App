package hk.gov.ogcio.wcag.fragment;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.CameraPosition;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;

import hk.gov.ogcio.wcag.R;
import hk.gov.ogcio.wcag.gson.Seminar;
import hk.gov.ogcio.wcag.manager.FragmentManager;

public class MapFragment extends FragmentManager implements OnMapReadyCallback {

    private Seminar seminar;

    public static MapFragment newInstance(Seminar seminar) {
        MapFragment mapFragment = new MapFragment();
        mapFragment.seminar = seminar;
        return mapFragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        activityInterface.getContainer().linearLayoutMenu.setVisibility(View.VISIBLE);
        activityInterface.getContainer().toolbar.setVisibility(View.VISIBLE);
    }

    @Override
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle savedInstanceState) {
        View view = layoutInflater.inflate(R.layout.fragment_map, viewGroup, false);
        activityInterface.getContainer().setTitle(getString(R.string.title_seminars_and_technical_workshop_details));
        TextView textViewAddress = view.findViewById(R.id.textViewAddress);
        textViewAddress.setText(seminar.getVenue(activity));
        setViewSlide(textViewAddress);
        SupportMapFragment supportMapFragment = (SupportMapFragment) this.getChildFragmentManager().findFragmentById(R.id.mapFragment);
        supportMapFragment.getMapAsync(this);
        return view;
    }

    @Override
    public void onMapReady(GoogleMap googleMap) {
        LatLng latLng = new LatLng(Double.valueOf(seminar.getCoordinate().split(", ")[0]), Double.valueOf(seminar.getCoordinate().split(", ")[1]));
        googleMap.addMarker(new MarkerOptions().position(latLng).title(seminar.getVenue(activity))).showInfoWindow();
        googleMap.moveCamera(CameraUpdateFactory.newCameraPosition(new CameraPosition.Builder().target(latLng).zoom(17).build()));
        googleMap.getUiSettings().setAllGesturesEnabled(false);
        googleMap.getUiSettings().setMapToolbarEnabled(false);
    }
}