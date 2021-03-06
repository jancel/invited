package com.invited;

import com.invited.InvitedAsyncTask;
import com.invited.mappings.Event;

import android.app.ListActivity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import org.json.JSONObject;
import org.json.JSONTokener;

import com.github.droidfu.activities.BetterListActivity;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;

public class EventListActivity extends BetterListActivity {
    /** Called when the activity is first created. */
	
	private SharedPreferences data;
	private ArrayAdapter<Event>adapter;
	
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        Intent intent = new Intent(this,RegisterActivity.class);
  		data = this.getSharedPreferences("data", MODE_PRIVATE);
  		boolean isRegistered=data.getBoolean("isRegistered", false);
  		
  		if(!isRegistered)
  			startActivity(intent);
  		else
  		{
  		
  			InvitedAsyncTask task = new InvitedAsyncTask(getApplicationContext());
  		    task.disableDialog();
  		    task.execute("http://jancel.doesntexist.com:3000/events.json","get");
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