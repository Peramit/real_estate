import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:real_estate_app/model/propertyModel.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _bedroomController = TextEditingController();
  final TextEditingController _bathroomController = TextEditingController();
  final TextEditingController _kitchenController = TextEditingController();

  DateTime? _selectedDate;
  String? _selectedType;

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

  void _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveProperty() {
    if (_formKey.currentState!.validate()) {
      final newProperty = Property(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        location: _locationController.text,
        price: double.parse(_priceController.text),
        bedrooms: int.parse(_bedroomController.text),
        bathrooms: int.parse(_bathroomController.text),
        kitchens: int.parse(_kitchenController.text),
        type: _selectedType ?? 'ไม่ระบุ',
        datePosted: _selectedDate ?? DateTime.now(),
      );

      Navigator.pop(context, newProperty);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เพิ่มอสังหาริมทรัพย์')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // ชิดซ้าย
            children: [
              TextFormField(controller: _titleController, decoration: InputDecoration(labelText: 'ชื่ออสังหาริมทรัพย์')),
              TextFormField(controller: _locationController, decoration: InputDecoration(labelText: 'ที่ตั้ง')),
              TextFormField(controller: _priceController, decoration: InputDecoration(labelText: 'ราคา (บาท)'), keyboardType: TextInputType.number),
              TextFormField(controller: _bedroomController, decoration: InputDecoration(labelText: 'จำนวนห้องนอน'), keyboardType: TextInputType.number),
              TextFormField(controller: _bathroomController, decoration: InputDecoration(labelText: 'จำนวนห้องน้ำ'), keyboardType: TextInputType.number),
              TextFormField(controller: _kitchenController, decoration: InputDecoration(labelText: 'จำนวนห้องครัว'), keyboardType: TextInputType.number),
              
              SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: InputDecoration(labelText: 'ประเภทอสังหาริมทรัพย์'),
                items: propertyTypes.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedType = newValue;
                  });
                },
                validator: (value) => value == null ? 'กรุณาเลือกประเภทอสังหาริมทรัพย์' : null,
              ),

              SizedBox(height: 16),

              // แสดงวันที่ที่เลือก
              if (_selectedDate != null)
                Text(
                  "วันที่เลือก: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),

              SizedBox(height: 8),

              Center(
                child: ElevatedButton(
                  onPressed: _selectDate,
                  child: Text('เลือกวันที่'),
                ),
              ),

              SizedBox(height: 24), // เพิ่มระยะห่างระหว่างปุ่มเลือกวันที่กับปุ่มบันทึก

              Center(
                child: ElevatedButton(
                  onPressed: _saveProperty,
                  child: Text('บันทึก'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
