package com.invited;

import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.impl.client.AbstractHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.HttpParams;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.util.Base64;
import android.widget.Toast;

import com.github.droidfu.concurrent.BetterAsyncTask;
import com.github.droidfu.http.BetterHttp;
import com.github.droidfu.http.BetterHttpRequest;
import com.github.droidfu.http.BetterHttpResponse;

public class InvitedAsyncTask extends BetterAsyncTask<String, Void, String> {

	
	public InvitedAsyncTask(Context arg0) {
		super(arg0);
		// TODO Auto-generated constructor stub
	}

	@Override
	protected void handleError(Context arg0, Exception arg1) {
		// TODO Auto-generated method stub
		
	}

	
	
	@Override
	protected String doCheckedInBackground(Context context, String... params) throws Exception {
		
		String cred= (String)Base64.encodeToString(("test:").getBytes(), Base64.DEFAULT);
		//BetterHttp.setDefaultHeader("User-Agent", "Android");
		//BetterHttp.setDefaultHeader("Authorization", "Basic "+cred);
		BetterHttp.setDefaultHeader("Accept", "application/json");
		BetterHttpRequest request;
		BetterHttpResponse response;
		List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
		String resp="";
		SharedPreferences data = context.getSharedPreferences("data", context.MODE_PRIVATE);
		
		//sets up session 
		if(BetterHttp.getHttpClient()==null)
			BetterHttp.setupHttpClient();
		
		//means device has already been registered and just grabbing session
		/*if(params[0]!=WebServiceURLs.registerUrl)
		{
			nameValuePairs.add(new BasicNameValuePair("device_id", data.getString("deviceId", "easycheesy1")));
			nameValuePairs.add(new BasicNameValuePair("app_token", data.getString("appToken", "4de9eed1fe4e44963a30d9763b17f6fb")));
			request = BetterHttp.post(WebServiceURLs.createSessionUrl,new UrlEncodedFormEntity(nameValuePairs));
			response = request.send();
			resp = response.getResponseBodyAsString();
		}
		
		//registering device automatically grabs session
		if(params[0]==WebServiceURLs.registerUrl)
		{
			nameValuePairs.add(new BasicNameValuePair("device_id", params[2].toString()));
			nameValuePairs.add(new BasicNameValuePair("email", params[3].toString())); 
			nameValuePairs.add(new BasicNameValuePair("terms", params[4].toString()));
			
		}*/
		
		if(params[0]==WebServiceURLs.placesQueryURL)
		{
			params[0] = params[0].toString()+"location="+params[2]+"&name="+params[3]+"&sensor=true";
			
		}
		
	
		
		String requestType = params[1].toString();
		if(requestType=="post")
			request = BetterHttp.post(params[0].toString(),new UrlEncodedFormEntity(nameValuePairs));
		else if(requestType=="get")
			request = BetterHttp.get(params[0].toString());
		else if(requestType=="put")
			request = BetterHttp.put(params[0].toString(),new UrlEncodedFormEntity(nameValuePairs));
		else
			request = BetterHttp.delete(params[0].toString());
		
		response= request.send();
		resp = (String)response.getResponseBodyAsString();
		
		return resp;
    }

	@Override
	protected void after(Context context, String jsonObject) 
	{
		// TODO Auto-generated method stub
		Toast.makeText(context, "test", 10);
	
	/*	Intent i = new Intent(context,InvitedActivity.class);
		i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
		context.startActivity(i);
	*/		
		
	}
	
	

}
