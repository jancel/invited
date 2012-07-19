package com.invited;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;
import android.widget.TextView;
import android.widget.Toast;

import com.actionbarsherlock.app.SherlockActivity;
import com.actionbarsherlock.app.SherlockListActivity;
import com.actionbarsherlock.view.Menu;
import com.actionbarsherlock.view.MenuInflater;
import com.actionbarsherlock.view.MenuItem;
import com.invited.mappings.Event;

public class CreateEvent extends SherlockActivity {
	
	private Intent activity;
	private Event newEvent;
	// set up actionbar buttons
	   @Override
	   public boolean onCreateOptionsMenu(Menu menu) {
	        MenuInflater inflater = getSupportMenuInflater();
	        inflater.inflate(R.menu.create_event, menu);
	        return true;
	    }
	    
	   // set up actions for buttons 
	    @Override
	    public boolean onOptionsItemSelected(MenuItem item) {
	        switch (item.getItemId()) {
	            case R.id.create_event_location:
	            				selectLocationType();
        						/*activity = new Intent(this,PickLocation.class);
        						startActivityForResult(activity, 123);*/
        						break;
	            case R.id.create_event_people:
				            	activity = new Intent(this,PickLocation.class);
								startActivityForResult(activity, 123);
								break;
	            case R.id.create_event_save:				
				            	activity = new Intent(this,PickLocation.class);
								startActivityForResult(activity, 123);
								break;
        						
	        }
	        return true;
	    }
		
	    @Override
	    public void onCreate(Bundle savedInstanceState) 
	    {
	        super.onCreate(savedInstanceState);
	        setContentView(R.layout.create_event);
	        
	    
	    }

	    @Override
	    public void onResume()
	    {
	    	super.onResume();
	    	newEvent = new Event();
	    }
	    
		public void onClick(View arg0) {
			// TODO Auto-generated method stub
			Intent i = new Intent(this,PickLocation.class);
			startActivityForResult(i, 123);
			
		}
		
		@Override
	    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
			
	        if(resultCode==123)
	        {
	        	Toast.makeText(getApplicationContext(), data.getStringExtra("name")+ " " + data.getStringExtra("vicinity")+ " " + data.getStringExtra("reference"), Toast.LENGTH_LONG);

	        	newEvent.name=data.getStringExtra("name");
	        	newEvent.location= data.getStringExtra("vicinity");
	        	newEvent.reference= data.getStringExtra("reference");
	        	
	        	LinearLayout ll = (LinearLayout)findViewById(R.id.event_layout);
	            LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.WRAP_CONTENT);

	            TextView tv = new TextView(this);
	            tv.setId(1);
	            tv.setTextSize(15);
	            tv.setText(data.getStringExtra("name"));
	            tv.setLayoutParams(lp);
	            ll.addView(tv);
	            ll.invalidate();
	        }
	        
	        super.onActivityResult(requestCode, resultCode, data);
	        	
		}
		
		protected void selectLocationType()
		{
			final EditText input = new EditText(this); 
			
			AlertDialog.Builder builder = new AlertDialog.Builder(this);
			builder.setMessage("Enter location")
			       .setCancelable(false)
			       .setPositiveButton("Yes", new DialogInterface.OnClickListener() {
			           public void onClick(DialogInterface dialog, int id) {
			        	   
			        	   newEvent.name=input.getText().toString();
			                
			           }
			       })
			       .setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
			           public void onClick(DialogInterface dialog, int id) {
			                dialog.cancel();
			           }
			       })
			       .setNeutralButton("Pick from Map", new DialogInterface.OnClickListener() {
					
					public void onClick(DialogInterface dialog, int which) {
						// TODO Auto-generated method stub
						
						activity = new Intent(CreateEvent.this,PickLocation.class);
						activity.putExtra("query", input.getText().toString());
						startActivityForResult(activity, 123);
						}
			       })
			       .setView(input);
			       
			       
			
			AlertDialog alert = builder.create();
			alert.show();
			
		
		}

}
