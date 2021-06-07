import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/CountryList/Country.dart';

class CountryDropDown extends StatefulWidget {
  final List<Country> countries;
  final Function(Country) onCountryChange;
  CountryDropDown({
    this.countries,
    this.onCountryChange,
  });

  @override
  _CountryDropDownState createState() => _CountryDropDownState();
}

class _CountryDropDownState extends State<CountryDropDown> {
  List<DropdownMenuItem<Country>> _dropdownMenuItems;
  Country selectedCountry;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(widget.countries);
    selectedCountry = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Country>> buildDropdownMenuItems(List countries) {
    List<DropdownMenuItem<Country>> items = List();
    for (Country country in widget.countries) {
      items.add(DropdownMenuItem(
        value: country,
        child: Text(country.name),
      ));
    }
    return items;
  }

  onChangeDropdownItem(Country country) {
    setState(() {
      selectedCountry = country;
      widget.onCountryChange(selectedCountry);
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
        value: selectedCountry,
        items: _dropdownMenuItems,
        onChanged: onChangeDropdownItem,
      ),
    );
  }
}
