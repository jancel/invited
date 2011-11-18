package com.invited;

import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.impl.client.AbstractHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.HttpParams;
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

public class InvitedAsyncTask extends BetterAsyncTask<String, Void, JSONObject> {

	private SharedPreferences data;
	private SharedPreferences.Editor dataEditor;

	
	public InvitedAsyncTask(Context arg0) {
		super(arg0);
		// TODO Auto-generated constructor stub
	}

	@Override
	protected void handleError(Context arg0, Exception arg1) {
		// TODO Auto-generated method stub
		
	}

	
	
	@Override
	protected JSONObject doCheckedInBackground(Context context, String... params) throws Exception {
		
		if(BetterHttp.getHttpClient()==null)
			BetterHttp.setupHttpClient();
		
		String cred= (String)Base64.encodeToString(("test: ").getBytes(), Base64.DEFAULT);
		BetterHttp.setDefaultHeader("User-Agent", "Android");
		BetterHttp.setDefaultHeader("Authorization", "Basic "+cred);

		
		List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
		
		
		if(params[0]==InvitedWebServiceURLs.registerUrl)
		{
			nameValuePairs.add(new BasicNameValuePair("device_id", params[1].toString()));
			nameValuePairs.add(new BasicNameValuePair("email", params[2].toString())); 
			nameValuePairs.add(new BasicNameValuePair("terms", params[3].toString()));
			
		}
		
		if(params[0]==InvitedWebServiceURLs.createSessionUrl)
		{
			nameValuePairs.add(new BasicNameValuePair("device_id", params[1].toString()));
			nameValuePairs.add(new BasicNameValuePair("app_token", params[2].toString()));
		}
		
		BetterHttpRequest post = BetterHttp.post(params[0].toString(),new UrlEncodedFormEntity(nameValuePairs));
		BetterHttpResponse response= post.send();
		String s = (String)response.getResponseBodyAsString();
		
		data = context.getSharedPreferences("data", context.MODE_PRIVATE);
		dataEditor = data.edit();
		dataEditor.putBoolean("isRegistered", true);
		dataEditor.commit();
		JSONObject object=null;
		
		try
		{
		
		 object = (JSONObject) new JSONTokener(response.getResponseBodyAsString()).nextValue();
		
		}
		catch(Exception e)
		{
			object= (JSONObject) new JSONTokener("{name:'asdf'}").nextValue();
		}
		finally
		{
			return object;
		}
    }

	@Override
	protected void after(Context context, JSONObject jsonObject) 
	{
		// TODO Auto-generated method stub
		Toast.makeText(context, "test", 10);
	
	/*	Intent i = new Intent(context,InvitedActivity.class);
		i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
		context.startActivity(i);
	*/		
		
	}
	
	

}
