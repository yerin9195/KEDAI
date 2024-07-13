<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   // 컨텍스트 패스명(context path name)을 알아오고자 한다.
   String ctxPath = request.getContextPath();
%>

<!-- jQuery CSS -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<!-- DateTimePicker CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css">

<!-- jQuery JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- DateTimePicker JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js"></script>

<!-- Kakao Maps API -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f8cd36a9ca80015c17a395ab719b2d8d&libraries=services,places"></script>

<style type="text/css">
/* Modal styles */
.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
    padding-top: 60px;
}
.modal-content {
    background-color: #fefefe;
    margin: 5% auto; /* 15% from the top and centered */
    padding: 20px;
    border: 1px solid #888;
    width: 80%; /* Could be more or less, depending on screen size */
}
.close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}
.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}
#map {
    width: 100%;
    height: 400px;
    margin-top: 10px;
}
#results {
    list-style: none;
    padding: 0;
    max-height: 200px;
    overflow-y: auto;
    margin-top: 10px;
}
#results li {
    padding: 10px;
    border-bottom: 1px solid #ddd;
    cursor: pointer;
}
#results li:hover {
    background-color: #f0f0f0;
}
</style>

<script type="text/javascript">
$(document).ready(function() {
    // 모달 열기 버튼 및 모달 요소
    var modal = document.getElementById("mapModal");
    var btn = document.getElementById("arrive_zipcodeSearch");
    var span = document.getElementsByClassName("close")[0];
    var searchButton = document.getElementById('searchButton');

    // 모달 display 속성 변경 추적
    Object.defineProperty(modal.style, 'display', {
        set: function(value) {
            console.log('Modal display changed to:', value);
            this.setProperty('display', value);
        }
    });

    // 모달 열기
    btn.onclick = function() {
        modal.style.display = "block";
        initializeMap();
        console.log('Modal opened');
    }

    // 모달 닫기
    span.onclick = function() {
        modal.style.display = "none";
    }

    // 모달 외부 클릭 시 닫기
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }

    // Kakao Maps API 로드 확인
    if (typeof kakao === 'undefined' || !kakao.maps) {
        console.error('Failed to load Kakao Maps API');
        return;
    }

    var map;
    var ps;

    function initializeMap() {
        var mapContainer = document.getElementById('map'); 
        var mapOption = { 
            center: new kakao.maps.LatLng(37.566535, 126.97796919999996), 
            level: 3 
        }; 

        map = new kakao.maps.Map(mapContainer, mapOption); 

        if (!kakao.maps.services) {
            console.error('Kakao Maps services library not loaded');
            return;
        }

        ps = new kakao.maps.services.Places(); 
    }

    // 검색 버튼 클릭 이벤트 핸들러
    searchButton.onclick = function() {
        var buildingName = document.getElementById('buildingName').value;
        console.log('Searching for:', buildingName);
        ps.keywordSearch(buildingName, placesSearchCB);
    };

    function placesSearchCB(data, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {
            console.log('Search successful:', data);
            var resultsList = document.getElementById('results');
            resultsList.innerHTML = '';
            data.forEach(function(place) {
                var li = document.createElement('li');
                console.log('li successful:', li);
                li.textContent = place.place_name;
                li.onclick = function() {
                    map.setCenter(new kakao.maps.LatLng(place.y, place.x));
                    displayMarker(place);
                    // 모달창 닫기
                    modal.style.display = "none";
                };
                resultsList.appendChild(li);
            });
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
    }
});
</script>

<!-- 모달 HTML -->
<div id="mapModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <input type="text" id="buildingName" placeholder="Enter building name">
        <button id="searchButton">Search</button>
        <div id="map"></div>
        <ul id="results"></ul>
    </div>
</div>

<!-- 모달 열기 버튼 -->
<button id="arrive_zipcodeSearch">Open Modal</button>
