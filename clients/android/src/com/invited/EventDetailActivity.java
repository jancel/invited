package com.invited;

import android.os.Bundle;
import android.widget.Button;
import android.widget.TextView;


import com.github.droidfu.activities.BetterDefaultActivity;
import com.invited.mappings.Event;

public class EventDetailActivity extends BetterDefaultActivity
{
	@Override
	public void onCreate(Bundle savedInstanceState)
	{
		setContentView(R.layout.event_detail);
        super.onCreate(savedInstanceState);
        Bundle data = getIntent().getExtras();
        Event event = data.getParcelable("event");
        
        TextView t = (TextView)findViewById(R.eventdetail.name);
        t.setText(event.name);
        
        t = (TextView)findViewById(R.eventdetail.location);
        t.setText(event.location);
        
        t = (TextView)findViewById(R.eventdetail.finish);
        t.setText(event.finish);
        
        t = (TextView)findViewById(R.eventdetail.created_at);
        t.setText(event.created_at);
        
        t = (TextView)findViewById(R.eventdetail.updated_at);
        t.setText(event.updated_at);
        
        t = (TextView)findViewById(R.eventdetail.id);
        t.setText(event.id);
        
        t = (TextView)findViewById(R.eventdetail.user_id);
        t.setText(event.user_id);
        
        t = (TextView)findViewById(R.eventdetail.start);
        t.setText(event.start);
        
        t = (TextView)findViewById(R.eventdetail.disabled);
        t.setText(event.disabled);
        
        t = (TextView)findViewById(R.eventdetail.description);
        t.setText(event.description);
        
	}

}
