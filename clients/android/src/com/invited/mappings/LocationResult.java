package com.invited.mappings;

import android.os.Parcel;
import android.os.Parcelable;

public class LocationResult implements Parcelable {

	public Geometry geometry;
	public String icon;
	public String id;
	public String name;
	public String reference;
	public String[] types;
	public String vicinity;
	
	public int describeContents() {
		// TODO Auto-generated method stub
		return 0;
	}
	public void writeToParcel(Parcel dest, int flags) {
		// TODO Auto-generated method stub
		dest.writeParcelable(geometry, 0);
		dest.writeString(icon);
		dest.writeString(id);
		dest.writeString(name);
		dest.writeString(reference);
		dest.writeStringArray(types);
		dest.writeString(vicinity);
		
	}
	
	public LocationResult(Parcel in)
	{
		geometry = in.readParcelable(null);
		icon = in.readString();
		name = in.readString();
		reference = in.readString();
		String[] val=null;
		in.readStringArray(val);
		types = val;
		vicinity = in.readString();
		
	}
	
	 public static final Parcelable.Creator CREATOR =
	    	new Parcelable.Creator() {
	            public LocationResult createFromParcel(Parcel in) {
	                return new LocationResult(in);
	            }
	 
	            public LocationResult[] newArray(int size) {
	                return new LocationResult[size];
	            }
	        };
}
