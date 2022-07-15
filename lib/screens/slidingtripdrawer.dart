import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_mng_app/widgets/panelwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:location/location.dart';
import 'dart:ui' as ui;

// ignore: must_be_immutable
class SlidingDrawer extends StatefulWidget {
  bool isOpen;
  SlidingDrawer({Key? key, required this.isOpen}) : super(key: key);
  @override
  _SlidingDrawerState createState() => _SlidingDrawerState();
}

class _SlidingDrawerState extends State<SlidingDrawer> {
  
  //sliding panel essentials
  String drawerdata = 'Explore';
  static const double fabHeightClosed = 116.0;
  double fabHeight = fabHeightClosed;
  PanelController panelController = PanelController();

  //for clustering
  late ClusterManager _manager;

  //for google maps
  LatLng _initialcameraposition = const LatLng(18.5204, 73.8567);
  Completer<GoogleMapController> controller = Completer();
  GoogleMapController? mapController;

  //for current position
  late LocationData currentPosition;
  Location location = Location();

  //For markers
  Uint8List customMarker = Uint8List(5);
  late BitmapDescriptor customIcon;
  Set<Marker> markers = Set();
  Set<Circle> circles = Set();

  List<Place> places = [
    Place(
      name: 'Test1',
      latLng: const LatLng(18.5303, 73.9017),
    ),
    Place(
      name: 'Test2',
      latLng: const LatLng(18.5308, 73.9037),
    ),
    Place(
      name: 'Test3',
      latLng: const LatLng(18.5313, 73.9027),
    ),
    Place(
      name: 'Test4',
      latLng: const LatLng(18.5318, 73.9047),
    ),
    Place(
      name: 'Test5',
      latLng: const LatLng(18.5323, 73.9057),
    ),
  ];

//for custom icon
  @override
  void initState() {
    //initialize cluster manager
    _manager = _initClusterManager();
    super.initState();
  }

  ClusterManager _initClusterManager() {
    return ClusterManager<Place>(places, _updateMarkers,
        markerBuilder: _markerBuilder,
        levels: [
          1,
          3.25,
          6.75,
          8.25,
          11.5,
          14.5,
          16.0,
          16.5,
          20.0
        ], // Optional : Configure this if you want to change zoom levels at which the clustering precision change
        extraPercent:
            0.2, // Optional : This number represents the percentage (0.2 for 20%) of latitude and longitude (in each direction) to be considered on top of the visible map bounds to render clusters. This way, clusters don't "pop out" when you cross the map.
        stopClusteringZoom:
            17.0); // Optional : The zoom level to stop clustering, so it's only rendering single item "clusters");
  }

  void _updateMarkers(Set<Marker> markers) {
    print('Updated ${markers.length} markers');
    setState(() {
      this.markers = markers;
    });
  }

  //future method to load custom icon as marker from assets
  Future<BitmapDescriptor> getBytesFromAsset(String path, int width, int size,
      {String? text, String? markerID}) async {
    //creating icon for cars and associate a text label with it
    //creating a canvas with two objects, text label paint and car icon
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    final ui.PictureRecorder pictureRec = ui.PictureRecorder();
    final Canvas canva = Canvas(pictureRec);
    final Paint paint = Paint()..color = Colors.white;
    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: markerID,
      style: TextStyle(
          fontSize: size / 3,
          color: Colors.indigo,
          fontWeight: FontWeight.bold),
    );
    painter.layout();
    painter.paint(
      canva,
      Offset(size / 2.2, size / 4),
    );
    canva.drawImage(fi.image, Offset(size / 1, size / 1.5), paint);
    ui.Picture p = pictureRec.endRecording();
    ByteData data1 = await (await p.toImage(
            painter.width.toInt() + 40, painter.height.toInt() + 120))
        .toByteData(format: ui.ImageByteFormat.png) as ByteData;

    //creating a cluster icon for displaying car count in cluster
    if (kIsWeb) size = (size / 2).floor();
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Colors.orange;
    final Paint paint2 = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);
    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3,
            color: Colors.white,
            fontWeight: FontWeight.normal),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final datacluster =
        await img.toByteData(format: ui.ImageByteFormat.png) as ByteData;
    final imgcluster = data1;

    if (text != null) {
      return BitmapDescriptor.fromBytes(datacluster.buffer.asUint8List());
    } else {
      return BitmapDescriptor.fromBytes(imgcluster.buffer.asUint8List());
    }
  }

  //this method is called in google map widget that takes onmapcreated future function as argument
  void _onMapCreated(GoogleMapController _cntlr) async {
    //customMarker = await getBytesFromAsset('lib/icons/icon_car.png', 120);  //load custom markerimage
    controller.complete(_cntlr);
    await getLoc(); //get device currentlocation access and get current latlngs
    mapController = _cntlr;
    _manager.setMapId(_cntlr.mapId);
    //set initial camera position to current location on map created
    location.onLocationChanged.listen((l) {
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target:
                LatLng(currentPosition.latitude!, currentPosition.longitude!),
            zoom: 15),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var panelState = widget.isOpen;
    print('panelState: $panelState');
    final panelHeightOpen = MediaQuery.of(context).size.height * 1;
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.1;

    return Scaffold(
        body: Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        SlidingUpPanel(
          controller: panelController,
          minHeight: panelHeightClosed,
          maxHeight: panelHeightOpen,
          parallaxEnabled: true,
          parallaxOffset: 0.7,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _initialcameraposition, zoom: 11),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              compassEnabled: true,
              onCameraMove: _manager.onCameraMove,
              onCameraIdle: _manager.updateMap,
              markers: markers,
              //implement below functions to create and delete markers on tap and on long pressed
              // onTap: handleTap,
              // onLongPress: removeMarkers,
            ),
          ),
          defaultPanelState:
              (widget.isOpen) ? PanelState.OPEN : PanelState.CLOSED,
          onPanelSlide: (position) => setState(() {
            final panelMaxScrollExtent = panelHeightOpen - panelHeightClosed;
            fabHeight = position * panelMaxScrollExtent + fabHeightClosed;
          }),
          panelBuilder: (controller) => PanelWidget(
            controller: controller,
            panelController: panelController,
            data: drawerdata,
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
        ),
      ],
    ));
  }

  Future<Marker> Function(Cluster<Place>) get _markerBuilder =>
      (cluster) async {
        return Marker(
            markerId: MarkerId(cluster.getId()),
            position: cluster.location,
            onTap: () {
              mapController!.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: cluster.location, zoom: 15.5)));
              setState(() {
                drawerdata = places[0].latLng.toString();
              });
              panelController.animatePanelToPosition(0.35,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut);
              print('---- $cluster');
              for (var p in cluster.items) {
                print(p);
              }
            },
            //uncomment to use marker rotation
            //rotation: currentPosition.heading!,
            icon: await getBytesFromAsset(
                'lib/icons/icon_car.png', 120, cluster.isMultiple ? 125 : 75,
                text: cluster.isMultiple ? cluster.count.toString() : null, markerID: cluster.getId()),
            infoWindow: InfoWindow(
                title: "${cluster.location}",
                onTap: () {},
                snippet: "${cluster.getId()}"));
      };

//to get current location along with GPS device permission
  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    currentPosition = await location.getLocation();
    _initialcameraposition =
        LatLng(currentPosition.latitude!, currentPosition.longitude!);
    location.onLocationChanged.listen((LocationData currentLocation) {
      print("${currentLocation.longitude} : ${currentLocation.longitude}");
      currentPosition = currentLocation;
      _initialcameraposition =
          LatLng(currentPosition.latitude!, currentPosition.longitude!);
    });
  }
}

//Place class to create a place
class Place with ClusterItem {
  final String name;
  LatLng latLng;

  Place({required this.name, required this.latLng});
  @override
  LatLng get location => latLng;
}
