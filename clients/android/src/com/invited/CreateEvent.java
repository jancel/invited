package com.invited;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;

import com.actionbarsherlock.app.SherlockActivity;
import com.actionbarsherlock.app.SherlockListActivity;
import com.actionbarsherlock.view.Menu;
import com.actionbarsherlock.view.MenuInflater;
import com.actionbarsherlock.view.MenuItem;

public class CreateEvent extends SherlockActivity implements OnClickListener {
	
	// set up actionbar buttons
	   @Override
	   public boolean onCreateOptionsMenu(Menu menu) {
	        MenuInflater inflater = getSupportMenuInflater();
	        inflater.inflate(R.menu.event_list, menu);
	        return true;
	    }
	    
	   // set up actions for buttons 
	    @Override
	    public boolean onOptionsItemSelected(MenuItem item) {
	        switch (item.getItemId()) {
	            case R.id.menu_new:	    Intent settingsActivity = new Intent(getBaseContext(),EventListActivity.class);
	            						startActivity(settingsActivity);
	            						break;
	        }
	        return true;
	    }
		
	    @Override
	    public void onCreate(Bundle savedInstanceState) 
	    {
	        super.onCreate(savedInstanceState);
	        setContentView(R.layout.create_event);
	        
	        Button b = (Button)findViewById(R.id.btnMap);
	        b.setOnClickListener(this);
	    }

		public void onClick(View arg0) {
			// TODO Auto-generated method stub
			Intent i = new Intent(this,PickLocation.class);
			startActivity(i);
		}

}
