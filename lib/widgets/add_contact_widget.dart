// add_contact_widget.dart
import 'package:contacts_service_plus/contacts_service_plus.dart';
import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.all(16.0),
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        children: [
          // Header and search
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search contacts...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 10),

          // Selected contacts chips
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

          // Contacts list
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage.isNotEmpty
                ? Center(child: Text(errorMessage))
                : filteredContacts.isEmpty
                ? const Center(child: Text('No contacts found'))
                : ListView.builder(
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = filteredContacts[index];
                final isSelected = _isContactSelected(contact);

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  color: isSelected
                      ? Colors.blue.withOpacity(0.1)
                      : null,
                  child: InkWell(
                    onTap: () => _toggleContactSelection(contact),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isSelected,
                            onChanged: (_) => _toggleContactSelection(contact),
                          ),
                          const Icon(Icons.person, size: 30),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  contact.displayName ?? 'No name',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (contact.phones?.isNotEmpty ?? false)
                                  Text(
                                    contact.phones!.first.value ?? '',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onContactsSelected(selectedContacts);
                    Navigator.pop(context);
                  },
                  child: const Text('Add Members'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}