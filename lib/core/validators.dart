
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'El correo electrónico es obligatorio';
  }
  final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
  if (!emailRegExp.hasMatch(value)) {
    return 'El correo electrónico no es válido';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'La contraseña es obligatoria';
  }
  if (value.length < 6) {
    return 'La contraseña debe tener al menos 6 caracteres';
  }
  final passwordRegExp = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).+$');
  if (!passwordRegExp.hasMatch(value)) {
    return 'La contraseña debe contener letras y números';
  }
  return null;
}

String? validateNamesAndSurnames(String? value) {
  if (value == null || value.isEmpty) {
    return 'El campo de nombres y apellidos es obligatorio';
  }
  
  final nameRegExp = RegExp(r'^([A-ZÁÉÍÓÚÜ][a-záéíóúü]*\s?){1,3}([A-ZÁÉÍÓÚÜ][a-záéíóúü]*\s?){1,2}$');
  
  if (!nameRegExp.hasMatch(value.trim())) {
    return 'El formato es incorrecto. Permite hasta 3 nombres y 2 apellidos, solo letras y acentos.';
  }
  
  return null;
}

String? validateChileanPhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'El número de teléfono es obligatorio';
  }

  final phoneRegExp = RegExp(r'^(?:\+56\s?)?(?:9\s?)?\d{4}\s?\d{4}$');
  
  if (!phoneRegExp.hasMatch(value.trim())) {
    return 'Debe tener el formato +56 9 1234 5678';
  }

  return null;
}
