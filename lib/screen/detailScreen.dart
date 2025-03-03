import 'package:flutter/material.dart';
import 'package:real_estate_app/model/propertyModel.dart';

class DetailScreen extends StatelessWidget {
  final Property property;

  DetailScreen({required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(property.title)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(property.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('ที่ตั้ง: ${property.location}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('ราคา: ฿${property.price}', style: TextStyle(fontSize: 16, color: Colors.green)),
            SizedBox(height: 16),

            // แสดงจำนวนห้องนอน ห้องน้ำ ห้องครัว พร้อมไอคอน
            Row(
              children: [
                Icon(Icons.bed, color: Colors.blue),
                SizedBox(width: 4),
                Text('${property.bedrooms} ห้องนอน', style: TextStyle(fontSize: 16)),

                SizedBox(width: 16),

                Icon(Icons.bathtub, color: Colors.blue),
                SizedBox(width: 4),
                Text('${property.bathrooms} ห้องน้ำ', style: TextStyle(fontSize: 16)),

                SizedBox(width: 16),

                Icon(Icons.kitchen, color: Colors.blue),
                SizedBox(width: 4),
                Text('${property.kitchens} ห้องครัว', style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
