import 'package:flutter/material.dart';
import 'package:hps_app/module/menu/widgets/model%20.dart';
import 'package:hps_app/shared/constants/colors.dart';

class ScheduleCard extends StatelessWidget {
  final ScheduleModel model;
  final List<Widget> actions;

  const ScheduleCard({super.key, required this.model, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF294A43),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: ColorsConstants.yellowPrimary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 60,
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: ColorsConstants.text,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: ColorsConstants.yellowPrimary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
             
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            '${model.time}\n${model.date}',
                            style: const TextStyle(
                              color: ColorsConstants.text,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              height: 1.4,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: ColorsConstants.text,
                          size: 16,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                   
                    Text(
                      'Nhà tạo mẫu: ${model.stylist}',
                      style: const TextStyle(
                        color: ColorsConstants.text,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 2),
                  
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Dịch vụ: ${model.service}',
                            style: const TextStyle(
                              color: ColorsConstants.text,
                              fontSize: 13,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          model.price,
                          style: const TextStyle(
                            color: ColorsConstants.yellowPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    Row(
                      children:
                          actions
                              .map(
                                (btn) => Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    child: btn,
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
