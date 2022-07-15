class Api {
  static const base = 'https://devapi.cosmicagps.in/';
  static const users = base + 'users';
  static const login = users + '/login';
  static const vehicles = base + 'vehicles';
  static const orgs = base + 'orgs';
  static const trips = base + '';

  ///////    VEHICLE API GETTERS   /////////
  static String editVehicleById(String id){
    return '$vehicles/$id';
  }
  static String getVehicleList(){
    return '$vehicles/list';
  }
  static String addVehicle(){
    return '$vehicles/create';
  }
  static String deleteVehicleById(String id){
    return '$vehicles/delete/$id';
  }

  ///////    ORGANIZATION API GETTERS   /////////
  static String editOrgById(String id){
    return '$orgs/$id';
  }
  static String getOrgList(){
    return '$orgs/list';
  }
  static String addOrg(){
    return '$orgs/create';
  }
  static String deleteOrgById(String id){
    return '$orgs/delete/$id';
  }

  /////////   TRIP API GETTERS   ///////////
   static String editTripById(String id){
    return '$trips/$id';
  }
  static String getTripList(){
    return '$trips/list';
  }
  static String addTrip(){
    return '$trips/create';
  }
  static String deleteTripById(String id){
    return '$trips/delete/$id';
  }
  
}