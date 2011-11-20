FactoryGirl.define do
  sequence :location do |n| 
    "3#{n}.78,-9#{n}.564" 
  end
  sequence :get_places_json do |n| <<-EOF
  {
   "html_attributions" : [],
   "results" : [
      {
         "geometry" : {
            "location" : {
               "lat" : 38.7817320,
               "lng" : -90.56380930
            }
         },
         "icon" : "http://maps.gstatic.com/mapfiles/place_api/icons/geocode-71.png",
         "id" : "e158a87b638d396c9236ff0c658ae7d6d12b3a6a",
         "name" : "Whetstone Dr",
         "reference" : "#{n}CnRtAAAA2twcFbBmnQucS8zWLRmQ3No0bdsff8JMuzfhUQ5Z_gNrnFGzmeFoT4VELlxCQgDFkzwBuLkLLc-G-9np4Gj_p_oZhnF0xZI1m22-Vcif3k53E1R18A1wGGtX2EES6mUScZXlBGoFdP5UW1P30tkvfRIQCyM7yvYjSVTuyDqMDG0beRoU4Nkl74uNIegqdTGd4F_j05cJp8g",
         "types" : [ "route" ],
         "vicinity" : "St Charles"
      },
      {
         "geometry" : {
            "location" : {
               "lat" : 38.78333330,
               "lng" : -90.51666670
            }
         },
         "icon" : "http://maps.gstatic.com/mapfiles/place_api/icons/geocode-71.png",
         "id" : "f16370e1b263acaca2e383e00155cef470e8737a",
         "name" : "St Charles",
         "reference" : "CnRrAAAA2q5G-HH1gpoX0-4h-3goV928FQ8ibC36AlOXEpoQt6-vOB9YTGE92i0m94tV3Turv7ah8F9-n-2DysK28BYNi8jsBomMyIszJ5SgrORIxUs8y4CSKk3ejS3AwcEMY_wPi1u7vrog_6DwbQB4sCPn6xIQZd3_nQ4mlb8pIBNz3UG1tBoUzD0kROiQB8oFB0PjD2WWnaQMIDg",
         "types" : [ "locality", "political" ],
         "vicinity" : "St Charles"
      }
   ],
   "status" : "OK"
  }
  EOF
  end

  sequence :get_details_json do |n| <<-EOF
  {
   "html_attributions" : [],
   "result" : {
      "address_components" : [
         {
            "long_name" : "St Charles",
            "short_name" : "St Charles",
            "types" : [ "locality", "political" ]
         },
         {
            "long_name" : "Lindenwood",
            "short_name" : "Lindenwood",
            "types" : [ "administrative_area_level_3", "political" ]
         },
         {
            "long_name" : "St Charles",
            "short_name" : "St Charles",
            "types" : [ "administrative_area_level_2", "political" ]
         },
         {
            "long_name" : "Missouri",
            "short_name" : "MO",
            "types" : [ "administrative_area_level_1", "political" ]
         },
         {
            "long_name" : "United States",
            "short_name" : "US",
            "types" : [ "country", "political" ]
         }
      ],
      "formatted_address" : "St Charles, MO, USA",
      "geometry" : {
         "location" : {
            "lat" : 38.78333330,
            "lng" : -90.51666670
         },
         "viewport" : {
            "northeast" : {
               "lat" : 38.81811630,
               "lng" : -90.4526370
            },
            "southwest" : {
               "lat" : 38.74853330,
               "lng" : -90.58069639999999
            }
         }
      },
      "icon" : "http://maps.gstatic.com/mapfiles/place_api/icons/geocode-71.png",
      "id" : "f16370e1b263acaca2e383e00155cef470e8737a",
      "name" : "St Charles",
      "reference" : "CnRqAAAARi5NBdvHWQp8lSuTjPzBV5E1NwSDZHKRAaq3h3Vb1LXujHkekn-bO0xYPBUIkx0t3JWKzSyY4qqcUrH5OKpKSceanJW4ufIbeIeFSJ0ad9H-zWCTHDIMb9ta_rJbSQ9NWea6cEDFWNOaZTC37MeU-BIQRWXFcVYUOjH50a2xhXBQFRoU5T2T265YBQFwHthpusMtrZ5JQnM",
      "types" : [ "locality", "political" ],
      "url" : "http://maps.google.com/maps/place?ftid=0x87df2f0888cc24e3:0xc437f0ab118cf5aa",
      "vicinity" : "St Charles"
   },
   "status" : "OK"
}
EOF
  end
end
