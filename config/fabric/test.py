import fabric #importando la libreria base
from fabric import Application # preparan la clase aplicacion
from fabric.widgets.box import Box # clase Box
from fabric.widgets.label import Label # clase label
from fabric.widgets.window import Window# clase window

if __name__ == "__main__":
    box_1 = Box(
        orientation="", #vertical
        children=Label(label="this is the first box")
    )

    box_2 = Box(
        spacing=28, #agregar algo de espacio entre los hijos
        orientation="h",
        children=[
            Label(label="Este es el primer elemento en la segunda caja"),
            Label(label="por cierto, los elementos de esta caja se agregaran horizontalmente")
        ]
    )

    box_1.add(box_2) #Agregar box_2 dentro de box_1 junto con el label dentro de ahi.

    window = Window(child=box_1) #no hay necesidad de mostrar esta ventana utilizando `show_all()`; se mostraran por si sola porque los hijos ya son entregados.
    app = Application("default", window) #Defina una nueva configuracion llamada "default" el cual tiene `window`
    app.run()
