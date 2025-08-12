/*
// add_contact_widget.dart
import 'package:contacts_service_plus/contacts_service_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/networkSupport/ErrorHandler.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/home_page/bloc/home_bloc.dart';
import 'package:in_setu/supports/utility.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../project_list/model/AllSitesResponse.dart';

class AddContactWidget extends StatefulWidget {
  final Data siteObj;
  final Function(bool) onContactSelected;

  const AddContactWidget({
    Key? key,
    required this.siteObj,
    required this.onContactSelected,
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

  final List<Color> backgroundColors = [
    Color(0xFFb2ae92),
    Color(0xFF5a9e42),
    Color(0xFF567cd9),
    Color(0xFFf5a623),
    Color(0xFF50e3c2),
    Color(0xFF9013fe),
  ];

  List<Map<String, dynamic>> _prepareSelectedContactsForApi() {
    return selectedContacts.map((contact) {
      final name = contact.displayName ?? '';
      final contactNo = contact.phones?.first.value?.replaceAll(' ', '') ?? '';
      final conShort = getConShort(name);
      final bgColor = backgroundColors[selectedContacts.indexOf(contact) % backgroundColors.length];
      final hexColor = '#${bgColor.value.toRadixString(16).substring(2)}';

      return {
        "name": name,
        "contact": contactNo,
        "con_short": conShort,
        "con_style":
        "display: flex;justify-content: center;align-items: center; border-radius: 50px; color: white; font-size: 20px; font-weight: bold; background:$hexColor; height:75%; width:75%; ",
        "isAdmin": false,
      };
    }).toList();
  }

  @override
  void initState() {
    super.initState();
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
      child: BlocListener<HomeBloc, GlobalApiResponseState>(
        listener: (context, state) {
          switch (state.status) {
            case GlobalApiStatus.completed:
              if (state is AddMemberStateSuccess) {
                widget.onContactSelected(true);
                Navigator.of(context).pop();
              }
              break;
            case GlobalApiStatus.error:
              ErrorHandler.errorHandle(state.message, "Invalid Auth", context);
              break;
            default:
          }
        },
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
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: 10,
                ),
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
                        border: Border.all(
                          color: AppColors.colorGray,
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Search contacts...',
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey[500],
                          ),
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
                            final bgColor =
                                backgroundColors[index %
                                    backgroundColors.length];
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
                                    CircleAvatar(
                                      backgroundColor: bgColor,
                                      child: Text(
                                        contact.displayName!
                                            .split(' ')
                                            .map((e) => e[0])
                                            .take(1)
                                            .join(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.colorWhite,
                                        ),
                                      ),
                                    ),
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
                                          if (contact.phones?.isNotEmpty ??
                                              false)
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
                                          (_) =>
                                              _toggleContactSelection(contact),
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
                      onTap: () {
                        final siteMembers = _prepareSelectedContactsForApi();
                        if (siteMembers.isNotEmpty) {
                          context.read<HomeBloc>().add(AddMemberEvent(siteId: widget.siteObj.id, siteMembers: siteMembers));
                        } else {
                          Utility.showToast("Please select at least one contact");
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: AppColors.primary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              "Add Members",
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.colorWhite,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
      ),
    );
  }
}

*/


import 'dart:convert';
import 'package:contacts_service_plus/contacts_service_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/networkSupport/ErrorHandler.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/home_page/bloc/home_bloc.dart';
import 'package:in_setu/supports/utility.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../project_list/model/AllSitesResponse.dart';

class AddContactWidget extends StatefulWidget {
  final Data siteObj;
  final Function(bool) onContactSelected;

  const AddContactWidget({
    Key? key,
    required this.siteObj,
    required this.onContactSelected,
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
  bool selectAll = false;
  bool isButtonClick = true;

  final List<Color> backgroundColors = [
    Color(0xFFb2ae92),
    Color(0xFF5a9e42),
    Color(0xFF567cd9),
    Color(0xFFf5a623),
    Color(0xFF50e3c2),
    Color(0xFF9013fe),
  ];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final localContacts = await _getContactsFromLocalStorage();

      if (localContacts != null && localContacts.isNotEmpty) {
        setState(() {
          contacts = localContacts;
          isLoading = false;
        });
      } else {
        await _fetchDeviceContacts();
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load contacts: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  Future<List<Contact>?> _getContactsFromLocalStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final contactsJson = prefs.getStringList('contacts');

      if (contactsJson == null || contactsJson.isEmpty) return null;

      return contactsJson.map((json) {
        final contactData = jsonDecode(json);
        return Contact(
          displayName: contactData['displayName'],
          phones: contactData['phones'] != null
              ? (contactData['phones'] as List).map((p) => Item(
            value: p['value'],
            label: p['label'],
          )).toList()
              : null,
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to parse local contacts: $e');
    }
  }

  Future<void> _fetchDeviceContacts() async {
    final status = await Permission.contacts.status;
    if (!status.isGranted) {
      final newStatus = await Permission.contacts.request();
      if (!newStatus.isGranted) {
        throw Exception('Contacts permission denied');
      }
    }

    try {
      final deviceContacts = await ContactsService.getContacts();
      final validContacts = deviceContacts?.where((c) =>
      c.displayName != null &&
          c.phones?.isNotEmpty == true
      ).toList() ?? [];

      await _saveContactsToLocalStorage(validContacts);

      setState(() {
        contacts = validContacts;
        isLoading = false;
      });
    } catch (e) {
      throw Exception('Failed to fetch device contacts: $e');
    }
  }

  Future<void> _saveContactsToLocalStorage(List<Contact> contacts) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final contactsJson = contacts.map((contact) {
        return jsonEncode({
          'displayName': contact.displayName,
          'phones': contact.phones?.map((phone) => {
            'value': phone.value,
            'label': phone.label,
          }).toList(),
        });
      }).toList();

      await prefs.setStringList('contacts', contactsJson);
    } catch (e) {
      throw Exception('Failed to save contacts: $e');
    }
  }

  List<Map<String, dynamic>> _prepareSelectedContactsForApi() {
    return selectedContacts.map((contact) {
      final name = contact.displayName ?? '';
      final contactNo = contact.phones?.first.value?.replaceAll(' ', '') ?? '';
      final conShort = getConShort(name);
      final bgColor = backgroundColors[selectedContacts.indexOf(contact) % backgroundColors.length];
      final hexColor = '#${bgColor.value.toRadixString(16).substring(2)}';

      return {
        "name": name,
        "contact": contactNo,
        "con_short": conShort,
        "con_style":
        "display: flex;justify-content: center;align-items: center; border-radius: 50px; color: white; font-size: 20px; font-weight: bold; background:$hexColor; height:75%; width:75%; ",
        "isAdmin": false,
      };
    }).toList();
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

      selectAll = selectedContacts.length == contacts.length;
    });
  }


  bool _isContactSelected(Contact contact) {
    return selectedContacts.contains(contact);
  }

  String getConShort(String name) {
    return name.split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join();
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
      child: BlocListener<HomeBloc, GlobalApiResponseState>(
        listener: (context, state) {
          switch (state.status) {
            case GlobalApiStatus.completed:
              if (state is AddMemberStateSuccess) {
                widget.onContactSelected(true);
                Navigator.of(context).pop();
                setState(() {
                  isButtonClick = true;
                });
              }
              break;
            case GlobalApiStatus.error:
              ErrorHandler.errorHandle(state.message, "Invalid Auth", context);
              setState(() {
                isButtonClick = true;
              });
              break;
            default:
          }
        },
        child: Stack(
          children: [
            Column(
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
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                      bottom: 10,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Utility.title("Contacts", AppColors.colorBlack),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.colorGray,
                              width: 1,
                            ),
                          ),
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'Search contacts...',
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey[500],
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                            ),
                            onChanged: (_) => setState(() {}),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: isLoading
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
                        final bgColor = backgroundColors[
                        index % backgroundColors.length];
                        final isSelected = _isContactSelected(contact);

                        return Card(
                          margin:
                          const EdgeInsets.symmetric(vertical: 4),
                          elevation: 0,
                          color: isSelected
                              ? AppColors.primary
                              : Colors.black12,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                SizedBox(width: 5),
                                CircleAvatar(
                                  backgroundColor: bgColor,
                                  child: Text(
                                    getConShort(
                                        contact.displayName ?? ''),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.colorWhite,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        contact.displayName ??
                                            'No name',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: isSelected
                                              ? AppColors.colorWhite
                                              : AppColors.colorBlack,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      if (contact.phones?.isNotEmpty ==
                                          true)
                                        Text(
                                          contact.phones!.first.value ??
                                              '',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: isSelected
                                                ? AppColors.colorWhite
                                                : AppColors
                                                .colorBlack,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Checkbox(
                                  value: isSelected,
                                  onChanged: (_) => _toggleContactSelection(contact),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 20, right: 20, bottom: 10),
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
                          onTap: () {
                            if(isButtonClick){
                              setState(() {
                                isButtonClick = false;
                              });
                              final siteMembers = _prepareSelectedContactsForApi();
                              if (siteMembers.isNotEmpty) {
                                context.read<HomeBloc>().add(AddMemberEvent(
                                    siteId: widget.siteObj.id,
                                    siteMembers: siteMembers));
                              } else {
                                Utility.showToast(
                                    "Please select at least one contact");
                              }
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                              color: AppColors.primary,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                child: Text(
                                  "Add Members",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.colorWhite,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
            if (!isButtonClick)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Processing...",
                            style: TextStyle(
                              color: AppColors.colorBlack,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        )
      ),
    );
  }
}