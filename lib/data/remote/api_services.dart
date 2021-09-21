import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:suitcore_flutter_getx_base_code/data/remote/wrapper/custom_response.dart';
import 'package:suitcore_flutter_getx_base_code/data/remote/wrapper/fake_login_response.dart';
import 'package:suitcore_flutter_getx_base_code/model/fake_login.dart';
import 'package:suitcore_flutter_getx_base_code/model/login_result.dart';
import 'package:suitcore_flutter_getx_base_code/model/place.dart';
import 'package:suitcore_flutter_getx_base_code/model/products_model.dart';
import 'environment.dart';
import 'interceptor/dio.dart';
import 'wrapper/api_response.dart';

part 'api_services.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  static Future<RestClient> create({
    Map<String, dynamic> headers = const {},
    int connectTimeout = 30000,
    int receiveTimeout = 30000,
  }) async {
    return RestClient(
      await AppDio().getDIO(
          headers: headers,
          connectTimeout: connectTimeout,
          receiveTimeout: receiveTimeout),
      baseUrl: ConfigEnvironments.getEnvironments().toString(),
    );
  }

  @POST("/api/user/login")
  Future<ApiResponse<LoginResult>> login(
      @Query("email") String email, @Query("password") String password);

  @GET("/api/places")
  Future<ApiResponses<Place>> getPlaces(
      @Query("page") int page, @Query("perPage") int perPage);

  @GET("/api/places/{id}")
  Future<ApiResponse<Place>> getPlaceDetail(@Path("id") int id);

  // somehow ga bisa call list of data List<T> ???
  // @GET("/products")
  // Future<ApiResponse<ProductsModel>> getProducts(@Query("limit") int page);

  @GET("/products")
  Future<List<CustomResponse>> getProducts(@Query("limit") int page);

  @POST("/auth/login")
  Future<FakeLoginResponse> loginAuth(@Body() Map<String, dynamic> map);
}

final client = RestClient.create();

//build runner script
//flutter pub run build_runner build
//flutter pub run build_runner build --delete-conflicting-outputs