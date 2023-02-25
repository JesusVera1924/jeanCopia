import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BlackCard extends StatelessWidget {
  final String? title;
  final Widget child;
  final double? width;
  final Function funcion;
  final Function funcion2;

  const BlackCard({
    Key? key,
    required this.child,
    required this.funcion,
    required this.funcion2,
    this.title,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Row(
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    title!,
                    style: GoogleFonts.roboto(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: InkWell(
                    onTap: () => funcion(),
                    child: const Tooltip(
                      message: "Limpiar",
                      child: Icon(
                        Icons.delete_forever,
                        size: 22,
                        color: Color(0xD9b22222),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: InkWell(
                    onTap: () => funcion2(),
                    child: const Tooltip(
                      message: "Guardar",
                      child: Icon(
                        Icons.save_alt_rounded,
                        size: 22,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider()
          ],
          child
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)
          ]);
}
