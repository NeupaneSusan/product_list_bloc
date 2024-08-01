import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../bloc/event.dart';
import '../bloc/states.dart';
import '../widget/card.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool _isSearchBar = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: StatefulBuilder(builder: (context, innersetStates) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_isSearchBar) ...[
                        Flexible(
                          child: TextField(
                            onSubmitted: (value) {
                              if (value.isNotEmpty) {
                                context
                                    .read<ProductBloc>()
                                    .add(SearchProductsEvent(value));
                              }
                            },
                            onChanged: (value) {
                              if (value.isEmpty) {
                                context
                                    .read<ProductBloc>()
                                    .add(FetchProductsEvent());
                              }
                            },
                            decoration: InputDecoration(
                              hintText: ' Search...',
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                      ] else ...[
                        const SizedBox(
                          width: 100,
                        ),
                        Text(
                          'Product',
                          style: Theme.of(context).textTheme.titleLarge,
                        )
                      ],
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            innersetStates(
                              () {
                                _isSearchBar = !_isSearchBar;
                              },
                            );
                          },
                          child: const Icon(Icons.search)),
                    ],
                  );
                }),
              ),
            ),
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                } else if (state is ProductError) {
                  return Center(child: Text(state.message));
                } else if (state is ProductLoaded) {
                  if (state.products.isEmpty) {
                    return const Center(child: Text('No products available'));
                  }
                  return GridView.builder(
                    padding: const EdgeInsets.all(5),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            mainAxisExtent: 280),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: state.products[index],
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No products available'));
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
