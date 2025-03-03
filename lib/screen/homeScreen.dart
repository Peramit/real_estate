import 'dart:io';
import 'package:flutter/material.dart';
import 'package:real_estate_app/model/propertyModel.dart';
import 'package:real_estate_app/screen/detailScreen.dart';
import 'package:real_estate_app/screen/editScreen.dart';
import 'package:real_estate_app/screen/addScreen.dart';
import 'package:intl/intl.dart'; // ✅ เพิ่ม import นี้

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Property> properties = [];

  String? _selectedType;
  String _searchQuery = '';

  final List<String> propertyTypes = [
    'ทั้งหมด',
    'บ้านเดี่ยว',
    'ทาวน์เฮ้าส์',
    'คอนโดมิเนียม',
    'อาคารพาณิชย์',
    'ที่ดินเปล่า',
    'หอพัก/อพาร์ตเมนต์',
    'โฮมออฟฟิศ',
    'รีสอร์ท/โรงแรม',
  ];

  String _formatPrice(double? price) {
    if (price == null || price <= 0) return 'ไม่ระบุ'; // ✅ ป้องกัน null
    if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(2)} ล้าน';
    }
    return '${NumberFormat("#,###").format(price)} บาท';
  }

  void _addProperty() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddScreen()),
    );
    if (result != null && result is Property) {
      setState(() {
        properties.add(result);
      });
    }
  }

  void _editProperty(Property property) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditScreen(property: property)),
    );
    if (result != null && result is Property) {
      setState(() {
        int index = properties.indexWhere((p) => p.id == property.id);
        if (index != -1) {
          properties[index] = result;
        }
      });
    }
  }

  void _deleteProperty(int index) {
    setState(() {
      properties.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Property> filteredProperties = properties.where((property) {
      bool matchesSearch = (property.location?.contains(_searchQuery) ?? false) ||
                           property.price.toString().contains(_searchQuery);
      bool matchesType = _selectedType == null || _selectedType == 'ทั้งหมด' || property.type == _selectedType;
      return matchesSearch && matchesType;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('รายการอสังหาริมทรัพย์'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'ค้นหาโดยราคา หรือ เขตที่อยู่',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: _selectedType ?? 'ทั้งหมด',
                  items: propertyTypes.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedType = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: filteredProperties.length,
              itemBuilder: (context, index) {
                final property = filteredProperties[index];
                return Dismissible(
                  key: Key(property.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    _deleteProperty(index);
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0),
                      title: Text(
                        property.title,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${property.location} - ${_formatPrice(property.price)}',
                              style: TextStyle(fontSize: 14, color: Colors.green)),
                          Text('ลงขายเมื่อ: ${property.datePosted?.toLocal()?.toString().split(' ')[0] ?? 'ไม่ระบุ'}',
                              style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          _editProperty(property);
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailScreen(property: property)),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProperty,
        child: Icon(Icons.add),
        tooltip: 'เพิ่มรายการอสังหาริมทรัพย์',
      ),
    );
  }
}
