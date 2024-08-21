import 'package:erezervisi_mobile/shared/style.dart';
import 'package:flutter/material.dart';

class ConfirmationModal extends StatelessWidget {
  final String confirmText;
  final String cancelText;
  final String title;
  final String description;
  final VoidCallback? onSave;
  final VoidCallback? onCancel;
  final bool enablePopOnCancel;
  final bool enablePopOnConfirm;

  const ConfirmationModal({
    super.key,
    this.confirmText = "Confirm",
    this.cancelText = "Cancel",
    this.title = "Warning!",
    this.description = "Are you sure you want delete this photo?",
    this.onSave,
    this.onCancel,
    this.enablePopOnCancel = true,
    this.enablePopOnConfirm = true,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: SizedBox(
        height: 150,
        child: Column(children: [
          Container(
            alignment: FractionalOffset.centerLeft,
            width: double.infinity,
            height: 40,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.black, fontFamily: "Arial", fontSize: 16),
              ),
            ),
          ),
          Container(
            alignment: FractionalOffset.centerLeft,
            height: 40,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                description,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Arial",
                    color: Style.primaryColor70),
              ),
            ),
          ),
          SizedBox(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Spacer(),
                  SizedBox(
                    width: 110,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                        overlayColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 242, 241, 241),
                        ),
                      ),
                      onPressed: () {
                        onCancel?.call();
                        if (enablePopOnCancel) {
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        cancelText,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 110,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Style.errorColor,
                      ),
                      onPressed: () {
                        onSave?.call();
                        if (enablePopOnConfirm) {
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        confirmText,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
