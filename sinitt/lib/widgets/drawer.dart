import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:sinitt/utils/hexcolor.dart';
import 'package:sinitt/utils/icons.dart';
import 'package:sinitt/utils/screen_size.dart';
import 'package:sinitt/utils/text_style.dart';
import 'package:table_calendar/table_calendar.dart';


class AppDrawer extends StatefulWidget {
  const AppDrawer({ Key? key }) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> with TickerProviderStateMixin{
  // final formatter = DateFormat('yyyy-MM-dd hh:mm');hh:mm a
  final hourFormatter = DateFormat('hh:mm a');
  final formatter = DateFormat('dd-MM-yyyy');
  DateTime date = DateTime.now();
  TextStyles textStyles = TextStyles();
  String? departamentoValue = 'Departamento';
  String? ciudadValue = 'Ciudad/Municipio';
  String? viaValue = 'Vía';
  String? claseIncidente = 'Escoger';
  String? tipoIncidente = 'Escoger';
  DateTime currentDate = DateTime.now();
  AnimationController? _animationController;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _animationController!.forward();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // elevation: 0.0,
      width: ScreenSize.screenWidth * 0.8,
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
                        
                      ),
                      child: Icon(
                        SinittIcons.icono_user,
                        size: ScreenSize.screenWidth * 0.110,
                        color: Colors.white,
                      )
                    ),
                    Text(
                      'Usuario General',
                      style: textStyles.whiteText(
                        fontSize: ScreenSize.screenWidth * 0.055
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
                  onTap: () => _newIncidente(),
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
                            color: HexColor('#1C4780'),
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
                      focusColor: Colors.blue,
                      
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
                          onTap: (){
                            print('HOLAAAA');
                          },
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
                        await _calendarDemo().then((value){
                          if (value != null && value != currentDate) setState(() => currentDate = value);
                        });
                        // if (_selectedDay != null && _selectedDay != currentDate) {
                        //   setState(() {
                        //     currentDate = _selectedDay;
                        //   });
                        // }
                        // final DateTime? pickedDate = await showDatePicker(
                        //   context: context,
                        //   locale: const Locale('es', 'CO'),
                        //   initialDate: DateTime.now(), 
                        //   firstDate: DateTime(1900), 
                        //   lastDate: DateTime(2100),
                        //   builder: (_, __){
                        //     return TableCalendar(
                        //       firstDay: DateTime(1900), 
                        //       lastDay: DateTime(2100), 
                        //       focusedDay: DateTime.now(), 
                              
                        //     );
                        //   }
                        // );
                        // if (pickedDate != null && pickedDate != currentDate) {
                        //   setState(() {
                        //     currentDate = pickedDate;
                        //   });
                        // }
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

  Future _calendarDemo(){
    return showModalBottomSheet(
      context: context, 
      builder: (_){
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              color: Colors.white,
              child: Column(
                children: [
                  TableCalendar(
                    currentDay: _selectedDay,
                    locale: 'es',
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true
                    ),
                    calendarStyle: const CalendarStyle(
                      canMarkersOverflow: true,
                      selectedTextStyle: TextStyle(color: Colors.red)
                    ),
                    calendarBuilders: CalendarBuilders(
                      selectedBuilder: (context, date, _){
                        return FadeTransition(
                          opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController!),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue
                            ),
                            child: Text('${date.day}', style: const TextStyle(color: Colors.white),),
                          ),
                        );
                      },

                      todayBuilder: (context, date, _){
                        return Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: HexColor('#3366CC')
                          ),
                          child: Text('${date.day}', style: TextStyle(color: Colors.white),),
                        );
                      }
                    ),
                    onDaySelected: (selectedDay, focusedDay) {
                      _animationController!.forward(from: 0.0);
                      setState(() =>_selectedDay = selectedDay);
                    },
                    onPageChanged: (focusedDay) => _focusedDay = focusedDay,
                    firstDay: DateTime(1900), 
                    lastDay: DateTime(2100),
                    focusedDay: _focusedDay,
                    calendarFormat: CalendarFormat.month,
                  ),
                  Container(
                    width: ScreenSize.screenWidth,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 15.0),
                    child: TextButton(
                      child: Text('Seleccionar'),
                      onPressed: () => Navigator.of(context).pop(_selectedDay)
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

  _newIncidente(){
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
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
              //Usando el setstate saber si el teclado está habitlitado para extender la altura del contenedor padre
              child: Column(
                children: [
                  Container(
                    width: ScreenSize.screenWidth * 0.12,
                    margin: const EdgeInsets.only(top: 20.0),
                    height: 6.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Theme.of(context).primaryColor
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    width: ScreenSize.screenWidth * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reporte de incidentes',
                          style: textStyles.blueText(
                            context: context,
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

                  Container(
                    width: ScreenSize.screenWidth,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ubicación',
                          style: textStyles.greyText(
                            context: context,
                            fontSize: ScreenSize.screenWidth * 0.03800
                          ),
                        ),

                        Container(
                          height: 40.0,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 8.0, bottom: 15.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(bottom: 5.0, left: 10.0, right: 10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: Icon(
                                Icons.search,
                                color: Theme.of(context).primaryColor,
                                size: ScreenSize.screenWidth * 0.0500,
                              )
                            ),
                          ),
                        ),

                        Text(
                          'Clase de incidente',
                          style: textStyles.greyText(
                            context: context,
                            fontSize: ScreenSize.screenWidth * 0.03800
                          ),
                        ),

                        Container(
                          height: 40.0,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 8.0, bottom: 15.0),
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: HexColor('#BCBBBB')
                            )
                          ),
                          child: DropdownButton<String>(
                            isDense: true,
                            isExpanded: true,
                            value: claseIncidente,
                            dropdownColor: Colors.white,
                            icon: RotatedBox(
                              quarterTurns: 1,
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Theme.of(context).cardColor,
                              )
                            ),
                            iconSize: ScreenSize.screenWidth * 0.0500,
                            elevation: 16,
                            style: claseIncidente == 'Escoger' ? textStyles.greyText(context: context, lightGrey: true) :textStyles.blackText(),
                            underline: Container(),
                            onChanged: (String? newValue) {
                              setState(() {
                                claseIncidente = newValue!;
                              });
                            },
                            items: <String>['Escoger', 'Accidente', 'Condiciones de la superficie de la carreter', 'Malas condiciones ambientales', 'Obstrucción', 'Infraestructura dañada']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),


                        Text(
                          'Tipo de incidente',
                          style: textStyles.greyText(
                            context: context,
                            fontSize: ScreenSize.screenWidth * 0.03800
                          ),
                        ),

                        Container(
                          height: 40.0,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 8.0, bottom: 15.0),
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: HexColor('#BCBBBB')
                            )
                          ),
                          child: DropdownButton<String>(
                            isDense: true,
                            isExpanded: true,
                            value: tipoIncidente,
                            dropdownColor: Colors.white,
                            icon: RotatedBox(
                              quarterTurns: 1,
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Theme.of(context).cardColor,
                              )
                            ),
                            iconSize: ScreenSize.screenWidth * 0.0500,
                            elevation: 16,
                            style: tipoIncidente == 'Escoger' ? textStyles.greyText(context: context, lightGrey: true) :textStyles.blackText(),
                            underline: Container(),
                            onChanged: (String? newValue) {
                              setState(() {
                                tipoIncidente = newValue!;
                              });
                            },
                            items: <String>['Escoger', 'Choque Simple', 'Choque Multiple']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),

                        Text(
                          'Descripción',
                          style: textStyles.greyText(
                            context: context,
                            fontSize: ScreenSize.screenWidth * 0.03800
                          ),
                        ),

                        Container(
                          height: 150.0,
                          margin: const EdgeInsets.only(top: 8.0, bottom: 15.0),
                          child: TextField(
                            minLines: null,
                            maxLines: null,
                            expands: true,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              hintText: 'Breve descripción del incidente',
                              hintStyle: textStyles.greyText(context: context, lightGrey: true),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: HexColor('#BCBBBB')
                                )
                                
                              ),
                            ),
                          ),
                        ),

                        Text(
                          'Evidencia',
                          style: textStyles.greyText(
                            context: context,
                            fontSize: ScreenSize.screenWidth * 0.03800
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8.0, bottom: 15.0),
                          child: Text(
                            'Tipo de archivo permitido .jpg y .mp4 de hasta xMB',
                            style: textStyles.greyText(
                              context: context,
                              fontSize: ScreenSize.screenWidth * 0.03500
                            ),
                          ),
                        ),

                        DottedBorder(
                          color: Colors.blue,
                          child: Container(
                            height: 150.0,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.attach_file_outlined,
                                  color: Colors.blue,
                                  size: ScreenSize.screenWidth * 0.0500,
                                ),
                                Text(
                                  '''Arrastre aquí su(s) archivo(s) 
o haga click para añadir''',
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style: textStyles.blueText(
                                  fontSize: ScreenSize.screenWidth * 0.03500
                                ),
                                ),
                              ],
                            )
                          ),
                        ),

                        Container(
                          width: ScreenSize.screenWidth * 0.85,
                          alignment: Alignment.centerRight,
                          margin: const EdgeInsets.only(bottom: 20.0, top: 8.0),
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
                              child: Text(
                                'Crear reporte',
                                style: textStyles.whiteText(),
                              ),
                            ),
                          ),
                        ),
                      ],
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