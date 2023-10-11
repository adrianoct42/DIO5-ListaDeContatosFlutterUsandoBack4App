import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:listadecontatosapp/model/contato_model.dart';
import 'package:listadecontatosapp/repository/contato_repository.dart';

class AddContatoScreen extends StatefulWidget {
  AddContatoScreen(this.contatoRepository, {super.key});

  ContatoRepository contatoRepository;

  @override
  State<AddContatoScreen> createState() => _AddContatoScreenState();
}

class _AddContatoScreenState extends State<AddContatoScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nomeController = TextEditingController();
    TextEditingController numeroController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    XFile? photo;

    cropImage(XFile imageFile) async {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (croppedFile != null) {
        await GallerySaver.saveImage(croppedFile.path);
        setState(() {});
        photo = XFile(croppedFile.path);
        print(photo);
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Adicionar Contato"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                const Text("Digite o Nome:"),
                TextField(
                  maxLength: 24,
                  controller: nomeController,
                ),
                const SizedBox(height: 24),
                const Text("Digite o Telefone:"),
                TextField(
                  maxLength: 9,
                  keyboardType: TextInputType.phone,
                  controller: numeroController,
                ),
                const SizedBox(height: 24),
                const Text("Digite o E-Mail:"),
                TextField(
                  maxLength: 24,
                  controller: emailController,
                ),
                const SizedBox(height: 24),
                const Text("Foto do Contato:"),
                const SizedBox(height: 24),
                OutlinedButton(
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    photo = await picker.pickImage(source: ImageSource.gallery);
                    // cropImage(photo!);
                  },
                  child: const Text("Adicionar Foto da Galeria"),
                ),
                const SizedBox(height: 120),
                OutlinedButton(
                    onPressed: () {
                      if (nomeController.text.isNotEmpty &&
                          numeroController.text.isNotEmpty &&
                          emailController.text.isNotEmpty &&
                          photo!.path != null) {
                        widget.contatoRepository.addContato(ContatoModel.criar(
                            nomeController.text,
                            int.parse(numeroController.text),
                            emailController.text,
                            photo!.path));
                        const snackBar = SnackBar(
                          content: Text("Contato adicionado!"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Salvar"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
