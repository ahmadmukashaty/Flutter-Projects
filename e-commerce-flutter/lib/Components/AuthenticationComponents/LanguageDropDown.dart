import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/Authentication/Language.dart';
import 'package:oneaddress/Services/Management/LanguageManagement.dart';

class LanguageDropDown extends StatefulWidget {
  final List<Language> languages;
  final Function(Language) onLanguageChange;
  LanguageDropDown({
    this.languages,
    this.onLanguageChange,
  });

  @override
  _LanguageDropDownState createState() => _LanguageDropDownState();
}

class _LanguageDropDownState extends State<LanguageDropDown> {
  List<DropdownMenuItem<Language>> _dropdownMenuItems;
  Language selectedLanguage;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(widget.languages);
    int index = LanguageManagement.getLangIndex();
    selectedLanguage = _dropdownMenuItems[index].value;
    super.initState();
  }

  List<DropdownMenuItem<Language>> buildDropdownMenuItems(List countries) {
    List<DropdownMenuItem<Language>> items = List();
    for (Language lang in widget.languages) {
      items.add(DropdownMenuItem(
        value: lang,
        child: Text(lang.getValue()),
      ));
    }
    return items;
  }

  onChangeDropdownItem(Language lang) {
    setState(() {
      selectedLanguage = lang;
      widget.onLanguageChange(selectedLanguage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.white,
        brightness: Brightness.light,
      ),
      child: DropdownButton(
        isExpanded: true,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
        value: selectedLanguage,
        items: _dropdownMenuItems,
        onChanged: onChangeDropdownItem,
      ),
    );
  }
}
