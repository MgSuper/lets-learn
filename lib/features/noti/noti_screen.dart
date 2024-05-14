import 'package:flutter/material.dart';

class NotiScreen extends StatefulWidget {
  const NotiScreen({Key? key}) : super(key: key);

  @override
  _NotiScreenState createState() => _NotiScreenState();
}

class _NotiScreenState extends State<NotiScreen> {
  final List<String> popularVariants = [
    'Capacity',
    'Color',
    'Flavor',
    'Size',
    'Weight'
  ];
  final List<String> otherVariants = [
    'Bundle',
    'Certification',
    'Compatibility',
    'Dimension',
    'Finish',
    'Length',
    'Material',
    'Packaging'
  ];

  String searchText = '';
  List<String> selectedPopularVariants = [];
  List<String> selectedOtherVariants = [];

  bool? noneSelected;

  @override
  Widget build(BuildContext context) {
    List<String> allSelectedItems = [
      ...selectedPopularVariants,
      ...selectedOtherVariants
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Test File'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              List<String> tempPopular =
                  List<String>.from(selectedPopularVariants);
              List<String> tempOther = List<String>.from(selectedOtherVariants);

              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder: (BuildContext context, setState) {
                      return Dialog(
                        child: SingleChildScrollView(
                          child: Container(
                            width: 500,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Variant Products',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Icon(Icons.close),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      searchText = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Search...',
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                const Divider(color: Colors.grey),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: noneSelected,
                                      onChanged: (value) {
                                        setState(() {
                                          noneSelected = value!;
                                          tempPopular.clear();
                                          tempOther.clear();
                                        });
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                    ),
                                    const Text('None',
                                        style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                                const Divider(color: Colors.grey),
                                const Text(
                                  'Popular Variants',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Color(0xFFA4A4A4),
                                      fontFamily: 'Avenir'),
                                ),
                                _buildCheckboxGrid(
                                    popularVariants, tempPopular, setState),
                                const Divider(color: Colors.grey),
                                const Text(
                                  'Other Variants',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Color(0xFFA4A4A4),
                                      fontFamily: 'Avenir'),
                                ),
                                _buildCheckboxGrid(
                                    otherVariants, tempOther, setState),
                                const Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                    height: 20),
                                Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: 212,
                                    height: 49,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          selectedPopularVariants = tempPopular;
                                          selectedOtherVariants = tempOther;
                                          if (tempPopular.isEmpty &&
                                              tempPopular.isEmpty) {
                                            noneSelected = true;
                                          } else {
                                            noneSelected = false;
                                          }
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        backgroundColor: Colors.blue,
                                      ),
                                      child: const Text(
                                        'Next',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ).then((_) {
                setState(() {});
              });
            },
            child: Text(
              allSelectedItems.isNotEmpty
                  ? allSelectedItems.join(", ")
                  : 'Select Variants',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: List.generate(
              allSelectedItems.length,
              (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: ListTile(title: Text(allSelectedItems[index])),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxGrid(List<String> items, List<String> selectedItems,
      void Function(void Function()) setState) {
    return SizedBox(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        childAspectRatio: 4,
        shrinkWrap: true,
        children: items.map((item) {
          return Row(
            children: [
              Checkbox(
                value: selectedItems.contains(item),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      selectedItems.add(item);
                    } else {
                      selectedItems.remove(item);
                    }
                    noneSelected = selectedItems.isEmpty;
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
              Text(item, style: const TextStyle(fontSize: 10)),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class SelectedItemDialog extends StatelessWidget {
  final String selectedItem;

  const SelectedItemDialog({Key? key, required this.selectedItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if the selected item is 'Color'
    if (selectedItem.toLowerCase() == 'color') {
      // If selected item is 'Color', show ColorDialog
      return const ColorBox();
    } else if (selectedItem.toLowerCase() == 'size') {
      return const SizeBox();
    } else {
      // Otherwise, show the default dialog
      return AlertDialog(
        title: Text('Selected Item: $selectedItem'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text('Close'),
          ),
        ],
      );
    }
  }
}

class ColorBox extends StatefulWidget {
  const ColorBox({Key? key}) : super(key: key);

  @override
  _ColorBoxState createState() => _ColorBoxState();
}

class _ColorBoxState extends State<ColorBox> {
  final List<String> popularVariants = [
    'Black',
    'Blue',
    'Green',
    'White',
    'Yellow'
  ];
  final List<String> otherVariants = [
    'Beige',
    'Brown',
    'charcoal',
    'Coral',
    'Cyan',
    'Gold',
    'Grey',
    'Indigo',
    'Ivory',
    'Lavendar'
  ];

  String searchText = '';
  List<String> selectedPopularVariants = [];
  List<String> selectedOtherVariants = [];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 500,
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Color',
                  style: TextStyle(fontSize: 18.0),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            const Divider(color: Colors.grey, thickness: 1, height: 20),
            const SizedBox(height: 8.0),
            const Text(
              'Popular Variants',
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFFA4A4A4),
                  fontFamily: 'Avenir'),
            ),
            CheckboxGrid(
              items: popularVariants,
              selectedItems: selectedPopularVariants,
              setState: setState,
            ),
            const Divider(color: Colors.grey),
            const Text(
              'Other Variants',
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFFA4A4A4),
                  fontFamily: 'Avenir'),
            ),
            CheckboxGrid(
              items: otherVariants,
              selectedItems: selectedOtherVariants,
              setState: setState,
            ),
            const Divider(color: Colors.grey, thickness: 1, height: 20),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 212,
                height: 49,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // You can perform additional actions here
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('OK'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckboxGrid extends StatelessWidget {
  final List<String> items;
  final List<String> selectedItems;
  final void Function(void Function()) setState;

  const CheckboxGrid({
    required this.items,
    required this.selectedItems,
    required this.setState,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 0,
        childAspectRatio: 4,
        shrinkWrap: true,
        children: items.map((item) {
          return Row(
            children: [
              Checkbox(
                visualDensity: VisualDensity.compact,
                value: selectedItems.contains(item),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      selectedItems.add(item);
                    } else {
                      selectedItems.remove(item);
                    }
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
              Text(item, style: const TextStyle(fontSize: 10)),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class SizeBox extends StatefulWidget {
  const SizeBox({Key? key}) : super(key: key);

  @override
  _SizeBoxState createState() => _SizeBoxState();
}

class _SizeBoxState extends State<SizeBox> {
  final List<String> popularVariants = [
    'Small',
    'Medium',
    'Large',
  ];
  final List<String> otherVariants = [
    'XXS',
    'Extra-small(XS)',
    'Extra-large(XL)',
    'XXL',
    '2XL',
    '3XL',
    '4XL',
    'Petite size',
    'Tall size',
    'Regular size'
  ];
  String searchText = '';
  List<String> selectedPopularVariants = [];
  List<String> selectedOtherVariants = [];
  @override
  Widget build(BuildContext context) {
    List<String> allSelectedItems = [
      ...selectedPopularVariants,
      ...selectedOtherVariants
    ];
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          width: 500,
          margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Size',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              const Divider(color: Colors.grey, thickness: 1, height: 20),
              const Text(
                'Popular Variants',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFFA4A4A4),
                    fontFamily: 'Avenir'),
              ),
              CheckboxGrid(
                items: popularVariants,
                selectedItems: selectedPopularVariants,
                setState: setState,
              ),
              const Divider(color: Colors.grey),
              const Text(
                'Other Variants',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFFA4A4A4),
                    fontFamily: 'Avenir'),
              ),
              CheckboxGrid(
                items: otherVariants,
                selectedItems: selectedOtherVariants,
                setState: setState,
              ),
              Row(
                children: [
                  IconButton(
                    color: Colors.blue,
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      // Add your onPressed logic here
                    },
                  ),
                  const Text('Add column',
                      style: TextStyle(fontSize: 10, color: Colors.blue)),
                ],
              ),
              const Divider(color: Colors.grey, thickness: 1, height: 20),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 212,
                  height: 49,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'OK',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
