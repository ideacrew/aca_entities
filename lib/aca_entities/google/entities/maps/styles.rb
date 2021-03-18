module Google::Maps
  class Styles
    def self.retro
      [
        {
          elementType: 'geometry',
          stylers: [{color: '#ebe3cd'}]
        },
        {
          elementType: 'labels.text.fill',
          stylers: [{color: '#523735'}]
        },
        {
          elementType: 'labels.text.stroke',
          stylers: [{color: '#f5f1e6'}]
        },
        {
          featureType: 'administrative',
          elementType: 'geometry.stroke',
          stylers: [{color: '#c9b2a6'}]
        },
        {
          featureType: 'administrative.land_parcel',
          elementType: 'geometry.stroke',
          stylers: [{color: '#dcd2be'}]
        },
        {
          featureType: 'administrative.land_parcel',
          elementType: 'labels.text.fill',
          stylers: [{color: '#ae9e90'}]
        },
        {
          featureType: 'landscape.natural',
          elementType: 'geometry',
          stylers: [{color: '#dfd2ae'}]
        },
        {
          featureType: 'poi',
          elementType: 'geometry',
          stylers: [{color: '#dfd2ae'}]
        },
        {
          featureType: 'poi',
          elementType: 'labels.text.fill',
          stylers: [{color: '#93817c'}]
        },
        {
          featureType: 'poi.park',
          elementType: 'geometry.fill',
          stylers: [{color: '#a5b076'}]
        },
        {
          featureType: 'poi.park',
          elementType: 'labels.text.fill',
          stylers: [{color: '#447530'}]
        },
        {
          featureType: 'road',
          elementType: 'geometry',
          stylers: [{color: '#f5f1e6'}]
        },
        {
          featureType: 'road.arterial',
          elementType: 'geometry',
          stylers: [{color: '#fdfcf8'}]
        },
        {
          featureType: 'road.highway',
          elementType: 'geometry',
          stylers: [{color: '#f8c967'}]
        },
        {
          featureType: 'road.highway',
          elementType: 'geometry.stroke',
          stylers: [{color: '#e9bc62'}]
        },
        {
          featureType: 'road.highway.controlled_access',
          elementType: 'geometry',
          stylers: [{color: '#e98d58'}]
        },
        {
          featureType: 'road.highway.controlled_access',
          elementType: 'geometry.stroke',
          stylers: [{color: '#db8555'}]
        },
        {
          featureType: 'road.local',
          elementType: 'labels.text.fill',
          stylers: [{color: '#806b63'}]
        },
        {
          featureType: 'transit.line',
          elementType: 'geometry',
          stylers: [{color: '#dfd2ae'}]
        },
        {
          featureType: 'transit.line',
          elementType: 'labels.text.fill',
          stylers: [{color: '#8f7d77'}]
        },
        {
          featureType: 'transit.line',
          elementType: 'labels.text.stroke',
          stylers: [{color: '#ebe3cd'}]
        },
        {
          featureType: 'transit.station',
          elementType: 'geometry',
          stylers: [{color: '#dfd2ae'}]
        },
        {
          featureType: 'water',
          elementType: 'geometry.fill',
          stylers: [{color: '#b9d3c2'}]
        },
        {
          featureType: 'water',
          elementType: 'labels.text.fill',
          stylers: [{color: '#92998d'}]
        }
      ]
    end

    def self.silver
      [
        {
          elementType: 'geometry',
          stylers: [{color: '#f5f5f5'}]
        },
        {
          elementType: 'labels.icon',
          stylers: [{visibility: 'off'}]
        },
        {
          elementType: 'labels.text.fill',
          stylers: [{color: '#616161'}]
        },
        {
          elementType: 'labels.text.stroke',
          stylers: [{color: '#f5f5f5'}]
        },
        {
          featureType: 'administrative.land_parcel',
          elementType: 'labels.text.fill',
          stylers: [{color: '#bdbdbd'}]
        },
        {
          featureType: 'poi',
          elementType: 'geometry',
          stylers: [{color: '#eeeeee'}]
        },
        {
          featureType: 'poi',
          elementType: 'labels.text.fill',
          stylers: [{color: '#757575'}]
        },
        {
          featureType: 'poi.park',
          elementType: 'geometry',
          stylers: [{color: '#e5e5e5'}]
        },
        {
          featureType: 'poi.park',
          elementType: 'labels.text.fill',
          stylers: [{color: '#9e9e9e'}]
        },
        {
          featureType: 'road',
          elementType: 'geometry',
          stylers: [{color: '#ffffff'}]
        },
        {
          featureType: 'road.arterial',
          elementType: 'labels.text.fill',
          stylers: [{color: '#757575'}]
        },
        {
          featureType: 'road.highway',
          elementType: 'geometry',
          stylers: [{color: '#dadada'}]
        },
        {
          featureType: 'road.highway',
          elementType: 'labels.text.fill',
          stylers: [{color: '#616161'}]
        },
        {
          featureType: 'road.local',
          elementType: 'labels.text.fill',
          stylers: [{color: '#9e9e9e'}]
        },
        {
          featureType: 'transit.line',
          elementType: 'geometry',
          stylers: [{color: '#e5e5e5'}]
        },
        {
          featureType: 'transit.station',
          elementType: 'geometry',
          stylers: [{color: '#eeeeee'}]
        },
        {
          featureType: 'water',
          elementType: 'geometry',
          stylers: [{color: '#c9c9c9'}]
        },
        {
          featureType: 'water',
          elementType: 'labels.text.fill',
          stylers: [{color: '#9e9e9e'}]
        }
      ]
    end

    def self.night
      [
        {
          elementType: 'geometry',
          stylers: [{color: '#242f3e'}]
        },
        {
          elementType: 'labels.text.stroke',
          stylers: [{color: '#242f3e'}]
        },
        {
          elementType: 'labels.text.fill',
          stylers: [{color: '#746855'}]
        },
        {
          featureType: 'administrative.locality',
          elementType: 'labels.text.fill',
          stylers: [{color: '#d59563'}]
        },
        {
          featureType: 'poi',
          elementType: 'labels.text.fill',
          stylers: [{color: '#d59563'}]
        },
        {
          featureType: 'poi.park',
          elementType: 'geometry',
          stylers: [{color: '#263c3f'}]
        },
        {
          featureType: 'poi.park',
          elementType: 'labels.text.fill',
          stylers: [{color: '#6b9a76'}]
        },
        {
          featureType: 'road',
          elementType: 'geometry',
          stylers: [{color: '#38414e'}]
        },
        {
          featureType: 'road',
          elementType: 'geometry.stroke',
          stylers: [{color: '#212a37'}]
        },
        {
          featureType: 'road',
          elementType: 'labels.text.fill',
          stylers: [{color: '#9ca5b3'}]
        },
        {
          featureType: 'road.highway',
          elementType: 'geometry',
          stylers: [{color: '#746855'}]
        },
        {
          featureType: 'road.highway',
          elementType: 'geometry.stroke',
          stylers: [{color: '#1f2835'}]
        },
        {
          featureType: 'road.highway',
          elementType: 'labels.text.fill',
          stylers: [{color: '#f3d19c'}]
        },
        {
          featureType: 'transit',
          elementType: 'geometry',
          stylers: [{color: '#2f3948'}]
        },
        {
          featureType: 'transit.station',
          elementType: 'labels.text.fill',
          stylers: [{color: '#d59563'}]
        },
        {
          featureType: 'water',
          elementType: 'geometry',
          stylers: [{color: '#17263c'}]
        },
        {
          featureType: 'water',
          elementType: 'labels.text.fill',
          stylers: [{color: '#515c6d'}]
        },
        {
          featureType: 'water',
          elementType: 'labels.text.stroke',
          stylers: [{color: '#17263c'}]
        }
      ]
    end

    def self.city
      [
        {
          elementType: "labels",
          stylers: [{visibility: "off"}]
        },
        {
          featureType: "administrative",
          elementType: "geometry",
          stylers: [{ visibility: "off" }]
        },
        {
          featureType: "administrative.land_parcel",
          stylers: [{visibility: "off"}]
        },
        {
          featureType: "administrative.neighborhood",
          stylers: [{visibility: "off"}]
        },
        {
          featureType: "poi",
          stylers: [{visibility: "off"}]
        },
        {
          featureType: "poi.school",
          stylers: [{visibility: "on"}]
        },
        {
          featureType: "poi.school",
          elementType: "labels.text.fill",
          stylers: [{color: "#2a5700"}]
        },
        {
          featureType: "road",
          elementType: "geometry",
          stylers: [{visibility: "on"}]
        },
        {
          featureType: "road",
          elementType: "labels.icon",
          stylers: [{visibility: "off"}]
        },
        {
          featureType: "road",
          elementType: "labels.text.fill",
          stylers: [{visibility: "simplified"}]
        },
        {
          featureType: "road",
          elementType: "labels.text.stroke",
          stylers: [{visibility: "off"}]
        },
        {
          featureType: "road.arterial",
          stylers: [{visibility: "simplified"}]
        },
        {
          featureType: "road.arterial",
          elementType: "geometry",
          stylers: [{visibility: "simplified"}]
        },
        {
          featureType: "road.arterial",
          elementType: "labels",
          stylers: [{visibility: "off"}]
        },
        {
          featureType: "road.highway",
          stylers: [{visibility: "off"}]
        },
        {
          featureType: "road.highway",
          elementType: "labels",
          stylers: [{visibility: "off"}]
        },
        {
          featureType: "road.local",
          stylers: [{visibility: "simplified"}]
        },
        {
          featureType: "road.local",
          elementType: "labels.text.fill",
          stylers: [{saturation: -70}, { lightness: 50}, {visibility: "simplified"}, {weight: 1}]
        },
        {
          featureType: "road.local",
          elementType: "labels.text.stroke",
          stylers: [{color: "#7b6edd"}]
        },
        {
          featureType: "transit",
          stylers: [{visibility: "off"}]
        },
        {
          featureType: "transit.line",
          stylers: [{color: "#5c8136"}, {visibility: "off"}]
        },
        {
          featureType: "transit.station.bus",
          stylers: [{color: "#57ad00"}, {visibility: "on"}]
        },
        {
          featureType: "transit.station.bus",
          elementType: "labels",
          stylers: [{visibility: "on"}]
        },
        {
          featureType: "transit.station.rail",
          stylers: [{color: "#1257a1"}, {visibility: "on"}]
        },
        {
          featureType: "transit.station.rail",
          elementType: "labels.text.fill",
          stylers: [{color: "#060033"}]
        },
        {
          featureType: "transit.station.rail",
          elementType: "labels.text.stroke",
          stylers: [{visibility: "off"}]
        }
      ]
    end

    def self.default
      [
        {
          featureType: "administrative",
          elementType: "labels.text.fill",
          stylers: [{color: "#444444"}]
        },
        {
          featureType: "landscape",
          elementType: "all",
          stylers: [{color: "#f2f2f2"}]
        },
        {
          featureType: "poi",
          elementType: "all",
          stylers: [{visibility: "off"}]
        },
        {
          featureType: "poi.park",
          elementType: "all",
          stylers: [{visibility: "on"}, {color: "#bcd9c3"}]
        },
        {
          featureType: "road",
          elementType: "all",
          stylers: [{saturation: -100}, {lightness: 45}]
        },
        {
          featureType: "road.highway",
          elementType: "all",
          stylers: [{visibility: "simplified"}]
        },
        {
          featureType: "road.arterial",
          elementType: "labels.icon",
          stylers: [{visibility: "off"}]
        },
        {
          featureType: "transit",
          elementType: "all",
          stylers: [{visibility: "off"}]
        },
        {
          featureType: "transit.station",
          elementType: "all",
          stylers: [{visibility: "off"}, {weight: "0.28"}]
        },
        {
          featureType: "transit.station",
          elementType: "labels.text",
          stylers: [{color: "#555555"}]
        },
        {
          featureType: "transit.station",
          elementType: "labels.icon",
          stylers: [{saturation: "-66"}]
        },
        {
          featureType: "transit.station.rail",
          elementType: "all",
          stylers: [{visibility: "on"}]
        },
        {
          featureType: "water",
          elementType: "all",
          stylers: [{color: "#d5def2"}, {visibility: "on"}]
        },
        {
          featureType: "water",
          elementType: "labels.text.fill",
          stylers: [{color: "#ffffff"}]
        },
        {
          featureType: "water",
          elementType: "labels.text.stroke",
          stylers: [{visibility: "on"}]
        }
      ]
    end

    STYLE = { night: night, silver: silver, retro: retro, city: city, default: default }
  end
end
