package com.invited;

import com.google.gson.Gson;
import com.invited.mappings.Event;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.support.v4.app.ListFragment;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

public class EventListFragment extends ListFragment{
	private SharedPreferences data;
	private ArrayAdapter<Event>adapter;
	
    @Override
    public void onActivityCreated(Bundle savedInstanceState) 
    {
        super.onActivityCreated(savedInstanceState);
        
        Intent intent = new Intent(getActivity(),RegisterActivity.class);
  		data = getActivity().getSharedPreferences("data", getActivity().MODE_PRIVATE);
  		boolean isRegistered=data.getBoolean("isRegistered", false);
  		
  		if(!isRegistered)
  			startActivity(intent);
  		else
  		{
  		
  			InvitedAsyncTask task = new InvitedAsyncTask(getActivity());
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
  		    
  			
  			adapter = new ArrayAdapter<Event>(getActivity(),android.R.layout.simple_list_item_1,values);
  			
  			this.setListAdapter(adapter);
  			
   			
  		}
  		
    }
    
    @Override
	public void onListItemClick(ListView l, View v, int position, long id)
    {
    	Intent i= new Intent(getActivity(), EventDetailActivity.class);
    	i.putExtra("event",adapter.getItem((int)id));
    	startActivity(i);
    	
    
    }
}
