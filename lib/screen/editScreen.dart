import 'package:flutter/material.dart';
import 'package:real_estate_app/model/propertyModel.dart';

class EditScreen extends StatefulWidget {
  final Property property;

  EditScreen({required this.property});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController titleController;
  late TextEditingController locationController;
  late TextEditingController priceController;
  late TextEditingController bedroomController;
  late TextEditingController bathroomController;
  late TextEditingController kitchenController;
  late DateTime selectedDate;
  late String selectedType; // เพิ่มตัวแปรเก็บประเภทอสังหาฯ

  final List<String> propertyTypes = [
    'บ้านเดี่ยว',
    'ทาวน์เฮ้าส์',
    'คอนโดมิเนียม',
    'อาคารพาณิชย์',
    'ที่ดินเปล่า',
    'หอพัก/อพาร์ตเมนต์',
    'โฮมออฟฟิศ',
    'รีสอร์ท/โรงแรม',
  ];

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.property.title);
    locationController = TextEditingController(text: widget.property.location);
    priceController =
        TextEditingController(text: widget.property.price.toString());
    bedroomController =
        TextEditingController(text: widget.property.bedrooms.toString());
    bathroomController =
        TextEditingController(text: widget.property.bathrooms.toString());
    kitchenController =
        TextEditingController(text: widget.property.kitchens.toString());
    selectedDate = widget.property.datePosted;
    selectedType = widget.property.type; // กำหนดค่าเริ่มต้นของประเภท
  }

  void _saveChanges() {
    if (titleController.text.isNotEmpty &&
        locationController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        bedroomController.text.isNotEmpty &&
        bathroomController.text.isNotEmpty &&
        kitchenController.text.isNotEmpty) {
      final updatedProperty = Property(
        id: widget.property.id,
        title: titleController.text,
        location: locationController.text,
        price: double.tryParse(priceController.text) ?? widget.property.price,
        bedrooms: int.tryParse(bedroomController.text) ?? widget.property.bedrooms,
        bathrooms: int.tryParse(bathroomController.text) ?? widget.property.bathrooms,
        kitchens: int.tryParse(kitchenController.text) ?? widget.property.kitchens,
        type: selectedType, // อัปเดตค่าประเภท
        datePosted: selectedDate,
      );

      Navigator.pop(context, updatedProperty);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('แก้ไขอสังหาริมทรัพย์')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'ชื่ออสังหาริมทรัพย์'),
            ),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'ที่ตั้ง'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'ราคา (บาท)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: bedroomController,
              decoration: InputDecoration(labelText: 'จำนวนห้องนอน'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: bathroomController,
              decoration: InputDecoration(labelText: 'จำนวนห้องน้ำ'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: kitchenController,
              decoration: InputDecoration(labelText: 'จำนวนห้องครัว'),
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 16),

            // Dropdown สำหรับเลือกประเภทอสังหาฯ
            DropdownButtonFormField<String>(
              value: selectedType,
              decoration: InputDecoration(labelText: 'ประเภทอสังหาริมทรัพย์'),
              items: propertyTypes.map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedType = newValue!;
                });
              },
            ),

            SizedBox(height: 16),

            ElevatedButton(
              onPressed: _saveChanges,
              child: Text('บันทึก'),
            ),
          ],
        ),
      ),
    );
  }
}
