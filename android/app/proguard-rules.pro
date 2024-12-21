# Mantén todas las clases necesarias
-keep class javax.annotation.** { *; }
-keep class com.google.errorprone.annotations.** { *; }

# Opcional: Si el compilador sigue quejándose de referencias faltantes
-dontwarn javax.lang.model.**
-dontwarn javax.annotation.**
