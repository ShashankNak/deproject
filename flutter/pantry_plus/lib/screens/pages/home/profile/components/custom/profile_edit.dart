import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:pantry_plus/controller/home/profile/profile_controller.dart';
import 'package:pantry_plus/data/model/user_details_model.dart';
import 'package:pantry_plus/screens/pages/home/profile/components/profile_ui_component.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return GetBuilder(
        init: controller,
        builder: (context) {
          return GestureDetector(
            onTap: () => Get.focusScope!.unfocus(),
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: Get.size.height / 3,
                      width: Get.size.width,
                    ),
                    //name
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: Get.size.height / 30,
                              ),

                              Text(
                                !controller.editMode.value
                                    ? "Profile"
                                    : "Profile Edit",
                                style: Get.theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.size.shortestSide / 15),
                              ),
                              const Divider(),
                              SizedBox(
                                height: Get.size.height / 30,
                              ),
                              IgnorePointer(
                                ignoring: !controller.editMode.value,
                                child: TextFormField(
                                    controller: controller.nameEC.value,
                                    style: Get.theme.textTheme.bodyLarge!
                                        .copyWith(
                                            fontSize:
                                                Get.size.shortestSide / 20),
                                    maxLines: 1,
                                    keyboardType: TextInputType.name,
                                    onChanged: (value) {
                                      controller.user.update((val) {
                                        val!.name = value;
                                      });
                                      controller.update();
                                      log(controller.user.value.name);
                                    },
                                    decoration: InputDecoration(
                                        labelText: "Name: ",
                                        labelStyle: Get
                                            .theme.textTheme.bodyLarge!
                                            .copyWith(
                                                fontSize:
                                                    Get.size.shortestSide / 20),
                                        border: !controller.editMode.value
                                            ? const UnderlineInputBorder()
                                            : const OutlineInputBorder(),
                                        hintText: "Enter Name",
                                        contentPadding:
                                            const EdgeInsets.all(10))),
                              ),
                              SizedBox(
                                height: Get.size.height / 30,
                              ),
                              IgnorePointer(
                                ignoring: true,
                                child: TextFormField(
                                    initialValue: controller.user.value.email,
                                    style: Get.theme.textTheme.bodyLarge!
                                        .copyWith(
                                            fontSize:
                                                Get.size.shortestSide / 20),
                                    decoration: InputDecoration(
                                        helperText: !controller.editMode.value
                                            ? null
                                            : "Email cannot be changed",
                                        labelText: "Email: ",
                                        labelStyle: Get
                                            .theme.textTheme.bodyLarge!
                                            .copyWith(
                                                fontSize:
                                                    Get.size.shortestSide / 20),
                                        border: !controller.editMode.value
                                            ? const UnderlineInputBorder()
                                            : const OutlineInputBorder(),
                                        // enabled: false,

                                        contentPadding:
                                            const EdgeInsets.all(10))),
                              ),
                              SizedBox(
                                height: Get.size.height / 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: Get.size.width / 2.5,
                                    child: IgnorePointer(
                                      ignoring: !controller.editMode.value,
                                      child: TextFormField(
                                        controller: controller.dobEC.value,
                                        onChanged: (value) {
                                          controller.user.update((val) {
                                            val!.birthdate = value;
                                          });
                                          log(controller.user.value.birthdate);
                                          controller.update();
                                        },
                                        maxLines: 1,
                                        keyboardType: TextInputType.datetime,
                                        readOnly: true,
                                        style: Get.theme.textTheme.bodyLarge!
                                            .copyWith(
                                                color: Get.theme.colorScheme
                                                    .onBackground,
                                                fontSize:
                                                    Get.size.shortestSide / 20),
                                        decoration: InputDecoration(
                                            suffixIcon:
                                                const Icon(Icons.date_range),
                                            labelText: "BirthDate: ",
                                            labelStyle: Get
                                                .theme.textTheme.bodyLarge!
                                                .copyWith(
                                                    fontSize:
                                                        Get.size.shortestSide /
                                                            20),
                                            border: !controller.editMode.value
                                                ? const UnderlineInputBorder()
                                                : const OutlineInputBorder(),
                                            contentPadding:
                                                const EdgeInsets.all(10)),
                                        onTap: !controller.editMode.value
                                            ? () {}
                                            : () {
                                                controller
                                                    .selectDate(Get.context!);
                                              },
                                      ),
                                    ),
                                  ),

                                  //birthdate
                                  IgnorePointer(
                                    ignoring: !controller.editMode.value,
                                    child: DropdownMenu<Gender>(
                                      width: Get.size.width / 2.5,
                                      hintText: "Select Gender",
                                      textStyle: Get.theme.textTheme.bodyLarge!
                                          .copyWith(
                                              fontSize:
                                                  Get.size.shortestSide / 20),
                                      controller: controller.genderEC.value,
                                      requestFocusOnTap: false,
                                      label: const Text('Select Gender'),
                                      inputDecorationTheme:
                                          InputDecorationTheme(
                                        border: !controller.editMode.value
                                            ? const UnderlineInputBorder()
                                            : const OutlineInputBorder(),
                                      ),
                                      onSelected: (Gender? gender) {
                                        controller.user.update((val) {
                                          val!.gender = gender!;
                                        });
                                      },
                                      dropdownMenuEntries: controller.entries,
                                    ),
                                  ),
                                ],
                              ),

                              //gender
                              SizedBox(
                                height: Get.size.height / 30,
                              ),
                              //height

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: Get.size.width / 2.5,
                                    child: IgnorePointer(
                                      ignoring: !controller.editMode.value,
                                      child: TextFormField(
                                          controller: controller.heightEC.value,
                                          maxLines: 1,
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            controller.user.update((val) {
                                              val!.height = value;
                                            });
                                            log(controller.user.value.height);
                                          },
                                          decoration: InputDecoration(
                                              suffixText: "cm",
                                              labelText: "Height:  ",
                                              labelStyle: Get
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      fontSize: Get.size
                                                              .shortestSide /
                                                          20),
                                              border: !controller.editMode.value
                                                  ? const UnderlineInputBorder()
                                                  : const OutlineInputBorder(),
                                              hintText: "Enter Height",
                                              contentPadding:
                                                  const EdgeInsets.all(10))),
                                    ),
                                  ),

                                  //weight
                                  SizedBox(
                                    width: Get.size.width / 2.5,
                                    child: IgnorePointer(
                                      ignoring: !controller.editMode.value,
                                      child: TextFormField(
                                          controller: controller.weightEC.value,
                                          maxLines: 1,
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            controller.user.update((val) {
                                              val!.weight = value;
                                            });
                                            log(controller.user.value.weight);
                                          },
                                          decoration: InputDecoration(
                                              suffixText: "kg",
                                              labelText: "Weight:  ",
                                              labelStyle: Get
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      fontSize: Get.size
                                                              .shortestSide /
                                                          20),
                                              border: !controller.editMode.value
                                                  ? const UnderlineInputBorder()
                                                  : const OutlineInputBorder(),
                                              hintText: "Enter Weight",
                                              contentPadding:
                                                  const EdgeInsets.all(10))),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Get.size.height / 30,
                              ),

                              IgnorePointer(
                                ignoring: !controller.editMode.value,
                                child: MultiSelectDropDown<int>(
                                  controller: controller.preferences.value,
                                  selectionType: SelectionType.multi,
                                  chipConfig:
                                      const ChipConfig(wrapType: WrapType.wrap),
                                  dropdownHeight: 300,
                                  optionTextStyle:
                                      const TextStyle(fontSize: 16),
                                  selectedOptionIcon:
                                      const Icon(Icons.check_circle),
                                  borderColor:
                                      Get.theme.colorScheme.onBackground,
                                  hint: "Select Preferences",
                                  hintStyle: Get.theme.textTheme.bodyLarge!
                                      .copyWith(
                                          fontSize: Get.size.shortestSide / 20),
                                  hintColor: Get.theme.colorScheme.onBackground,
                                  focusedBorderColor:
                                      Get.theme.colorScheme.primary,
                                  focusedBorderWidth: 2,
                                  borderWidth: 1,
                                  fieldBackgroundColor:
                                      Get.theme.colorScheme.background,
                                  onOptionSelected:
                                      (List<ValueItem<int>> selectedOptions) {},
                                  options: const [],
                                ),
                              ),
                              SizedBox(
                                height: Get.size.height / 10,
                              ),

                              //preferences
                            ],
                          ),
                        ),
                      ),
                    ),

                    //
                  ],
                ),
                const ProfileUIComponent(),
                if (controller.isLoading.value)
                  Container(
                    width: Get.size.width,
                    height: Get.size.height,
                    color: Colors.white24,
                    child: Center(
                      child: LoadingAnimationWidget.threeArchedCircle(
                        color: Colors.black,
                        size: Get.size.shortestSide / 10,
                      ),
                    ),
                  ),
              ],
            ),
          );
        });
  }
}
