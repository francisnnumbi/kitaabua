import 'package:app_popup_menu/app_popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kitaabua/app/controllers/audio_controller.dart';
import 'package:kitaabua/app/controllers/meanings_controller.dart';
import 'package:kitaabua/app/ui/widgets/subtitle_block.dart';
import 'package:kitaabua/core/configs/utils.dart';

import '../../../../core/configs/sizes.dart';
import '../../../../core/configs/themes.dart';
import '../../../../database/models/meaning.dart';
import '../../../controllers/bookmarks_controller.dart';
import '../../../controllers/members_controller.dart';
import '../../../services/dictionary_service.dart';
import '../../widgets/app_bar_header.dart';
import '../../widgets/meaning_card.dart';

class AddEditPage extends StatelessWidget {
  AddEditPage({super.key}) {
    if (DictionaryService.to.expression.value != null) {
      DictionaryService.to
          .fetchSimilarExpressions(DictionaryService.to.expression.value!.word);
    }
  }

  static const String route = "/expressions/add-edit";
  final _addEditFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            Themes.isDark ? Brightness.light : Brightness.dark,
      ),
    );
    return PopScope(
      onPopInvoked: (value) async {
        Utils.hideKeyboard(context);
        DictionaryService.to.expression.value = null;
        DictionaryService.to.wordEC.text = "";
        AudioController.to.clearRecord();
        //if (kDebugMode) print("onPopInvoked");
      },
      child: Obx(() {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppBarHeader(
                    hasBackButton: true,
                    title: Utils.getCurrentDictionaryTitle(),
                    /*title: DictionaryService.to.expression.value == null
                      ? "New".tr
                      : "Expression".tr,*/
                    titleFontSize: kHeadingFontSize,
                    icon: Icons.save,
                    onPressed: () {
                      if (!_addEditFormKey.currentState!.validate()) {
                        return;
                      }
                      _addEditFormKey.currentState!.save();

                      DictionaryService.to.addExpression(
                          word: DictionaryService.to.wordEC.text);
                    },
                    actions: [
                      /* const InkWell(
                        onTap: null,
                        child: Icon(CupertinoIcons.ellipsis_vertical),
                      ),*/
                      AppPopupMenu(
                        offset: const Offset(0, 25),
                        menuItems: [
                          PopupMenuItem(
                            value: "delete",
                            child: TextButton.icon(
                              onPressed: null,
                              icon: const Icon(Icons.delete),
                              label: Text("Delete".tr),
                            ),
                          ),
                          PopupMenuItem(
                            value: "meanings",
                            child: TextButton.icon(
                              onPressed:
                                  !DictionaryService.to.canManageDictionary()
                                      ? null
                                      : DictionaryService.to.expression.value ==
                                              null
                                          ? null
                                          : () {
                                              MeaningsController.to
                                                  .addMeaningDialog(
                                                expressionId: DictionaryService
                                                    .to.expression.value!.id,
                                                onAdd: () async {
                                                  DictionaryService.to
                                                      .refreshExpressions();
                                                  await DictionaryService
                                                      .to.expression.value!
                                                      .reloadMeanings();
                                                },
                                              );
                                            },
                              icon: const Icon(Icons.menu_book),
                              label: Text("Meanings".tr),
                            ),
                          ),
                        ],
                        child: const Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                  const SizedBox(height: kSizeBoxL),
                  Form(
                    key: _addEditFormKey,
                    child: Column(
                      children: [
                        if (DictionaryService.to.expression.value?.word !=
                            DictionaryService.to.wordEC.text)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(
                                  kBorderRadiusS,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: kPaddingS,
                              ),
                              child: Text(
                                DictionaryService.to.expression.value?.word ??
                                    "",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                  fontWeight: FontWeight.bold,
                                  fontSize: kSubHeadingFontSize,
                                ),
                              ),
                            ),
                          ).marginOnly(bottom: kPaddingM),
                        Obx(() {
                          return TextFormField(
                            controller: DictionaryService.to.wordEC,
                            onChanged: (value) {
                              DictionaryService.to
                                  .fetchSimilarExpressions(value);
                            },

                            validator: (va) {
                              if (va!.isEmpty) {
                                return "Title must not be empty".tr;
                              } else if (DictionaryService.to.wordExists(va)) {
                                return "This word already exists".tr;
                              }
                              return null;
                            },
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.bold,
                              fontSize: kHeadingFontSize,
                            ),
                            readOnly:
                                !DictionaryService.to.canManageDictionary(),
                            maxLines: 2,
                            decoration: InputDecoration(
                              hintText: 'Enter expression'.tr,
                              labelText: 'Expression'.tr,
                              alignLabelWithHint: true,
                              filled: true,
                              fillColor: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.1),
                              floatingLabelStyle: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(kBorderRadiusS),
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(kBorderRadiusS),
                                ),
                              ),
                            ),
                            //autofocus: true,
                            textAlignVertical: TextAlignVertical.top,
                          );
                        }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() {
                              return IconButton(
                                onPressed: DictionaryService
                                                .to.expression.value !=
                                            null &&
                                        !DictionaryService.to.expression.value!
                                            .hasAudio()
                                    ? null
                                    : () {
                                        AudioController.to.playExpressionAudio(
                                            DictionaryService
                                                .to.expression.value!);
                                      },
                                icon: Icon(
                                  Icons.record_voice_over,
                                  color: AudioController.to.isPlaying.value
                                      ? Theme.of(context).colorScheme.error
                                      : null,
                                ),
                              );
                            }),
                            if (MembersController.to.isLoggedIn)
                              Obx(() {
                                return BookmarksController
                                        .to.isBookmarking.value
                                    ? SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error,
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          BookmarksController.to.toggleBookmark(
                                              expression: DictionaryService
                                                  .to.expression.value!);
                                        },
                                        icon: Icon(
                                          Icons.bookmark_add,
                                          color: DictionaryService.to.expression
                                                          .value !=
                                                      null &&
                                                  DictionaryService
                                                      .to
                                                      .expression
                                                      .value!
                                                      .isBookmarked!
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .error
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .onBackground
                                                  .withOpacity(0.3),
                                        ),
                                      );
                              }),
                            if (DictionaryService.to.canManageDictionary() &&
                                DictionaryService.to.expression.value != null)
                              IconButton(
                                  onPressed: () {
                                    recordSoundDialog(context);
                                  },
                                  icon: const Icon(Icons.mic)),
                          ],
                        ),
                        if (DictionaryService.to.canManageDictionary() &&
                            DictionaryService.to.similarExpressions.isNotEmpty)
                          const SizedBox(height: kSizeBoxS),
                        if (DictionaryService.to.canManageDictionary() &&
                            DictionaryService.to.similarExpressions.isNotEmpty)
                          SubtitleBlock(
                            title: "Similar Words".tr,
                            titleFontSize: kSummaryFontSize,
                          ),
                        const SizedBox(height: kSizeBoxS),
                        Obx(() {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Wrap(
                              children: DictionaryService.to
                                  .similarExpressions()
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.all(
                                        2,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          DictionaryService.to.openExpression(
                                              expression: e, off: true);
                                        },
                                        child: Badge(
                                          //     backgroundColor: kSurfaceColor,
                                          //isLabelVisible: false,
                                          label: Text(
                                            e.word,
                                            style: const TextStyle(
                                                //      color: kOnSurfaceColor,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(
                                    growable: false,
                                  ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: kSizeBoxL),
                  SubtitleBlock(
                    title: "Meanings".tr,
                    titleFontSize: kSubHeadingFontSize,
                    icon: Icons.menu_book,
                  ),
                  Expanded(
                    child: Obx(() {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(top: kPaddingS),
                        itemCount: MeaningsController.to.meanings.length,
                        itemBuilder: (context, index) {
                          Meaning meaning =
                              MeaningsController.to.meanings[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: kPaddingS),
                            child: MeaningCard(
                              expressionId:
                                  MeaningsController.to.expression.value!.id,
                              meaning: meaning,
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          /* floatingActionButton: !DictionaryService.to.canManageDictionary()
              ? null
              : DictionaryService.to.expression.value == null
                  ? null
                  : FloatingActionButton(
                      mini: true,
                      tooltip: "Add Meaning".tr,
                      backgroundColor:
                          Theme.of(context).colorScheme.onBackground,
                      foregroundColor: Theme.of(context).colorScheme.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kBorderRadius),
                      ),
                      elevation: 10,
                      onPressed: DictionaryService.to.expression.value == null
                          ? null
                          : () {
                              MeaningsController.to.addMeaningDialog(
                                expressionId:
                                    DictionaryService.to.expression.value!.id,
                                onAdd: () async {
                                  DictionaryService.to.refreshExpressions();
                                  await DictionaryService.to.expression.value!
                                      .reloadMeanings();
                                },
                              );
                            },
                      child: const Icon(
                        Icons.add,
                        size: kSizeBoxXL,
                      ),
                    ),*/
        );
      }),
    );
  }

  void recordSoundDialog(BuildContext context) {
    Get.defaultDialog(
      title: "Record".tr,
      content: Obx(() {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const Icon(Icons.mic),
              const SizedBox(height: kSizeBoxS),
              if (!AudioController.to.isRecording.value)
                Center(child: Text("Press the button to start recording".tr)),
              if (AudioController.to.isRecording.value)
                Center(child: Text("Recording in Progress".tr)),
              const SizedBox(height: kSizeBoxS),
              if (!AudioController.to.isPlaying.value)
                ElevatedButton(
                  onPressed: () {
                    AudioController.to.isRecording.value
                        ? AudioController.to.stopRecording()
                        : AudioController.to.startRecording();
                  },
                  child: AudioController.to.isRecording.value
                      ? Text(
                          "Stop".tr,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.error),
                        )
                      : Text(
                          "Start".tr,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                ),
              if (!AudioController.to.isRecording.value &&
                  AudioController.to.recordPath.value.isNotEmpty)
                ElevatedButton(
                  onPressed: () {
                    AudioController.to.isPlaying.value
                        ? AudioController.to.stopPlaying()
                        : AudioController.to.playRecording();
                  },
                  child: AudioController.to.isPlaying.value
                      ? Text(
                          "Stop".tr,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.error),
                        )
                      : Text(
                          "Play".tr,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                ),
            ],
          ),
        );
      }),
      textConfirm: "Save".tr,
      textCancel: "Cancel".tr,
      confirmTextColor: Theme.of(context).colorScheme.onSecondary,
      cancelTextColor: Theme.of(context).colorScheme.onSecondary,
      onConfirm: AudioController.to.isRecording.value
          ? null
          : () {
              AudioController.to.saveRecordToExpression(
                  DictionaryService.to.expression.value!);
            },
      onCancel: () {
        AudioController.to.stopRecording();
        AudioController.to.stopPlaying();
        AudioController.to.clearRecord();
      },
    );
  }
}
