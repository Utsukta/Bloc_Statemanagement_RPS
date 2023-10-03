import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

// ignore: must_be_immutable
class CustomInputFieldwithlabel extends StatefulWidget {
  final String hinttext; //hint text for email and password input fields.
  final String label; //label text
  final FormFieldValidator<String> validator;
  final TextEditingController controller;

  final Function(String) onchanged;
  bool isPassword;

  //FormFieldValidator<String> is a
  //function type that takes a String parameter and returns a String or null.

  //Constructor

  CustomInputFieldwithlabel(
      {super.key,
      required this.onchanged,
      required this.label,
      required this.hinttext,
      required this.controller,
      required this.validator,
      this.isPassword = false});

  @override
  State<CustomInputFieldwithlabel> createState() =>
      _CustomInputFieldwithlabelState();
}

bool ishidden = true;

class _CustomInputFieldwithlabelState extends State<CustomInputFieldwithlabel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 17,
            color: Color.fromARGB(255, 96, 95, 95),
            fontWeight: FontWeight.w600,
          ),
        ),
        TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: widget.onchanged,
            obscureText: widget.isPassword ? ishidden : false,
            controller: widget.controller,
            validator: widget.validator,
            decoration: InputDecoration(
              errorMaxLines: 2,
              suffixIcon: widget.isPassword
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          ishidden = !ishidden;
                        });
                      },
                      child: ishidden
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off))
                  : const SizedBox(),
              hintStyle: const TextStyle(
                color: Color.fromARGB(255, 120, 117, 117),
              ),
              hintText: widget.hinttext,
            )),
      ],
    );
  }
}

class CustomButtonwithlabel extends StatelessWidget {
  final String label;
  final Color? color;
  final TextStyle? textstyle;
  final Function onPressed; //can give VoidCallback also

  const CustomButtonwithlabel({
    super.key,
    required this.label,
    required this.onPressed,
    this.textstyle,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: color ?? const Color.fromARGB(255, 13, 102, 174),
        ),
        onPressed: () {
          onPressed();
        },
        child: Text(label,
            style: textstyle ??
                const TextStyle(color: Colors.white, fontSize: 17)),
      ),
    );
  }
}

class CustomButtonWithImageAndLabel extends StatelessWidget {
  final String image;
  final String label;
  const CustomButtonWithImageAndLabel(
      {super.key, required this.label, required this.image});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image, height: 20),
              const SizedBox(width: 15),
              Text(
                label,
                style: const TextStyle(color: Colors.black, fontSize: 15),
              )
            ],
          ),
        ));
  }
}

class CustomButtonWithImage extends StatelessWidget {
  final String image;
  final String label;
  const CustomButtonWithImage(
      {super.key, required this.image, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          onPressed: () {},
          child: SvgPicture.network(image),
        ),
        const SizedBox(height: 7),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class CustomButtonWithIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  const CustomButtonWithIcon(
      {super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
            onPressed: () {},
            child: Icon(
              icon,
              color: Colors.black,
              size: 35,
            )),
        const SizedBox(height: 7),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class CustomContainerWithInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String name;
  final InputDecoration decoration;
  final String image;
  final IconData? icon;
  final Function(String)? onchanged;
  final BoxBorder? border;
  bool readonly;
  int? maxlength;

  CustomContainerWithInputField(
      {required this.decoration,
      required this.image,
      required this.name,
      required this.label,
      this.controller,
      this.icon,
      this.onchanged,
      this.border,
      required this.readonly,
      this.maxlength,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: border ??
                Border.all(color: const Color.fromARGB(255, 200, 198, 198))),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 10,
                backgroundImage: AssetImage(image),
                backgroundColor: const Color.fromARGB(255, 182, 181, 181),
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Icon(icon),
              const Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 10),
                    ),
                    SizedBox(
                      width: 190,
                      height: 20,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        readOnly: readonly,
                        inputFormatters: [
                          ThousandsFormatter(),
                          LengthLimitingTextInputFormatter(maxlength),
                        ],
                        onChanged: onchanged,
                        maxLines: 1,
                        textAlign: TextAlign.end,
                        decoration: decoration,
                        controller: controller,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class CustomAlertDialogBox extends StatefulWidget {
  final IconData icon;
  final String buttontext;
  final String message;
  final String title;
  final Function onPressed;
  final Color color;
  const CustomAlertDialogBox(
      {required this.icon,
      required this.message,
      required this.buttontext,
      required this.onPressed,
      required this.title,
      required this.color,
      super.key});

  @override
  State<CustomAlertDialogBox> createState() => _CustomAlertDialogBoxState();
}

class _CustomAlertDialogBoxState extends State<CustomAlertDialogBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: Builder(builder: (context) {
        return SizedBox(
          height: 250,
          width: 300,
          child: Column(
            children: [
              Stack(alignment: Alignment.center, children: [
                const Icon(
                  Icons.circle,
                  size: 100,
                  color: Color.fromARGB(255, 247, 233, 233),
                ),
                Icon(
                  Icons.circle,
                  size: 80,
                  color: widget.color,
                ),
                Icon(
                  widget.icon,
                  color: Colors.white,
                  size: 40,
                )
              ]),
              Text(widget.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 15),
              Text(widget.message),
              const SizedBox(height: 20),
              CustomButtonwithlabel(
                  label: widget.buttontext, onPressed: widget.onPressed),
            ],
          ),
        );
      }),
    );
  }
}
