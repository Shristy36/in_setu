import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_setu/commonWidget/no_data_found.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/constants/strings.dart';
import 'package:in_setu/networkSupport/ErrorHandler.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/cash_details_view/delete_dialog/delete_dailog_view.dart';
import 'package:in_setu/supports/LoadingDialog.dart';
import 'package:in_setu/supports/utility.dart';
import 'package:in_setu/screens/cash_details_view/bloc/cashbook_bloc.dart';
import 'package:in_setu/screens/cash_details_view/model/CashbookDetailResponse.dart';

class AddCashbookWidget extends StatefulWidget {
  final dynamic siteId;
  final Function(bool) isUpdateValue;

  const AddCashbookWidget({
    super.key,
    required this.siteId,
    required this.isUpdateValue,
  });

  @override
  State<AddCashbookWidget> createState() => _AddCashbookWidgetState();
}

class _AddCashbookWidgetState extends State<AddCashbookWidget> {
  bool isOnlyListRefresh = true;

  @override
  void initState() {
    super.initState();
    _fetchCashbooks();
  }

  void _fetchCashbooks() {
    context.read<CashbookBloc>().add(CashbookFetchEvent(widget.siteId));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.65,
            maxWidth: MediaQuery.of(context).size.width * 0.95,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              Expanded(
                child: BlocConsumer<CashbookBloc, GlobalApiResponseState>(
                  listener: (context, state) {
                    if (state.status == GlobalApiStatus.error) {
                      Navigator.of(context).pop();
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ErrorHandler.errorHandle(
                          state.message ?? "An error occurred",
                          "Error",
                          context,
                        );
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state.status == GlobalApiStatus.loading && state.data == null) {
                      return isOnlyListRefresh ? Utility.getLoadingView(context) : SizedBox.shrink();
                    }
                    if (state.status == GlobalApiStatus.completed &&
                        state is CashbookStateSuccess &&
                        state.data != null) {
                      return _buildCashbookList(state.data!.data ?? []);
                    } else if (state is SetDefaultCashBookStateSuccess) {
                      widget.isUpdateValue(true);
                      Navigator.of(context).pop();
                    }
                    // Empty state or error state with no data
                    return _buildEmptyState();
                  },
                ),
              ),
              _buildAddButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return BlocBuilder<CashbookBloc, GlobalApiResponseState>(
      builder: (context, state) {
        final itemCount = state is CashbookStateSuccess
            ? (state.data?.data?.length ?? 0)
            : 0;
        return Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    itemCount == 0
                        ? 'You Do not have any cashbook'
                        : 'Select Cash Book',
                    style: const TextStyle(
                      color: AppColors.colorBlack,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.close, color: AppColors.colorBlack, size: 20),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCashbookList(List<Data> cashBooks) {
    return cashBooks.isEmpty? NoDataFound(noDataFoundTxt: "No Cashbook Found"): ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: cashBooks.length,
      itemBuilder: (context, index) {
        final cashBook = cashBooks[index];
        return Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: (){
              _setAsDefault(cashBook, cashBooks);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.colorGray, width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _setAsDefault(cashBook, cashBooks);
                          },
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color:
                                    cashBook.isDefault == 1
                                        ? AppColors.primary
                                        : Colors.grey,
                                width: 2,
                              ),
                            ),
                            child:
                                cashBook.isDefault == 1
                                    ? const Icon(
                                      Icons.check,
                                      size: 16,
                                      color: AppColors.primary,
                                    )
                                    : null,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          cashBook.cashbookName ?? 'Unnamed',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                         GestureDetector(
                           onTap: () => _editCashBook(context, cashBook),
                           child: Image.asset("assets/icons/edit.png", width: 15, height: 15, color: AppColors.primary,)),
                         Padding(
                           padding: const EdgeInsets.only(left: 15.0, right: 5),
                           child: GestureDetector(
                             onTap: () => _deleteCashBook(context, cashBook),
                             child: Icon(Icons.delete, size: 18, color: Colors.red,),
                           ),
                         ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/icons/empty.png", width: 40, height: 40),
          const Text(
            "No cash books added yet",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          minimumSize: const Size(200, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () => _showCreateCashbookDialog(),
        child: const Text(
          "Add new cash book",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  void _setAsDefault(Data cashBook, List<Data> cashBooks) {
    isOnlyListRefresh = false;
    context.read<CashbookBloc>().add(
      SetDefaultCashBookEvent(
        cashBookId: cashBook.id,
        cashBookName: cashBook.cashbookName!,
        userId: cashBook.userId,
        siteId: cashBook.siteId,
        isDefault: cashBook.isDefault,
        clicked: true,
      ),
    );
  }

  Future<void> _deleteCashBook(BuildContext context, Data cashBook) async {
    final delete = await DeleteCashBookDialog.showDeleteCashBookDialog(
      context,
      siteDeleteMsg,
      siteDeleteTitle,
      cashBook.id,
    );

    if (delete == true) {
      _fetchCashbooks();
    }
  }

  void _editCashBook(BuildContext context, Data cashBook) {
    final TextEditingController nameController = TextEditingController(
      text: cashBook.cashbookName ?? '',
    );

    showDialog(
      context: context,
      builder:
          (context) => BlocProvider.value(
            value: BlocProvider.of<CashbookBloc>(context),
            child: BlocListener<CashbookBloc, GlobalApiResponseState>(
              listener: (context, state) {
                if (state.status == GlobalApiStatus.loading) {
                } else if (state.status == GlobalApiStatus.completed) {
                  if (state is UpdateCashBookStateSuccess) {
                    Utility.showToast(state.data.message);
                    _fetchCashbooks(); // Refresh the list
                    Navigator.of(context).pop(); // Close the dialog
                  }
                } else if (state.status == GlobalApiStatus.error) {
                  ErrorHandler.errorHandle(
                    state.message ?? "Update failed",
                    "Error",
                    context,
                  );
                }
              },
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), // 5 px corner radius
                ),
                backgroundColor: Colors.white,
                title: const Text('Edit Cash Book', style: TextStyle(color: AppColors.colorBlack, fontSize: 16),),
                content: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  BlocBuilder<CashbookBloc, GlobalApiResponseState>(
                    builder: (context, state) {
                      return TextButton(
                        onPressed:
                            state.status == GlobalApiStatus.loading
                                ? null
                                : () {
                                  context.read<CashbookBloc>().add(
                                    UpdateCashBookEvent(
                                      cashBookId: cashBook.id,
                                      siteId: cashBook.siteId,
                                      cashBookName: nameController.text,
                                    ),
                                  );
                                  isOnlyListRefresh = false;
                                },
                        child:
                            state.status == GlobalApiStatus.loading
                                ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                                : const Text('Update'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void _showCreateCashbookDialog() {
    showDialog(
      context: context,
      builder:
          (context) => CreateCashBook(
            siteId: widget.siteId,
            cashBookUpdate: _fetchCashbooks,
          ),
    );
  }
}

class CreateCashBook extends StatefulWidget {
  final dynamic siteId;
  final VoidCallback cashBookUpdate;

  const CreateCashBook({
    super.key,
    required this.siteId,
    required this.cashBookUpdate,
  });

  @override
  State<CreateCashBook> createState() => _CreateCashBookState();
}

class _CreateCashBookState extends State<CreateCashBook> {
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isClickButton = true;
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: BlocListener<CashbookBloc, GlobalApiResponseState>(
        listener: (context, state) {
          switch (state.status) {
            case GlobalApiStatus.loading:
              // LoadingDialog.show(context, key: const ObjectKey("requesting sign in.."));
              break;
            case GlobalApiStatus.completed:
              LoadingDialog.hide(context);
              if (state is CashBookCreateStateSuccess) {
                Utility.showToast(state.data.message);
                widget.cashBookUpdate();
                Navigator.of(context).pop();
                setState(() {
                  isClickButton = true;
                });
              }
              break;
            case GlobalApiStatus.error:
              LoadingDialog.hide(context);
              ErrorHandler.errorHandle(
                state.message ?? "Something went wrong",
                "Error",
                context,
              );
              setState(() {
                isClickButton = true;
              });
              break;
            default:
              setState(() {
                isClickButton = true;
              });
              LoadingDialog.hide(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                top: 20,
              ),
              child: Container(
                margin: const EdgeInsets.all(20),
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.85,
                  maxWidth: MediaQuery.of(context).size.width * 0.95,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "Please specify the name",
                                  style: TextStyle(fontSize: 14, color: Colors.black),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 10,
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                                controller: _nameController,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  labelText: 'Name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: AppColors.primary),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: AppColors.primary,
                                      width: 2,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            minimumSize: const Size(120, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: _handleCreateCashbook,
                          child: const Text(
                            "Add",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20),
          child: const Expanded(
            child: Text(
              'Create Cashbook',
              style: TextStyle(
                color: AppColors.colorBlack,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0, right: 20),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.close, color: AppColors.colorBlack, size: 20),
            ),
          ),
        ),
      ],
    );
  }

  void _handleCreateCashbook() {
    if (_formKey.currentState!.validate()) {
      if (isClickButton) {
        setState(() {
          isClickButton = false;
        });
        context.read<CashbookBloc>().add(
          CashBookCreateEvent(widget.siteId, _nameController.text),
        );
      }
    }
  }
}
