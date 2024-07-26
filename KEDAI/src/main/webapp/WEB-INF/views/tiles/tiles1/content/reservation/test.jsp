<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kakao Map Directions Example</title>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f8cd36a9ca80015c17a395ab719b2d8d&libraries=services"></script>
    <style>
        #map {
            width: 100%;
            height: 400px;
        }
    </style>
</head>
<body>
    <div id="map"></div>
    <script>
        var mapContainer = document.getElementById('map'), // div to display the map
            mapOption = {
                center: new kakao.maps.LatLng(37.5665, 126.9780), // Center coordinates of the map
                level: 5 // Map zoom level
            };  

        // Create the map
        var map = new kakao.maps.Map(mapContainer, mapOption);

        // Coordinates for the starting point and the destination
        var startLatLng = new kakao.maps.LatLng(37.5665, 126.9780); // Seoul
        var endLatLng = new kakao.maps.LatLng(37.5651, 126.98955); // Jongno, Seoul

        // Create a Polyline object to display the route
        var linePath = new kakao.maps.Polyline({
            map: map,
            path: [startLatLng, endLatLng],
            strokeWeight: 5,
            strokeColor: '#FF0000',
            strokeOpacity: 0.7,
            strokeStyle: 'solid'
        });

        // Create a marker for the starting point
        var startMarker = new kakao.maps.Marker({
            position: startLatLng,
            map: map
        });

        // Create a marker for the destination
        var endMarker = new kakao.maps.Marker({
            position: endLatLng,
            map: map
        });

        // Create a Directions object
        var directions = new kakao.maps.services.Directions();
        
        // Request the route
        directions.route({
            origin: startLatLng,
            destination: endLatLng,
            travelMode: kakao.maps.services.Directions.TRAVEL_MODE_WALKING
        }, function(result, status) {
            if (status === kakao.maps.services.Status.OK) {
                var path = result.routes[0].overview_path;
                linePath.setPath(path); // Display the route on the map
            }
        });
    </script>
</body>
</html>
