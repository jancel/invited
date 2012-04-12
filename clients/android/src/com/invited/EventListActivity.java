package com.invited;

import com.invited.InvitedAsyncTask;
import com.invited.mappings.Event;

import android.content.Intent;
import android.content.SharedPreferences;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import org.json.JSONObject;
import org.json.JSONTokener;

import com.actionbarsherlock.app.SherlockListActivity;
import com.actionbarsherlock.view.Menu;
import com.actionbarsherlock.view.MenuInflater;
import com.actionbarsherlock.view.MenuItem;
import com.github.droidfu.activities.BetterListActivity;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;

public class EventListActivity extends SherlockListActivity {
    /** Called when the activity is first created. */
	
	private SharedPreferences data;
	private ArrayAdapter<Event>adapter;
	private boolean isRegistered;
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
            case R.id.menu_new:	    Intent settingsActivity = new Intent(getBaseContext(),CreateEvent.class);
            						startActivity(settingsActivity);
            						break;
        }
        return true;
    }
	
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
   
  		data = this.getSharedPreferences("data", MODE_PRIVATE);
  	    isRegistered=data.getBoolean("isRegistered", false);
  		
  		
  		
    }
    
    @Override
    protected void onResume()
    {
    	super.onResume();
        Intent intent = new Intent(this,RegisterActivity.class);
        
    	if(!isRegistered)
  			startActivity(intent);
  		else
  		{
  		
  			InvitedAsyncTask task = new InvitedAsyncTask(getApplicationContext());
  		    task.disableDialog();
  		    task.execute(WebServiceURLs.domain+"/events.json","get");
  		    Event[] values=null;
  			Gson gson = new Gson();
  			try 
  			{
  				
  				values = gson.fromJson(task.get(),Event[].class);
  				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
  		    
  			
  			adapter = new ArrayAdapter<Event>(this,android.R.layout.simple_list_item_1,values);
  			
  			
  			setListAdapter(adapter);
   			
  		}
    
    }
    
    
    @Override
    protected void onListItemClick(ListView l, View v, int position, long id)
    {
    	Intent i= new Intent(getApplicationContext(), EventDetailActivity.class);
    	i.putExtra("event",adapter.getItem((int)id));
    	startActivity(i);
    	
    
    }
}