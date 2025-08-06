import 'package:contacts_service_plus/contacts_service_plus.dart';
import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/supports/utility.dart';
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
                        return GestureDetector(
                          onTap: (){
                            _showContactDetails(context, contact, index);
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          child: Icon(Icons.person),
                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(contact.displayName ?? 'No name',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(height: 2,),
                                            Text(
                                              contact.phones?.isNotEmpty ?? false
                                                  ? contact.phones!.first.value ?? ''
                                                  : 'No phone number',
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.black,
                                      size: 15,
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
      backgroundColor: AppColors.colorWhite,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               Container(
                 width: double.infinity,
                 decoration: BoxDecoration(
                   color: Colors.black12,
                   borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))
                 ),
                 child: Padding(
                   padding: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 20.0, top: 10.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                        Utility.subTitle("Add User", AppColors.colorBlack),
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10, top: 5, bottom: 5),
                            child: Utility.subTitle("Close", AppColors.colorBlack),
                          ),
                        )
                     ],
                   ),
                 ),
               ),
              if (contact.phones?.isNotEmpty ?? false)
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 25, right: 30, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15,),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Utility.subTitle(contact.displayName ?? 'No name', AppColors.colorBlack),
                                    Utility.smlText(contact.phones!.first.value ?? '', AppColors.colorGray),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  "shreeji skyrise",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            /* ListTile(
                        leading: const Icon(Icons.phone),
                        title: Text(contact.phones!.first.value ?? ''),
                        subtitle: Text(contact.phones!.first.label ?? ''),
                      ),*/

                          ],
                        ),
                      )
                    ],
                  ),
                ),

              if (contact.emails?.isNotEmpty ?? false)
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 25, right: 30, bottom: 10),
                  child: Column(
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
                ),

              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 25, right: 30, bottom: 10),
                child: SizedBox(
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
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 25, right: 30, bottom: 10),
                child: SizedBox(
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
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 25, right: 30, bottom: 10),
                child: Align(
                  alignment: Alignment.bottomLeft,
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
              ),
              const SizedBox(height: 15),
            ],
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
