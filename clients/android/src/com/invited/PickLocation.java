package com.invited;

import java.util.List;

import android.content.Context;
import android.location.Location;
import android.location.LocationManager;
import android.os.Bundle;
import android.view.KeyEvent;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.TextView.OnEditorActionListener;

import com.actionbarsherlock.app.SherlockMapActivity;
import com.google.android.maps.GeoPoint;
import com.google.android.maps.MapActivity;
import com.google.android.maps.MapController;
import com.google.android.maps.MapView;
import com.google.android.maps.Overlay;

public class PickLocation extends SherlockMapActivity implements OnEditorActionListener {

	private MapView mapView;
	private MapController mapController;
	private List<Overlay> mapOverlays;

	private LocationManager locationManager;
	
	@Override
	protected boolean isRouteDisplayed() {
		// TODO Auto-generated method stub
		return false;
	}
	
	 @Override
	 public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.pick_location);
        
        LocationManager locationManager = (LocationManager)	getSystemService(Context.LOCATION_SERVICE);
        
    
	        
	 }
	 
	 @Override
	 public void onResume()
	 {
	  	Location l = locationManager.getLastKnownLocation(LocationManager.PASSIVE_PROVIDER);
      
	    EditText et = (EditText) findViewById(R.id.searchtext);
        et.setOnEditorActionListener(this);
        
        mapView = (MapView) findViewById(R.id.mapview);
        mapView.setBuiltInZoomControls(true);
        mapController = mapView.getController();
        mapController.setZoom(17);
        mapController.animateTo(getGPLocation(l));
	 
	 }
	 
	 public GeoPoint getGPLocation(Location l){
		 return new GeoPoint((int)(l.getLatitude()*1e6), (int)(l.getLongitude()*1e6));
		 
	 }

	public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
		// TODO Auto-generated method stub
		return false;
	}

}
