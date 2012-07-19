package com.invited;

import java.util.List;

import android.app.AlertDialog;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.location.Location;
import android.location.LocationManager;
import android.os.Bundle;
import android.view.KeyEvent;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.TextView.OnEditorActionListener;

import com.actionbarsherlock.app.SherlockMapActivity;
import com.actionbarsherlock.view.Window;
import com.google.android.maps.GeoPoint;
import com.google.android.maps.MapActivity;
import com.google.android.maps.MapController;
import com.google.android.maps.MapView;
import com.google.android.maps.Overlay;
import com.google.android.maps.OverlayItem;
import com.google.gson.Gson;
import com.invited.mappings.Event;
import com.invited.mappings.LocationResult;
import com.invited.mappings.SearchResults;

public class PickLocation extends SherlockMapActivity implements OnEditorActionListener {

	private MapView mapView;
	private MapController mapController;
	private List<Overlay> mapOverlays;
	private InvitedItemizedOverlay itemizedOverlay;
	private LocationManager locationManager;
	private Location l;
	private SearchResults values;
	
	private BroadcastReceiver receiver = new BroadcastReceiver() {
		
		@Override
		public void onReceive(Context context, Intent intent) {
		
			int ind = intent.getIntExtra("index", 0);
			LocationResult lr = values.results[ind];
			
			Intent locdata = new Intent();
			locdata.putExtra("result", lr);
			//locdata.putExtra("reference", lr.reference);
			//locdata.putExtra("name", lr.name);
			//locdata.putExtra("vicinity", lr.vicinity);
			
			PickLocation.this.setResult(123,locdata);
			PickLocation.this.finish();
		}
	};
	
	
	@Override
	protected boolean isRouteDisplayed() {
		// TODO Auto-generated method stub
		return false;
	}
	
	 @Override
	 public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
       // requestWindowFeature(Window.FEATURE_INDETERMINATE_PROGRESS);
        setContentView(R.layout.pick_location);
       
        locationManager = (LocationManager)	getSystemService(Context.LOCATION_SERVICE);
        mapView = (MapView) findViewById(R.id.mapview);
        mapView.setBuiltInZoomControls(true);
        mapController = mapView.getController();
        mapController.setZoom(15);
    
        //EditText et = (EditText) findViewById(R.id.searchtext);
        //et.setOnEditorActionListener(this);
        
        
      //  setSupportProgressBarIndeterminateVisibility(false);
     
	 }
	 
	 @Override
	 public void onResume()
	 {
		IntentFilter filter = new IntentFilter();
        filter.addAction("PickLocation.Selected");
        registerReceiver(receiver, filter);
	        
		super.onResume();
	  	l = locationManager.getLastKnownLocation(LocationManager.PASSIVE_PROVIDER);
        mapController.setCenter(getGPLocation(l));
        itemizedOverlay = new InvitedItemizedOverlay(this.getResources().getDrawable(R.drawable.red_dot_marker),this);
        
      
	 }
	 
	 @Override
	 protected void onPause() {
        unregisterReceiver(receiver);
       
        super.onPause();
	 }
	 
	 public GeoPoint getGPLocation(Location l){
		 return new GeoPoint((int)(l.getLatitude()*1e6), (int)(l.getLongitude()*1e6));
		 
	 }

	public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
		// call GooglePlaces Api
		
		if(mapView.getOverlays()!=null)
			mapView.getOverlays().clear();
		
		if(itemizedOverlay!=null)
			itemizedOverlay.clear();

		
		InvitedAsyncTask task = new InvitedAsyncTask(getApplicationContext());
	    task.disableDialog();
	  //  setSupportProgressBarIndeterminateVisibility(true);
	    EditText et = (EditText) findViewById(R.id.searchtext);
	    
	    task.execute(WebServiceURLs.placesQueryURL,"get",Double.toString(l.getLatitude())+","+Double.toString(l.getLongitude()),et.getText().toString());
	    values=null;
		Gson gson = new Gson();
		try 
		{
			String t= task.get();
			values = gson.fromJson(t,SearchResults.class);
			
			//
			if(values.results.length>0)
				for (LocationResult lr : values.results) {
					//add overlays
					double lat = Double.parseDouble(lr.geometry.location.lat);
					double lng = Double.parseDouble(lr.geometry.location.lng);
					GeoPoint g = new GeoPoint((int)(lat*1e6), (int)(lng*1e6));
					OverlayItem o = new OverlayItem(g, lr.name,lr.vicinity);
					itemizedOverlay.addOverlay(o);
				}
			else
			{
				AlertDialog.Builder dialog = new AlertDialog.Builder(this);
				dialog.setTitle("No results");
				dialog.setMessage("No items found for that query");
				dialog.show();
				return false;
			}
			
			/*GeoPoint g = new GeoPoint((int)(l.getLatitude()*1e6), (int)(l.getLongitude()*1e6));
			OverlayItem o = new OverlayItem(g, "","");
			itemizedOverlay.addOverlay(o);
			*/
			mapController.zoomToSpan(itemizedOverlay.getLatSpanE6(), itemizedOverlay.getLonSpanE6());
			itemizedOverlay.removeItem(itemizedOverlay.size()-1);
			
			mapOverlays = mapView.getOverlays();
			mapOverlays.add(itemizedOverlay);
			mapView.invalidate();
			mapController.setCenter(getGPLocation(l));
		//	setSupportProgressBarIndeterminateVisibility(false);
	
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return false;
	}

}
