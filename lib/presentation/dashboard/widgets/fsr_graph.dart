import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';

class FSRGraph extends StatelessWidget {
  final String title;
  final List<Feature> features;
  final List<String> labelX;
  final int length;

  FSRGraph({
    required this.title,
    required this.features,
    required this.labelX,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: features
                .map((feature) => _buildLegend(feature.title, feature.color))
                .toList(),
          ),
        ),
        SizedBox(
          height: 300,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: LineGraph(
              features: features,
              size: Size(length * 60.0, 300),
              labelX: labelX,
              labelY: ['200', '400', '600', '800', '1000'],
              graphColor: Colors.blue,
              graphOpacity: 0.2,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildLegend(String title, Color color) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        const SizedBox(width: 5),
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
