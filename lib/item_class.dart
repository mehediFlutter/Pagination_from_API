import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  final int id;
  final String imageName;
  final String price;
  final String? dropdownFontLight;
  final String? dropdownFontLightAnswer;
  final String? dropdownSeat;
  final String? dropdownSeatAnswer;
  final String? dropdownRoof;
  final String? dropdownRoofAnswer;
  final String? dropdownStarOption;
  final String? dropdownStarOptionAnswer;
  final String?  featureSeat;
  final String?  featureSeatDetails;
 final int?  jj;
  Item(
      {super.key,
      required this.id,
      required this.imageName,
      required this.price,
      this.dropdownFontLight,
      this.dropdownFontLightAnswer,
      this.dropdownSeat,
      this.dropdownSeatAnswer,
      this.dropdownRoof,
      this.dropdownRoofAnswer,
      this.dropdownStarOption,
      this.dropdownStarOptionAnswer, this.featureSeat, this.featureSeatDetails, this.jj});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  // yVjInK9erYHC0iHW9ehY8c6J4y79fbNzCEIWtZvQ.jpg
  //https://pilotbazar.com/storage/vehicles/
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("I am on press");
        _showAlertDialog(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Card(
          margin: EdgeInsets.only(bottom: 0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 7,
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 2),

            title: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "https://pilotbazar.com/storage/vehicles/${widget.imageName}",
                width: 50,
                height: 110,
                fit: BoxFit.fill,
              ),
            ),
            //"https://pilotbazar.com/storage/vehicles/${products[x].imageName}"
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.id.toString(), style: TextStyle(height: 0)),
                Row(
                  children: [
                    Text(
                      "R:",
                      style: TextStyle(height: 0),
                    ),
                    Text(""),
                    Text(" | "),

                    //Text(products[x].id.toString()),
                    Text("fdf"),
                    Text(" | "),
                    Text("fdf"),
                  ],
                ),
                Text("Available At (PBL)"),
                Row(
                  children: [
                    Text("Tk."),
                    SizedBox(width: 5),
                    Text("gfg"),
                  ],
                ),
                Text('d'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          title: Text("Fuatures and "),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(widget.price),
                  Text(widget.featureSeat?.toString() ?? ''),
                      Text(widget.featureSeatDetails.toString()),
                      Text("data1"),
                      Text("data1"),
                    ],
                  ),
                  Column(
                    children: [
                      Text("data2"),
                      Text("data2"),
                      Text("data2"),
                      Text("data2"),
                      Text("data2"),
                    ],
                  ),
                  Column(
                    children: [
                      Text("data3"),
                      Text("data3"),
                      Text("data3"),
                      Text("data3"),
                      Text("data3"),
                    ],
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                // Handle the confirm action
              },
            ),
          ],
        );
      },
    );
  }
}
