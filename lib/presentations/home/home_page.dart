import 'package:flutter/material.dart';
import 'package:flutter_app_sale_02022023/common/bases/base_widget.dart';
import 'package:flutter_app_sale_02022023/data/datasources/remote/api_request.dart';
import 'package:flutter_app_sale_02022023/data/datasources/repositories/product_repository.dart';
import 'package:flutter_app_sale_02022023/presentations/home/bloc/home_bloc.dart';
import 'package:flutter_app_sale_02022023/presentations/home/bloc/home_event.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc.listProductsStream.listen((event) {
      print("===============");
      print(event.length);
      print("===============");
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
