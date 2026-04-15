import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

/// Simple deterministic avatar derived from an Ethereum address string.
class WalletIdenticon extends StatelessWidget {
  /// Creates a small circular identicon for [address].
  const WalletIdenticon({super.key, required this.address, this.size = 40});

  /// Hex address with or without `0x`.
  final String address;

  /// Diameter in logical pixels.
  final double size;

  @override
  Widget build(BuildContext context) {
    if (address.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.person, color: Colors.white),
      );
    }
    final String normalized = address.toLowerCase();
    final List<int> digest =
        sha256.convert(utf8.encode(normalized)).bytes.sublist(0, 3);
    final Color color = Color.fromARGB(
      255,
      digest[0],
      digest[1],
      digest[2],
    );
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        normalized.length >= 4 ? normalized.substring(2, 4).toUpperCase() : '?',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
