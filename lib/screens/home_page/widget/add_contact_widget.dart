// add_contact_widget.dart
import 'package:contacts_service_plus/contacts_service_plus.dart';
import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/supports/utility.dart';
import 'package:permission_handler/permission_handler.dart';

class AddContactWidget extends StatefulWidget {
  final Function(List<Contact>) onContactsSelected;
  final List<Contact>? preSelectedContacts;

  const AddContactWidget({
    Key? key,
    required this.onContactsSelected,
    this.preSelectedContacts,
  }) : super(key: key);

  @override
  _AddContactWidgetState createState() => _AddContactWidgetState();
}

class _AddContactWidgetState extends State<AddContactWidget> {
  List<Contact> contacts = [];
  List<Contact> selectedContacts = [];
  bool isLoading = true;
  String errorMessage = '';
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.preSelectedContacts != null) {
      selectedContacts.addAll(widget.preSelectedContacts!);
    }
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    var status = await Permission.contacts.status;
    if (!status.isGranted) {
      status = await Permission.contacts.request();
    }

    if (status.isGranted) {
      try {
        final contacts = await ContactsService.getContacts();
        setState(() {
          this.contacts = contacts;
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          errorMessage = 'Failed to fetch contacts: $e';
          isLoading = false;
        });
      }
    } else {
      setState(() {
        errorMessage = 'Contacts permission denied';
        isLoading = false;
      });
    }
  }

  List<Contact> get filteredContacts {
    if (searchController.text.isEmpty) return contacts;
    return contacts.where((contact) {
      return contact.displayName?.toLowerCase().contains(
            searchController.text.toLowerCase(),
          ) ??
          false;
    }).toList();
  }

  void _toggleContactSelection(Contact contact) {
    setState(() {
      if (selectedContacts.contains(contact)) {
        selectedContacts.remove(contact);
      } else {
        selectedContacts.add(contact);
      }
    });
  }

  bool _isContactSelected(Contact contact) {
    return selectedContacts.any((c) => c.identifier == contact.identifier);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Utility.title("Contacts", AppColors.colorBlack),
                  ),
                  const SizedBox(height: 10),
                  // Header and search
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.colorGray, width: 1),
                    ),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search contacts...',
                        prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                        border: InputBorder.none,
                        isDense: true,
                        // Reduces the height for better alignment
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12,
                        ), // Adjust as needed
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  const SizedBox(height: 10),

                  /*
                        if (selectedContacts.isNotEmpty) ...[
              SizedBox(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: selectedContacts.map((contact) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Chip(
                        label: Text(contact.displayName ?? 'No name'),
                        avatar: const Icon(Icons.person, size: 18),
                        onDeleted: () => _toggleContactSelection(contact),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 10),
                        ],
                    */
                ],
              ),
            ),
          ),
          // Contacts list
          Expanded(
            child:
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : errorMessage.isNotEmpty
                    ? Center(child: Text(errorMessage))
                    : filteredContacts.isEmpty
                    ? const Center(child: Text('No contacts found'))
                    : Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: 20,
                        right: 20,
                      ),
                      child: ListView.builder(
                        itemCount: filteredContacts.length,
                        itemBuilder: (context, index) {
                          final contact = filteredContacts[index];
                          final isSelected = _isContactSelected(contact);

                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            elevation: 0,
                            color:
                                isSelected
                                    ? AppColors.primary
                                    : Colors.black12,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  SizedBox(width: 5),
                                  const Icon(Icons.person, size: 30),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          contact.displayName ?? 'No name',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                isSelected
                                                    ? AppColors.colorWhite
                                                    : AppColors.colorBlack,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        if (contact.phones?.isNotEmpty ?? false)
                                          Text(
                                            contact.phones!.first.value ?? '',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  isSelected
                                                      ? AppColors.colorWhite
                                                      : AppColors.colorBlack,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Checkbox(
                                    value: isSelected,
                                    onChanged:
                                        (_) => _toggleContactSelection(contact),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
          ),

          // Action buttons
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      widget.onContactsSelected(selectedContacts);
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: AppColors.primary
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text("Add Members", style: TextStyle(fontSize: 14, color: AppColors.colorWhite, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
