package com.invited;

import android.os.Bundle;

import com.google.android.maps.MapActivity;

public class PickLocation extends MapActivity {

	@Override
	protected boolean isRouteDisplayed() {
		// TODO Auto-generated method stub
		return false;
	}
	
	 @Override
	    public void onCreate(Bundle savedInstanceState) {
	        super.onCreate(savedInstanceState);
	        setContentView(R.layout.pick_location);
	        
	 }

}
