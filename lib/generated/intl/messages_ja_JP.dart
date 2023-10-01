// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja_JP locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ja_JP';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add_ingredient_label_text":
            MessageLookupByLibrary.simpleMessage("食材を追加してください"),
        "category_label": MessageLookupByLibrary.simpleMessage("カテゴリ"),
        "category_label_GIFT": MessageLookupByLibrary.simpleMessage("贈り物"),
        "category_label_INGREDIENT": MessageLookupByLibrary.simpleMessage("食材"),
        "category_label_MEAL_PREP":
            MessageLookupByLibrary.simpleMessage("作り置き"),
        "home_menu_button_COST": MessageLookupByLibrary.simpleMessage("食事管理"),
        "home_menu_button_HOME": MessageLookupByLibrary.simpleMessage("ホーム"),
        "home_menu_button_PROFILE":
            MessageLookupByLibrary.simpleMessage("プロフィール"),
        "list_item_label_COST": MessageLookupByLibrary.simpleMessage("価格: "),
        "list_item_label_CREATED":
            MessageLookupByLibrary.simpleMessage("作成日時: "),
        "list_item_label_USAGE": MessageLookupByLibrary.simpleMessage("使用済み: ")
      };
}
