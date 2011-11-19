package com.invited.mappings;

import android.os.Parcel;
import android.os.Parcelable;

public class Event implements Parcelable {
	public String name;
	public String location;
	public String finish;
	public String created_at;
	public String updated_at;
	public String id;
	public String user_id;
	public String start;
	public String disabled;
	public String description;
	
	public Event(){}
	
	@Override
	public String toString()
	{
		return this.name;
	}

	public int describeContents() {
		// TODO Auto-generated method stub
		return 0;
	}

	public void writeToParcel(Parcel dest, int flags) 
	{
		dest.writeString(name);
		dest.writeString(location);
		dest.writeString(finish);
		dest.writeString(created_at);
		dest.writeString(updated_at);
		dest.writeString(id);
		dest.writeString(user_id);
		dest.writeString(start);
		dest.writeString(disabled);
		dest.writeString(description);
	}
	
	public Event(Parcel in)
	{
		name=in.readString();
		location=in.readString();
		finish=in.readString();
		created_at= in.readString();
		updated_at = in.readString();
		id=in.readString();
		user_id= in.readString();
		start= in.readString();
		disabled = in.readString();
		description=in.readString();
	}
	
	 public static final Parcelable.Creator CREATOR =
	    	new Parcelable.Creator() {
	            public Event createFromParcel(Parcel in) {
	                return new Event(in);
	            }
	 
	            public Event[] newArray(int size) {
	                return new Event[size];
	            }
	        };
	
}
