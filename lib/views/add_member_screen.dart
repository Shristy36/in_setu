import 'package:contacts_service_plus/contacts_service_plus.dart';
import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/widgets/add_contact_widget.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({super.key});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  List<Contact> selectedContacts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 90,
            color: AppColors.primary,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 30),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    "Teams",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child:
                selectedContacts.isEmpty
                    ? const Center(
                      child: Text(
                        "No members added yet",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                    : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: selectedContacts.length,
                      itemBuilder: (context, index) {
                        final contact = selectedContacts[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            onTap:
                                () => _showContactDetails(
                                  context,
                                  contact,
                                  index,
                                ),
                            leading: const CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            title: Text(
                              contact.displayName ?? 'No name',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              contact.phones?.isNotEmpty ?? false
                                  ? contact.phones!.first.value ?? ''
                                  : 'No phone number',
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.black,
                              ),
                              onPressed:
                                  () => _showContactDetails(
                                    context,
                                    contact,
                                    index,
                                  ),
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 120.0,
        height: 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onPressed: () => showContactBottomSheet(context),
          backgroundColor: AppColors.primary,
          child: const Text(
            "Add Member",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _showContactDetails(BuildContext context, Contact contact, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.person, size: 40),
                  title: Text(
                    contact.displayName ?? 'No name',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(),

                if (contact.phones?.isNotEmpty ?? false)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.phone),
                        title: Text(contact.phones!.first.value ?? ''),
                        subtitle: Text(contact.phones!.first.label ?? ''),
                      ),
                      Text(
                        "shreeji skyrise",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                if (contact.emails?.isNotEmpty ?? false)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Text(
                          'EMAILS',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                      ...contact.emails!
                          .map(
                            (email) => ListTile(
                              leading: const Icon(Icons.email),
                              title: Text(email.value ?? ''),
                              subtitle: Text(email.label ?? ''),
                            ),
                          )
                          .toList(),
                    ],
                  ),

                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Re -invite",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Make As Admin",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap:
                        () => {
                          setState(() {
                            Navigator.pop(context);
                            selectedContacts.removeAt(index);
                          }),
                        },
                    child: Text(
                      "Remove from team",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                Center(
                  child: GestureDetector(
                    onTap: () => {Navigator.pop(context)},
                    child: Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Center(
                        child: Text(
                          "Close",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }

  void showContactBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AddContactWidget(
          onContactsSelected: (newlySelectedContacts) {
            setState(() {
              // Merge new selections with existing ones
              selectedContacts = newlySelectedContacts;
            });
          },
          preSelectedContacts: selectedContacts,
        );
      },
    );
  }
}
