package com.invited;

import java.lang.reflect.Type;
import java.util.List;
import java.util.concurrent.ExecutionException;

import android.app.Activity;
import android.app.ListActivity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.provider.Settings.Secure;
import android.widget.ArrayAdapter;
import org.json.JSONObject;
import org.json.JSONTokener;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;

public class InvitedActivity extends ListActivity {
    /** Called when the activity is first created. */
	
	private SharedPreferences data;
	private ArrayAdapter<InvitedEvents>adapter;
	private String androidId;

	
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        Intent intent = new Intent(this,InvitedRegisterActivity.class);
  		data = this.getSharedPreferences("data", MODE_PRIVATE);
  		boolean isRegistered=data.getBoolean("isRegistered", false);
  		
  		if(!isRegistered)
  			startActivity(intent);
  		else
  		{
  		
  			InvitedAsyncTask task = new InvitedAsyncTask(getApplicationContext());
  		    task.disableDialog();
  		    task.execute("http://jancel.doesntexist.com:3000/events.json","get");
  		    InvitedEvents[] values=null;
  		    InvitedEvents d=null;
  			Gson gson = new Gson();
  			try 
  			{
  				JSONObject j = task.get();
  				d = gson.fromJson(j.toString(),InvitedEvents.class);
  				values = new InvitedEvents[1];
  				values[0]=d;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
  		    
  			
  			
  			adapter = new ArrayAdapter<InvitedEvents>(this,android.R.layout.simple_list_item_1,values);
  			
  			
  			setListAdapter(adapter);
  			

  			
  			
  			
  			
  		}
  		
    }
}