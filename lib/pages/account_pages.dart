import 'package:flutter/material.dart';


class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount>{

  String _fecha  = '';
  TextEditingController _inputFieldDateController = new TextEditingController();

  String _opcionCiudad = 'Francisco Morazan';
  List<String> _ciudades = ['Francisco Morazan', 'Cortez', 'colon', 'Olancho'];

  //mirando como agregar esos iconos a las categorias
  dynamic icono1 = Icon(Icons.sports_football_sharp) ;
  dynamic icono2 = Icon(Icons.sports_handball_sharp) ;
  dynamic icono3 = Icon(Icons.sports_soccer_rounded) ;

  String _opcionCategoria = 'Principiante';
  List<String> _categorias = ['Principiante', 'Intermedio', 'Avanzado'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        body: Stack(
          children: [_crateForm(context)],
        )
    );
  }

  //Funcion para crear el fondo de la pantalla de login
  Widget _createBackground(BuildContext context) {}

  // Funcion que retorna el formulario para el apartado de inicio de seccion
  Widget _crateForm(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 10.0,
            ),
          ),
          
          Container(
            width: size.width * 0.90,
            padding: EdgeInsets.symmetric(vertical: 20.0),
            margin: EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0))
                ]),
            
            child: Column(
              children: [
                Text('Nombres'),
                SizedBox(
                  height: 5.0,
                ),
                _createName(),
                SizedBox(
                  height: 20.0,
                ),

                Text('Apellidos'),
                SizedBox(
                  height: 5.0,
                ),
                _createSurname(),
                SizedBox(
                  height: 20.0,
                ),

                Text('Numero de Identidad'),
                SizedBox(
                  height: 5.0,
                ),
                _createIdentity(),
                SizedBox(
                  height: 20.0,
                ),

                Text('Correo Electronico'),
                SizedBox(
                  height: 5.0,
                ),
                _createEmail(),
                SizedBox(
                  height: 20.0,
                ),

                Text('Telefono'),
                SizedBox(
                  height: 5.0,
                ),
                _createPhone(),
                SizedBox(
                  height: 20.0,
                ),

                Text('Ciudad'),
                SizedBox(
                  height: 5.0,
                ),
                //_createCity(),
                _createCityDropdown(),
                SizedBox(
                  height: 20.0,
                ),

                Text('Fecha de Nacimiento'),
                SizedBox(
                  height: 5.0,
                ),
                _createBirthDate(context),
                SizedBox(
                  height: 20.0,
                ),

                Text('Contraseña'),
                SizedBox(
                  height: 5.0,
                ),
                _createPass(),
                SizedBox(
                  height: 20.0,
                ),
                
                Text('Confirmar contraseña'),
                SizedBox(
                  height: 5.0,
                ),
                _createPassConfir(),
                SizedBox(
                  height: 20.0,
                ),

                Text('Categoria'),
                SizedBox(
                  height: 5.0,
                ),
                _createCategoriaDropdown(),
                SizedBox(
                  height: 30.0,
                ),
                
                _createBottom(context),
              ],
            ),

          ),

        ],
      ),
    );
  }

  //Crear el input para ingresar los nombres 
  Widget _createName() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            icon: Icon(Icons.account_box_rounded),
            hintText: 'Ejem: Juan Antonio',
            labelText: 'Primer y Segundo Nombre',
          ),
        ));
  }

    //Crear el input para ingresar los apellidos
  Widget _createSurname() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            icon: Icon(Icons.account_circle),
            hintText: 'Ejem: Perez Ramos',
            labelText: 'Primer y Segundo apellido',
          ),
        ));
  }

  //Crear el input para ingresar la identidad
  Widget _createIdentity() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            icon: Icon(Icons.tag),
            hintText: 'Ejem: 080119992000',
            labelText: 'Numero de Identidad sin Espacios',
          ),
        ));
  }

  //Crear el input para ingresar el correo electronico
  Widget _createEmail() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            icon: Icon(Icons.email),
            hintText: 'Ejem: example@example.com',
            labelText: 'Correo Electronico',
          ),
        ));
  }

  //Crear el input para ingresar el numero de telefono
  Widget _createPhone() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border:OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            icon: Icon(Icons.phone),
            hintText: 'Ejem: 88905690',
            labelText: 'Numero de telefono sin Espacios',
          ),
        ));
  }

  //funcion enlazada a crear ciudades
  List<DropdownMenuItem<String>> getCityDropdown() {
    List<DropdownMenuItem<String>> listaCiudades = new List();

    _ciudades.forEach( (ciudad){
      listaCiudades.add( DropdownMenuItem(
        child: Text(ciudad),
        value: ciudad,
      ));
    });

    return listaCiudades;
  }
  //funcion de crear ciudad
  Widget _createCityDropdown() {
    return  Container(
      child: Row(
        children: <Widget>[
          SizedBox(width: 10.0),
          Icon(Icons.room_rounded, color: Colors.black45),
          SizedBox(width: 15.0),
          
          Container(
            padding: EdgeInsets.symmetric(horizontal: 75.0),
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black38, spreadRadius: 1),
              ],
            ), 
            child: Expanded( 
              child: DropdownButton(
                value: _opcionCiudad,
                items: getCityDropdown(),
                onChanged: (opt) {
                  setState(() {
                    _opcionCiudad = opt;
                  });
                },
              ),
            ),
          ),
        
        ],
      ),
    );

  }

  //Crear el input para ingresar la fecha de nacimiento
  Widget _createBirthDate(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          enableInteractiveSelection: false,
          controller: _inputFieldDateController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border:OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            icon: Icon(Icons.calendar_today),
            labelText: 'Fecha de nacimiendo',
          ),
          onTap: (){ 

            FocusScope.of(context).requestFocus(new FocusNode());
            _selectDate( context );

          },
        )
        
    );
  }
  //funcion enlazada a crear fecha de nacimiento
  _selectDate(BuildContext context) async {

    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1960),
      lastDate: new DateTime.now(),
      locale: Locale('es', 'ES')
    );

    if ( picked != null ) {
      setState(() {
          _fecha = picked.toString();
          _inputFieldDateController.text = _fecha;
      }); 
    }

  }

  //Crear el input para ingresar la contraseña
  Widget _createPass() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            hintText: 'Ejem: PajaroAzul1980',
            labelText: 'Debe incluir Letras y Numeros',
            suffixIcon: Icon(Icons.lock_open),
            icon: Icon(Icons.lock)),
      ),
    );
  }

  //Crear el input para confirmar la contraseña
  Widget _createPassConfir() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            labelText: 'Ingrese su Contraseña Nuevamente',
            suffixIcon: Icon(Icons.lock_open),
            icon: Icon(Icons.lock)
        ),
      ),
    );
  }

  //funcion enlazada a crear categoria
  List<DropdownMenuItem<String>> getCategoriaDropdown() {
    List<DropdownMenuItem<String>> listaCategorias = new List();

    _categorias.forEach( (categoria){
      listaCategorias.add( DropdownMenuItem(
        child: Text(categoria),
        value: categoria,
      ));
    });

    return listaCategorias;
  }
  //funcion para crear categoria
  Widget _createCategoriaDropdown() {
    return  Container(
      child: Row(
        children: <Widget>[
          SizedBox(width: 10.0),
          Icon(Icons.run_circle_outlined, color: Colors.black45),
          SizedBox(width: 15.0),
          
          Container(
            padding: EdgeInsets.symmetric(horizontal: 100.0),
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black38, spreadRadius: 1),
              ],
            ), 
            child: Expanded( 
              child: DropdownButton(
                value: _opcionCategoria,
                items: getCategoriaDropdown(),
                onChanged: (opt) {
                  setState(() {
                    _opcionCategoria = opt;
                  });
                },
              ),
            ),
          ),
        
        ],
      ),
    );

  }

  //Funcion que retorna el widget que almacena el boton de registrarse
  Widget _createBottom(BuildContext context) {
    return RaisedButton(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Registrarse'),
              ])),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 0.0,
      color: Colors.blue,
      textColor: Colors.white,
      onPressed: () => _login(context),
    );
  }

  //Funcion que se ejecuta al presionar el boton "Iniciar sesion"
  _login(BuildContext context) {
    //Pendiente de completacion

    Navigator.pushReplacementNamed(context, 'home');
  }

}