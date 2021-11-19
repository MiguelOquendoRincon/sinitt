import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sinitt/utils/hexcolor.dart';
import 'package:sinitt/utils/screen_size.dart';
import 'package:sinitt/utils/text_style.dart';


class AppDrawer extends StatefulWidget {
  const AppDrawer({ Key? key }) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  // final formatter = DateFormat('yyyy-MM-dd hh:mm');hh:mm a
  final hourFormatter = DateFormat('hh:mm a');
  final formatter = DateFormat('dd-MM-yyyy');
  DateTime date = DateTime.now();
  TextStyles textStyles = TextStyles();
  String? departamentoValue = 'Departamento';
  String? ciudadValue = 'Ciudad/Municipio';
  String? viaValue = 'Vía';
  DateTime currentDate = DateTime.now();
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Container(
            height: ScreenSize.screenHeight * 0.25,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30)
              ),
            ),
            child: Column(
              crossAxisAlignment : CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                  child: Text(
                    'Bogotá',
                    style: textStyles.whiteText(
                      fontSize: ScreenSize.screenWidth * 0.040
                    ),
                  ),
                ),
                Container(
                  width: ScreenSize.screenWidth * 0.45,
                  margin: const EdgeInsets.only(bottom: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        hourFormatter.format(date).toLowerCase(),
                        style: textStyles.whiteText(
                          fontSize: ScreenSize.screenWidth * 0.040
                        ),
                      ),
                      Icon(
                        Icons.brightness_1,
                        size: 10.0, 
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                      ),
                      Text(
                        formatter.format(date),
                        style: textStyles.whiteText(
                          fontSize: ScreenSize.screenWidth * 0.040
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2
                        )
                      ),
                      child: Icon(
                        Icons.person_outline_outlined,
                        size: ScreenSize.screenWidth * 0.110,
                        color: Colors.white,
                      )
                    ),
                    Text(
                      'Usuario General',
                      style: textStyles.whiteText(
                        fontSize: ScreenSize.screenWidth * 0.060
                      ),
                    )
                  ],
                )
              ],
            )
          ),
          Container (
            height: ScreenSize.screenHeight * 0.71,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            color: Colors.white,
            child:  Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColor
                  ),
                  title: Text(
                    'Realizar búsqueda',
                    style: textStyles.blueText(
                      context: context,
                      fontSize: ScreenSize.screenWidth * 0.0350
                    ),
                  ),
                  onTap: () => _showSearchFilter(),
                ),

                ListTile(
                  leading: Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor
                  ),
                  title: Text(
                    'Reporte de incidentes',
                    style: textStyles.blueText(
                      context: context,
                      fontSize: ScreenSize.screenWidth * 0.0350
                    ),
                  ),
                ),

                Divider(color: Theme.of(context).primaryColor,)
              ]
            ),
          )
        ],
      ),
    );
  }

  _showSearchFilter(){
    // Navigator.pop(context);
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30)
        ),
      ),
      context: context, 
      builder: (_){
        return StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    width: ScreenSize.screenWidth * 0.85,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.search,
                          color: Theme.of(context).cardColor,
                          size: ScreenSize.screenWidth * 0.0850,
                        ),
                        Text(
                          'Filtro de búsqueda',
                          style: textStyles.blackText(
                            fontSize: ScreenSize.screenWidth * 0.0500,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context), 
                          icon: Icon(
                          Icons.close,
                            color: Theme.of(context).primaryColor,
                            size: ScreenSize.screenWidth * 0.0700,
                          ),
                        )
                      ],
                    ),
                  ),

                  _containerDropDown(
                    DropdownButton<String>(
                      isDense: true,
                      isExpanded: true,
                      value: departamentoValue,
                      dropdownColor: Colors.white,
                      icon: RotatedBox(
                        quarterTurns: 1,
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Theme.of(context).cardColor,
                        )
                      ),
                      iconSize: 24,
                      elevation: 16,
                      style: departamentoValue == 'Departamento' ? textStyles.greyText() :textStyles.blackText(),
                      underline: Container(),
                      onChanged: (String? newValue) {
                        setState(() {
                          departamentoValue = newValue!;
                        });
                      },
                      items: <String>['Departamento', 'Antioquia', 'Bogotá D.C', 'Santander']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),

                  _containerDropDown(
                    DropdownButton<String>(
                      isDense: true,
                      isExpanded: true,
                      value: ciudadValue,
                      dropdownColor: Colors.white,
                      icon: RotatedBox(
                        quarterTurns: 1,
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Theme.of(context).cardColor,
                        )
                      ),
                      iconSize: 24,
                      elevation: 16,
                      style: ciudadValue == 'Ciudad/Municipio' ? textStyles.greyText() :textStyles.blackText(),
                      underline: Container(),
                      onChanged: (String? newValue) {
                        setState(() {
                          ciudadValue = newValue!;
                        });
                      },
                      items: <String>['Ciudad/Municipio', 'Medellín', 'Bogotá D.C', 'Bucaramanga']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),

                  _containerDropDown(
                    DropdownButton<String>(
                      isDense: true,
                      isExpanded: true,
                      value: viaValue,
                      dropdownColor: Colors.white,
                      icon: RotatedBox(
                        quarterTurns: 1,
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Theme.of(context).cardColor,
                        )
                      ),
                      iconSize: 24,
                      elevation: 16,
                      style: viaValue == 'Vía' ? textStyles.greyText() :textStyles.blackText(),
                      underline: Container(),
                      onChanged: (String? newValue) {
                        setState(() {
                          viaValue = newValue!;
                        });
                      },
                      items: <String>['Vía', 'Carrera', 'Calle', 'Diagonal']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),


                  _containerDropDown(
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            currentDate.day == DateTime.now().day 
                            ?'Fecha' 
                            :DateFormat('dd/MMM/yyyy').format(currentDate),
                            style: textStyles.greyText(),
                          ),

                          Icon(
                            Icons.calendar_today,
                            color: Theme.of(context).cardColor,
                          )

                        ],
                      ),
                      onTap: () async{
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          locale: const Locale('es', 'CO'),
                          initialDate: DateTime.now(), 
                          firstDate: DateTime(1900), 
                          lastDate: DateTime(2100)
                        );
                        if (pickedDate != null && pickedDate != currentDate) {
                          setState(() {
                            currentDate = pickedDate;
                          });
                        }
                      }
                    )
                  ),

                  Container(
                    width: ScreenSize.screenWidth * 0.85,
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: SizedBox(
                      width: ScreenSize.screenWidth * 0.30,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Theme.of(context).cardColor),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          )
                        ),
                        onPressed: (){}, 
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'BUSCAR',
                              style: textStyles.whiteText(),
                            ),

                            const Icon(
                              Icons.search,
                              color: Colors.white,
                            )
                          ]
                        )
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        );
      }
    );
  }


  // *@params child: Recibe el widget, se usará para listar las opciones
  Widget _containerDropDown( Widget child){
    return Container(
      width: ScreenSize.screenWidth * 0.85,
      height: 60.0,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.5),
            offset: const Offset(1.5, 2.5),
            blurRadius: 8,
            spreadRadius: 2.5
          )
        ]
      ),
      child: child
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      locale: const Locale('es', 'CO'),
      initialDate: DateTime.now(), 
      firstDate: DateTime(1900), 
      lastDate: DateTime(2100)
    );
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
      });
    }
  }

}