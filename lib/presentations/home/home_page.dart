import 'package:flutter/material.dart';
import 'package:flutter_app_sale_02022023/common/bases/base_widget.dart';
import 'package:flutter_app_sale_02022023/common/constants/app_constant.dart';
import 'package:flutter_app_sale_02022023/common/widgets/loading_widget.dart';
import 'package:flutter_app_sale_02022023/data/datasources/models/product_model.dart';
import 'package:flutter_app_sale_02022023/data/datasources/remote/api_request.dart';
import 'package:flutter_app_sale_02022023/data/datasources/repositories/product_repository.dart';
import 'package:flutter_app_sale_02022023/presentations/home/bloc/home_bloc.dart';
import 'package:flutter_app_sale_02022023/presentations/home/bloc/home_event.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      appBar: AppBar(
        title: Text("Products"),
      ),
      providers: [
        Provider(create: (context) => ApiRequest()),
        ProxyProvider<ApiRequest, ProductRepository>(
          create: (context) => ProductRepository(),
          update: (_, request, repository) {
            repository ??= ProductRepository();
            repository.setApiRequest(request);
            return repository;
          },
        ),
        ProxyProvider<ProductRepository, HomeBloc>(
          create: (context) => HomeBloc(),
          update: (_, repository, bloc) {
            bloc ??= HomeBloc();
            bloc.setProductRepo(repository);
            return bloc;
          },
        )
      ],
      child: HomePageContainer(),
    );
  }
}

class HomePageContainer extends StatefulWidget {
  @override
  State<HomePageContainer> createState() => _HomePageContainerState();
}

class _HomePageContainerState extends State<HomePageContainer> {
  late HomeBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read();
    _bloc.eventSink.add(FetchProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      bloc: _bloc,
      child: SafeArea(
          child: Container(
            child: Stack(
              children: [
                StreamBuilder<List<Product>>(
                    initialData: const [],
                    stream: _bloc.listProductsStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError || snapshot.data?.isEmpty == true) {
                        return Container(
                          child: Center(child: Text("Data empty")),
                        );
                      }
                      return ListView.builder(
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return _buildItemFood(snapshot.data?[index]);
                          }
                      );
                    }
                ),
              ],
            ),
          )
      ),
    );
  }

  Widget _buildItemFood(Product? product) {
    if (product == null) return Container();
    return SizedBox(
      height: 135,
      child: Card(
        elevation: 5,
        shadowColor: Colors.blueGrey,
        child: Container(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(AppConstant.BASE_URL + product.imageUrl,
                    width: 150, height: 120, fit: BoxFit.fill),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(product.name.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16)),
                      ),
                      Text(
                          "Giá : ${NumberFormat("#,###", "en_US")
                              .format(product.price)} đ",
                          style: const TextStyle(fontSize: 12)),
                      Row(
                          children:[
                            ElevatedButton(
                              onPressed: () {

                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.resolveWith((states) {
                                    if (states.contains(MaterialState.pressed)) {
                                      return const Color.fromARGB(200, 240, 102, 61);
                                    } else {
                                      return const Color.fromARGB(230, 240, 102, 61);
                                    }
                                  }),
                                  shape: MaterialStateProperty.all(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))))),
                              child:
                              const Text("Thêm vào giỏ", style: TextStyle(fontSize: 14)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: ElevatedButton(
                                onPressed: () {
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.resolveWith((states) {
                                      if (states.contains(MaterialState.pressed)) {
                                        return const Color.fromARGB(200, 11, 22, 142);
                                      } else {
                                        return const Color.fromARGB(230, 11, 22, 142);
                                      }
                                    }),
                                    shape: MaterialStateProperty.all(
                                        const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))))),
                                child:
                                Text("Chi tiết", style: const TextStyle(fontSize: 14)),
                              ),
                            ),
                          ]
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
