<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kakao Map with Building Name Search</title>
    <!-- Kakao Maps API -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f8cd36a9ca80015c17a395ab719b2d8d&libraries=services,places"></script>
    <style>
        #map {
            width: 100%;
            height: 500px;
        }
        #results {
            list-style: none;
            padding: 0;
        }
        #results li {
            cursor: pointer;
            padding: 5px;
            border-bottom: 1px solid #ccc;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        #results li:hover {
            background-color: #f0f0f0;
        }
        .selectButton {
            display: none;
            margin-left: 10px;
            padding: 5px;
            background-color: #007BFF;
            color: white;
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
	<input type="text" name="departure_name" id="departure_name" class="requiredInfo" size="40" maxlength="40" style="padding: 5px;" placeholder="Departure Name" readonly/>&nbsp;&nbsp;
    <input type="text" name="departure_address" id="departure_address" class="requiredInfo" size="80" maxlength="80" style="padding: 5px;" placeholder="Departure Address" readonly/> 

    <input type="text" id="buildingName" placeholder="Enter building name">
    <button id="searchButton">Search</button>
    <ul id="results"></ul>
    <div id="map"></div>

    
    <script>
        window.onload = function() {
            if (typeof kakao === 'undefined' || !kakao.maps) {
                console.error('Failed to load Kakao Maps API');
                return;
            }

            var mapContainer = document.getElementById('map'); 
            var mapOption = { 
                center: new kakao.maps.LatLng(37.566535, 126.97796919999996), 
                level: 3 
            }; 

            var map = new kakao.maps.Map(mapContainer, mapOption); 

            if (!kakao.maps.services) {
                console.error('Kakao Maps services library not loaded');
                return;
            }

            var ps = new kakao.maps.services.Places(); 
            var markers = [];

            document.getElementById('searchButton').onclick = function() {
                var buildingName = document.getElementById('buildingName').value;
                ps.keywordSearch(buildingName, placesSearchCB);
            };

            function placesSearchCB(data, status, pagination) {
                if (status === kakao.maps.services.Status.OK) {
                    var resultsList = document.getElementById('results');
                    resultsList.innerHTML = '';
                    var bounds = new kakao.maps.LatLngBounds();

                    // Clear existing markers
                    clearMarkers();

                    data.forEach(function(place) {
                        var li = document.createElement('li');
                        li.textContent = place.place_name;

                        var selectButton = document.createElement('button');
                        selectButton.textContent = 'Select';
                        selectButton.className = 'selectButton';
                        selectButton.onclick = function(event) {
                            event.stopPropagation();
                            showPlaceInfo(place);
                        };

                        li.appendChild(selectButton);
                        li.onclick = function() {
                            map.setCenter(new kakao.maps.LatLng(place.y, place.x));
                            clearMarkers();
                            displayMarker(place);

                            // Show select button for the clicked list item
                            document.querySelectorAll('.selectButton').forEach(function(button) {
                                button.style.display = 'none';
                            });
                            selectButton.style.display = 'inline';
                        };

                        resultsList.appendChild(li);
                        
                        // Display marker for each place
                        var marker = displayMarker(place);
                        markers.push(marker);
                        bounds.extend(new kakao.maps.LatLng(place.y, place.x));
                    });

                    // Adjust map bounds to show all markers
                    map.setBounds(bounds);
                } else {
                    console.error('Failed to find the location:', status);
                }
            }

            function displayMarker(place) {
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: new kakao.maps.LatLng(place.y, place.x)
                });

                kakao.maps.event.addListener(marker, 'click', function() {
                    var infowindow = new kakao.maps.InfoWindow({
                        content: '<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>'
                    });
                    infowindow.open(map, marker);
                });

                return marker;
            }

            function clearMarkers() {
                markers.forEach(function(marker) {
                    marker.setMap(null);
                });
                markers = [];
            }

            function showPlaceInfo(place) {
            	console.log(place);
                var place_name = place.place_name;
                var road_address_name = place.road_address_name;

                document.getElementById('departure_name').value = place_name;
                document.getElementById('departure_address').value = road_address_name;
            }
        }
    </script>
</body>
</html>
