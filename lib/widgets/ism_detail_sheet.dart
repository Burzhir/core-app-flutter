import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../data/isms_data.dart';
import 'isms_art.dart';

class IsmDetailSheet extends StatelessWidget {
  final IsmMeta ism;
  final List<Color> gradColors;

  const IsmDetailSheet({
    super.key,
    required this.ism,
    required this.gradColors,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      maxChildSize: 0.95,
      minChildSize: 0.4,
      expand: false,
      builder: (_, ctrl) => ListView(
        controller: ctrl,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.surfaceAlt,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          const SizedBox(height: 20),

          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: IsmArtWidget(
              ism: ism,
              colors: gradColors,
              height: 180,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Text(
                ism.icon,
                style: const TextStyle(fontSize: 40),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ism.name,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      ism.category,
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Container(
            height: 1,
            color: AppColors.surfaceAlt,
          ),

          const SizedBox(height: 16),

          Text(
            '"${ism.tagline}"',
            style: TextStyle(
              color: gradColors[0],
              fontSize: 16,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 16),

          _buildSectionTitle('OVERVIEW'),

          const SizedBox(height: 8),

          Text(
            ism.overview,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.7,
            ),
          ),

          const SizedBox(height: 24),

          _buildSectionTitle('HISTORICAL CONTEXT'),

          const SizedBox(height: 8),

          Text(
            ism.historicalContext,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.7,
            ),
          ),

          const SizedBox(height: 24),

          _buildSectionTitle('CORE TENETS'),

          const SizedBox(height: 8),

          ...ism.coreTenets.map(
            (t) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '• ',
                    style: TextStyle(color: AppColors.textMuted),
                  ),

                  Expanded(
                    child: Text(
                      t,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          _buildSectionTitle('NOTABLE FIGURES'),

          const SizedBox(height: 8),

          ...ism.notableFigures.map(
            (nf) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nf.name,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    nf.contribution,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          _buildSectionTitle('MODERN APPLICATION'),

          const SizedBox(height: 8),

          Text(
            ism.modernApplication,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.7,
            ),
          ),

          const SizedBox(height: 24),

          _buildSectionTitle('QUOTES'),

          const SizedBox(height: 8),

          ...ism.quotes.map(
            (q) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                q,
                style: TextStyle(
                  color: gradColors[0],
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          _buildSectionTitle('KEY WORKS'),

          const SizedBox(height: 8),

          ...ism.keyWorks.map(
            (w) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '• ',
                    style: TextStyle(color: AppColors.textMuted),
                  ),

                  Expanded(
                    child: Text(
                      w,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  gradColors[0].withValues(alpha: 0.15),
                  gradColors[1].withValues(alpha: 0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: gradColors[0].withValues(alpha: 0.35),
                width: 1.2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.bolt_rounded,
                      color: gradColors[0],
                      size: 16,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      'THE CHALLENGE',
                      style: TextStyle(
                        color: gradColors[0],
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Text(
                  ism.challenge,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 14,
          decoration: BoxDecoration(
            color: gradColors[0],
            borderRadius: BorderRadius.circular(2),
          ),
        ),

        const SizedBox(width: 8),

        Text(
          title,
          style: TextStyle(
            color: gradColors[0],
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}